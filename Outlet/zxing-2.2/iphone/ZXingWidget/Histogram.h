#ifndef __Histogram_H__
#define __Histogram_H__
//
//  Histogram.h
//  VINWidget
//
//  Created by ___saradhi___ on 30/11/11.
//  Copyright 2011 ___technolabssoftware___. All rights reserved.
//



#include <vector>
#include <zxing/Binarizer.h>
#include <zxing/common/BitArray.h>
#include <zxing/common/BitMatrix.h>

namespace VIN {
	
	class Histogram : public Binarizer {
    private:
        Ref<zxing::BitMatrix> cached_matrix_;
        Ref<BitMatrix> cached_matrix_2;
        Ref<BitArray> cached_row_;
        int cached_row_num_;
        
	public:
		Histogram(zxing::Ref<getLuminanceSource> source);
		virtual ~Histogram();
		
		virtual Ref<BitArray> getBlackRow(int y, Ref<BitArray> row);
		virtual Ref<BitMatrix> getBlackMatrix();
		static int estimate(std::vector<int> &histogram);
		Ref<Binarizer> createBinarizer(Ref<GreyscaleLuminanceSource> source);
        virtual Ref<BitArray> getBlackRowHybrid(int y, Ref<BitArray> row, int binarizerLevel);
        void binarizeEntireImage();
        void binarizeEntireImage2();
        
        
    private:
        // We'll be using one-D arrays because C++ can't dynamically allocate 2D
        // arrays
        int* calculateBlackPoints(unsigned char* luminances,
                                  int subWidth,
                                  int subHeight,
                                  int width,
                                  int height);
        void calculateThresholdForBlock(unsigned char* luminances,
                                        int subWidth,
                                        int subHeight,
                                        int width,
                                        int height,
                                        int blackPoints[],
                                        Ref<BitMatrix> matrix);
        void threshold8x8Block(unsigned char* luminances,
                               int xoffset,
                               int yoffset,
                               int threshold,
                               int stride,
                               Ref<BitMatrix> matrix);
        
        int* calculateBlackPoints2(unsigned char* luminances,
                                   int subWidth,
                                   int subHeight,
                                   int width,
                                   int height);
        void calculateThresholdForBlock2(unsigned char* luminances,
                                         int subWidth,
                                         int subHeight,
                                         int width,
                                         int height,
                                         int blackPoints[],
                                         Ref<BitMatrix> matrix);
        
	};
	
}

#endif /* Histogram_H_ */
