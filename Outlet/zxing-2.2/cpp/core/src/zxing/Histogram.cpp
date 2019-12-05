//
//  Histogram.cpp
//  VINWidget
//
//  Created by ___saradhi___ on 30/11/11.
//  Copyright 2011 ___technolabssoftware___. All rights reserved.
//




#include <Histogram.h>
#include <zxing/common/IllegalArgumentException.h>
#include <zxing/common/Array.h>
#include <math.h>
#include <zxing/common/GreyscaleLuminanceSource.h>
#include <ImageProcessing.h>

namespace zxing {
    using namespace std;
    
    const int LUMINANCE_BITS = 5;
    const int LUMINANCE_SHIFT = 8 - LUMINANCE_BITS;
    const int LUMINANCE_BUCKETS = 1 << LUMINANCE_BITS;
    
    const int BLOCK_SIZE_POWER = 3;
    const int BLOCK_SIZE = 1 << BLOCK_SIZE_POWER;
    //const int BLOCK_SIZE_MASK = BLOCK_SIZE - 1;
    const int MINIMUM_DIMENSION = BLOCK_SIZE * 5;
    
    
    static const int MID_SHADE_REMOVAL_HANDLER = 1;
	//static const int HIGH_SHADE_REMOVAL_HANDLER = 2;
    
    Histogram::Histogram(Ref<LuminanceSource> source) :
    Binarizer(source), cached_matrix_(NULL),cached_matrix_2(NULL), cached_row_(NULL), cached_row_num_(-1) {
        
        try {
            binarizeEntireImage();
            binarizeEntireImage2();
        } catch (IllegalArgumentException re) {
            throw new IllegalArgumentException("Cannot binarize the image.");
        }
        
    }
    
    Histogram::~Histogram() {
    }
    
    
    Ref<BitArray> Histogram::getBlackRow(int y, Ref<BitArray> row) {
        if (y == cached_row_num_) {
            if (cached_row_ != NULL) {
                return cached_row_;
            } else {
                throw IllegalArgumentException("Too little dynamic range in luminance");
            }
        }
        
        vector<int> histogram(LUMINANCE_BUCKETS, 0);
        LuminanceSource& source = *getLuminanceSource();
        int width = source.getWidth();
        if (row == NULL || static_cast<int>(row->getSize()) < width) {
            row = new BitArray(width);
        } else {
            row->clear();
        }
        
        //TODO(flyashi): cache this instead of allocating and deleting per row
        unsigned char* row_pixels = NULL;
        try {
            row_pixels = new unsigned char[width];
            row_pixels = source.getRow(y, row_pixels);
            for (int x = 0; x < width; x++) {
                histogram[row_pixels[x] >> LUMINANCE_SHIFT]++;
            }
            int blackPoint = estimate(histogram) << LUMINANCE_SHIFT;
            
            BitArray& array = *row;
            int left = row_pixels[0];
            int center = row_pixels[1];
            for (int x = 1; x < width - 1; x++) {
                int right = row_pixels[x + 1];
                // A simple -1 4 -1 box filter with a weight of 2.
                int luminance = ((center << 2) - left - right) >> 1;
                if (luminance < blackPoint) {
                    array.set(x);
                }
                left = center;
                center = right;
            }
            
            cached_row_ = row;
            cached_row_num_ = y;
            delete [] row_pixels;
            return row;
        } catch (IllegalArgumentException const& iae) {
            // Cache the fact that this row failed.
            cached_row_ = NULL;
            cached_row_num_ = y;
            delete [] row_pixels;
            throw iae;
        }
    }
    
    Ref<BitMatrix> Histogram::getBlackMatrix() {
        if (cached_matrix_ != NULL) {
            return cached_matrix_;
        }
        
        // Faster than working with the reference
        LuminanceSource& source = *getLuminanceSource();
        int width = source.getWidth();
        int height = source.getHeight();
        vector<int> histogram(LUMINANCE_BUCKETS, 0);
        
        // Quickly calculates the histogram by sampling four rows from the image.
        // This proved to be more robust on the blackbox tests than sampling a
        // diagonal as we used to do.
        ArrayRef<unsigned char> ref (width);
        unsigned char* row = &ref[0];
        for (int y = 1; y < 5; y++) {
            int rownum = height * y / 5;
            int right = (width << 2) / 5;
            row = source.getRow(rownum, row);
            for (int x = width / 5; x < right; x++) {
                histogram[row[x] >> LUMINANCE_SHIFT]++;
            }
        }
        
        int blackPoint = estimate(histogram) << LUMINANCE_SHIFT;
        
        Ref<BitMatrix> matrix_ref(new BitMatrix(width, height));
        BitMatrix& matrix = *matrix_ref;
        for (int y = 0; y < height; y++) {
            row = source.getRow(y, row);
            for (int x = 0; x < width; x++) {
                if (row[x] <= blackPoint)
                    matrix.set(x, y);
            }
        }
        
        cached_matrix_ = matrix_ref;
        // delete [] row;
        return matrix_ref;
    }
    
    int Histogram::estimate(vector<int> &histogram) {
        int numBuckets = histogram.size();
        int maxBucketCount = 0;
        
        // Find tallest peak in histogram
        int firstPeak = 0;
        int firstPeakSize = 0;
        for (int i = 0; i < numBuckets; i++) {
            if (histogram[i] > firstPeakSize) {
                firstPeak = i;
                firstPeakSize = histogram[i];
            }
            if (histogram[i] > maxBucketCount) {
                maxBucketCount = histogram[i];
            }
        }
        
        // Find second-tallest peak -- well, another peak that is tall and not
        // so close to the first one
        int secondPeak = 0;
        int secondPeakScore = 0;
        for (int i = 0; i < numBuckets; i++) {
            int distanceToBiggest = i - firstPeak;
            // Encourage more distant second peaks by multiplying by square of distance
            int score = histogram[i] * distanceToBiggest * distanceToBiggest;
            if (score > secondPeakScore) {
                secondPeak = i;
                secondPeakScore = score;
            }
        }
        
        // Put firstPeak first
        if (firstPeak > secondPeak) {
            int temp = firstPeak;
            firstPeak = secondPeak;
            secondPeak = temp;
        }
        
        // Kind of arbitrary; if the two peaks are very close, then we figure there is
        // so little dynamic range in the image, that discriminating black and white
        // is too error-prone.
        // Decoding the image/line is either pointless, or may in some cases lead to
        // a false positive for 1D formats, which are relatively lenient.
        // We arbitrarily say "close" is
        // "<= 1/16 of the total histogram buckets apart"
        if (secondPeak - firstPeak <= numBuckets >> 4) {
            throw IllegalArgumentException("Too little dynamic range in luminance");
        }
        
        // Find a valley between them that is low and closer to the white peak
        int bestValley = secondPeak - 1;
        int bestValleyScore = -1;
        for (int i = secondPeak - 1; i > firstPeak; i--) {
            int fromFirst = i - firstPeak;
            // Favor a "valley" that is not too close to either peak -- especially not
            // the black peak -- and that has a low value of course
            int score = fromFirst * fromFirst * (secondPeak - i) *
            (maxBucketCount - histogram[i]);
            if (score > bestValleyScore) {
                bestValley = i;
                bestValleyScore = score;
            }
        }
        
        return bestValley;
    }
    
    
    Ref<Binarizer> Histogram::createBinarizer(Ref<LuminanceSource> source) {
        return Ref<Binarizer> (new Histogram(source));
    }
    
    
    
    
    
    Ref<BitArray> Histogram::getBlackRowHybrid(int y, Ref<BitArray> row, int binarizerLevel) {
        
        if (binarizerLevel == MID_SHADE_REMOVAL_HANDLER) {
            binarizeEntireImage2();
            return cached_matrix_2->getRow(y, row);
        }
        else {
            binarizeEntireImage();
            return cached_matrix_->getRow(y, row);
        }
        
    }
    
    
    void Histogram::binarizeEntireImage() {
        if (cached_matrix_ == NULL) {
            Ref<LuminanceSource> source = getLuminanceSource();
            if (source->getWidth() >= MINIMUM_DIMENSION && source->getHeight() >= MINIMUM_DIMENSION) {
                unsigned char* luminances = source->getMatrix();
                //unsigned char* outluminances = source->getMatrix();
                
                int width = source->getWidth();
                int height = source->getHeight();
                
                zxing::ImageProcessing img ;
                img.HandleImage(luminances, width, height);
                
                
                int subWidth = width >> 3;
                if (width & 0x07) {
                    subWidth++;
                }
                int subHeight = height >> 3;
                if (height & 0x07) {
                    subHeight++;
                }
                int *blackPoints = calculateBlackPoints(luminances, subWidth, subHeight, width, height);
                cached_matrix_.reset(new BitMatrix(width,height));
                calculateThresholdForBlock(luminances, subWidth, subHeight, width, height, blackPoints, cached_matrix_);
                delete [] blackPoints;
                delete [] luminances;
            } else {
                // If the image is too small, fall back to the global histogram approach.
                cached_matrix_.reset(Histogram::getBlackMatrix());
            }
        }
    }
    
    
    
    void Histogram::calculateThresholdForBlock(unsigned char* luminances,
                                               int subWidth,
                                               int subHeight,
                                               int width,
                                               int height,
                                               int blackPoints[],
                                               Ref<BitMatrix>  matrix) {
        for (int y = 0; y < subHeight; y++) {
            int yoffset = y << BLOCK_SIZE_POWER;
            if (yoffset + BLOCK_SIZE >= height) {
                yoffset = height - BLOCK_SIZE;
            }
            for (int x = 0; x < subWidth; x++) {
                int xoffset = x << BLOCK_SIZE_POWER;
                if (xoffset + BLOCK_SIZE >= width) {
                    xoffset = width - BLOCK_SIZE;
                }
                int left = (x > 1) ? x : 2;
                left = (left < subWidth - 2) ? left : subWidth - 3;
                int top = (y > 1) ? y : 2;
                top = (top < subHeight - 2) ? top : subHeight - 3;
                int sum = 0;
                for (int z = -2; z <= 2; z++) {
                    int *blackRow = &blackPoints[(top + z) * subWidth];
                    sum += blackRow[left - 2];
                    sum += blackRow[left - 1];
                    sum += blackRow[left];
                    sum += blackRow[left + 1];
                    sum += blackRow[left + 2];
                }
                int average = sum / 25;
                threshold8x8Block(luminances, xoffset, yoffset, average, width, matrix);
            }
        }
    }
    
    void Histogram::threshold8x8Block(unsigned char* luminances,
                                      int xoffset,
                                      int yoffset,
                                      int threshold,
                                      int stride,
                                      Ref<BitMatrix>  matrix) {
        for (int y = 0, offset = yoffset * stride + xoffset;
             y < BLOCK_SIZE;
             y++,  offset += stride) {
            for (int x = 0; x < BLOCK_SIZE; x++) {
                int pixel = luminances[offset + x] & 0xff;
                if (pixel <= threshold) {
                    matrix->set(xoffset + x, yoffset + y);
                }
            }
        }
    }
    
    namespace {
        inline int getBlackPointFromNeighbors(int* blackPoints, int subWidth, int x, int y) {
            return (blackPoints[(y-1)*subWidth+x] +
                    2*blackPoints[y*subWidth+x-1] +
                    blackPoints[(y-1)*subWidth+x-1]) >> 2;
        }
    }
    
    int* Histogram::calculateBlackPoints(unsigned char* luminances, int subWidth, int subHeight,
                                         int width, int height) {
        int *blackPoints = new int[subHeight * subWidth];
        for (int y = 0; y < subHeight; y++) {
            int yoffset = y << BLOCK_SIZE_POWER;
            if (yoffset + BLOCK_SIZE >= height) {
                yoffset = height - BLOCK_SIZE;
            }
            for (int x = 0; x < subWidth; x++) {
                int xoffset = x << BLOCK_SIZE_POWER;
                if (xoffset + BLOCK_SIZE >= width) {
                    xoffset = width - BLOCK_SIZE;
                }
                int sum = 0;
                int min = 0xFF;
                int max = 0;
                for (int yy = 0, offset = yoffset * width + xoffset;
                     yy < BLOCK_SIZE;
                     yy++, offset += width) {
                    for (int xx = 0; xx < BLOCK_SIZE; xx++) {
                        int pixel = luminances[offset + xx] & 0xFF;
                        sum += pixel;
                        if (pixel < min) {
                            min = pixel;
                        }
                        if (pixel > max) {
                            max = pixel;
                        }
                    }
                }
                
                int average = sum >> 6;
                if (max - min <= 24) {
                    average = min >> 1;
                    if (y > 0 && x > 0) {
                        int bp = getBlackPointFromNeighbors(blackPoints, subWidth, x, y);
                        if (min < bp) {
                            average = bp;
                        }
                    }
                }
                blackPoints[y * subWidth + x] = average;
            }
        }
        return blackPoints;
    }
    
    
    
    
    // binarizer - 3 ..  created on 13-02-2012
    //
    //
    
    void Histogram::binarizeEntireImage2() {
        if (cached_matrix_2 == NULL) {
            Ref<GreyscaleLuminanceSource> source = getLuminanceSource();
            if (source->getWidth() >= MINIMUM_DIMENSION && source->getHeight() >= MINIMUM_DIMENSION) {
                unsigned char* luminances = source->getMatrix();
                //unsigned char* outluminances = source->getMatrix();
                
                int width = source->getWidth();
                int height = source->getHeight();
                
                zxing::ImageProcessing img ;
                img.HandleImage2(luminances, width, height);
                
                
                int subWidth = width >> 3;
                if (width & 0x07) {
                    subWidth++;
                }
                int subHeight = height >> 3;
                if (height & 0x07) {
                    subHeight++;
                }
                int *blackPoints = calculateBlackPoints2(luminances, subWidth, subHeight, width, height);
                cached_matrix_2.reset(new BitMatrix(width,height));
                calculateThresholdForBlock2(luminances, subWidth, subHeight, width, height, blackPoints, cached_matrix_2);
                delete [] blackPoints;
                delete [] luminances;
            } else {
                // If the image is too small, fall back to the global histogram approach.
                cached_matrix_2.reset(Histogram::getBlackMatrix());
            }
        }
    }
    
    
    int* Histogram::calculateBlackPoints2(unsigned char* luminances, int subWidth, int subHeight,
                                          int width, int height) {
        int *blackPoints = new int[subHeight * subWidth];
        for (int y = 0; y < subHeight; y++) {
            int yoffset = y << BLOCK_SIZE_POWER;
            if (yoffset + BLOCK_SIZE >= height) {
                yoffset = height - BLOCK_SIZE;
            }
            for (int x = 0; x < subWidth; x++) {
                int xoffset = x << BLOCK_SIZE_POWER;
                if (xoffset + BLOCK_SIZE >= width) {
                    xoffset = width - BLOCK_SIZE;
                }
                int sum = 0;
                int min = 0xFF;
                int max = 0;
                for (int yy = 0, offset = yoffset * width + xoffset;
                     yy < BLOCK_SIZE;
                     yy++, offset += width) {
                    for (int xx = 0; xx < BLOCK_SIZE; xx++) {
                        int pixel = luminances[offset + xx] & 0xFF;
                        sum += pixel;
                        if (pixel < min) {
                            min = pixel;
                        }
                        if (pixel > max) {
                            max = pixel;
                        }
                    }
                }
                
                int average = sum >> 6;
                int average2 = average;
                
                if (max - min <= 24) {
                    average = max == 0 ? 1 : (int) (min * 0.3125f);
                    average2 = (int) (min * 0.3125f);
                    if (y > 0 && x > 0) {
                        int bp = getBlackPointFromNeighbors(blackPoints, subWidth, x, y);
                        if (min < bp) {
                            average2 = bp;
                        }
                    }
                }
                blackPoints[y * subWidth + x] = (average + average2) >> 1;
            }
        }
        return blackPoints;
    }
    
    void Histogram::calculateThresholdForBlock2(unsigned char* luminances,
                                                int subWidth,
                                                int subHeight,
                                                int width,
                                                int height,
                                                int blackPoints[],
                                                Ref<BitMatrix>  matrix) {
        for (int y = 0; y < subHeight; y++) {
            int yoffset = y << BLOCK_SIZE_POWER;
            if (yoffset + BLOCK_SIZE >= height) {
                yoffset = height - BLOCK_SIZE;
            }
            for (int x = 0; x < subWidth; x++) {
                int xoffset = x << BLOCK_SIZE_POWER;
                if (xoffset + BLOCK_SIZE >= width) {
                    xoffset = width - BLOCK_SIZE;
                }
                int left = (x > 1) ? x : 2;
                left = (left < subWidth - 2) ? left : subWidth - 3;
                int top = (y > 1) ? y : 2;
                top = (top < subHeight - 2) ? top : subHeight - 3;
                int sum = 0;
                for (int z = -2; z <= 2; z++) {
                    int *blackRow = &blackPoints[(top + z) * subWidth];
                    sum += blackRow[left - 2];
                    sum += blackRow[left - 1] + 3.25;
                    sum += blackRow[left];
                    sum += blackRow[left + 1];
                    sum += blackRow[left + 2];
                }
                int average = sum / 30;
                if (average > 255)
					average = (int) (average * 0.7125f);
                threshold8x8Block(luminances, xoffset, yoffset, average, width, matrix);
            }
        }
    }
    
    
} // namespace VIN

