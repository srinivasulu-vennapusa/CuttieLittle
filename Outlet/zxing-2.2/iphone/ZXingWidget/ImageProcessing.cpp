//
//  ImageProcessing.cpp
//  VINWidget
//
//  Created by ___saradhi___ on 08/12/11.
//  Copyright 2011 ___technolabssoftware___. All rights reserved.
//

#include "ImageProcessing.h"
#include "math.h"



namespace VIN {
    
    
    void ImageProcessing::HandleImage(unsigned char* luminances, int width, int height) {
        
        SharpenRow(luminances, width, height);
        SharpenRow(luminances, width, height);
        Blur(luminances, width, height);
        
    }
    
    void ImageProcessing::HandleImage2(unsigned char* luminances, int width, int height) {
        
        SharpenRow(luminances, width, height);
        SharpenRow2(luminances, width, height);
        Blur(luminances, width, height);
        
    }
    
    
    
    
    //sharpen Row ..
    void ImageProcessing::SharpenRow(unsigned char* luminances, int width, int height) {
		for (int y = 0; y < height; y++) {
			int offset = y * width;
			int left = luminances[offset] & 0xff;
			int center = luminances[offset + 1] & 0xff;
			for (int x = 1; x < width - 1; x++) {
				int right = luminances[offset + x + 1] & 0xff;
				int pixel = ((center << 2) - left - right) >> 1;
				// Must clamp values to 0..255 so they will fit in a byte.
				if (pixel > 255) {
					pixel = 255;
				} else if (pixel < 0) {
					pixel = 0;
				}
				luminances[offset + x] = pixel;
				left = center;
				center = right;
			}
		}// End for
	}
    
    
    //sharpen Row ..
    void ImageProcessing::SharpenRow2(unsigned char* luminances, int width, int height) {
		for (int y = 0; y < height; y++) {
			int offset = y * width;
			int left = luminances[offset] & 0xff;
			int center = luminances[offset + 1] & 0xff;
			for (int x = 1; x < width - 1; x++) {
				int right = luminances[offset + x + 1] & 0xff;
				int pixel = (int) (((center * 10.525f) - left * 4.25f - right * 4.25f) * 0.5f);
				// Must clamp values to 0..255 so they will fit in a byte.
				if (pixel > 255) {
					pixel = 255;
				} else if (pixel < 0) {
					pixel = 0;
				}
				luminances[offset + x] = pixel;
				left = center;
				center = right;
			}
		}// End for
	}
    
    
    
    
    int ImageProcessing::clamp(int c) {
		if (c < 0) {
			return 0;
		}
        
		if (c > 255) {
			return 255;
		}
        
		return c;
	}
    
    
    
    
    // filter for image processing .. (created by saradhi on 29/11/11)
    
    void ImageProcessing::Blur(unsigned char* luminances, int width, int height) {
        
		float angle = 0.2f;
		float distance = 1.06f;
		int repetitions = 3;
		int index = 0;
		float sinAngle = (float) sin(angle);
		float cosAngle = (float) cos(angle);
		for (int y = 0; y < height; y++) {
			for (int x = 0; x < width; x++) {
				int a = 0;
				int r = 0;
				int g = 0;
				int b = 0;
				int count = 0;
                
				for (int i = 0; i < repetitions; i++) {
					int newX = x;
					int newY = y;
                    
					if (i != 0) {
                        
						// Linear blur Filter
						newX = (int) (x + (i * distance * sinAngle));
						newY = (int) (y + (i * distance * cosAngle));
                        
						if (newX < 0) {
							break;
						} else if (newX >= width) {
							break;
						}
                        
						if (newY < 0) {
							break;
						} else if (newY >= height) {
							break;
						}
					}
                    
					count++;
                    
					int rgb = luminances[(newY * width) + newX];
					a += ((rgb >> 24) & 0xff);
					r += ((rgb >> 16) & 0xff);
					g += ((rgb >> 8) & 0xff);
					b += (rgb & 0xff);
				}
                
				if (count == 0) {
					luminances[index] = luminances[index];
				} else {
					a = clamp((int) (a / count));
					r = clamp((int) (r / count));
					g = clamp((int) (g / count));
					b = clamp((int) (b / count));
					luminances[index] = ((a << 24) | (r << 16) | (g << 8) | b);
				}
                
				index++;
			}
		}
    }
    
    
    void ImageProcessing::Blur2(unsigned char* luminances, int width, int height) {
        
		float angle = 0.2f;
		float distance = 1.06f;
		int repetitions = 4;
		int index = 0;
		float sinAngle = (float) sin(angle);
		float cosAngle = (float) cos(angle);
		for (int y = 0; y < height; y++) {
			for (int x = 0; x < width; x++) {
				int a = 0;
				int r = 0;
				int g = 0;
				int b = 0;
				int count = 0;
                
				for (int i = 0; i < repetitions; i++) {
					int newX = x;
					int newY = y;
                    
					if (i != 0) {
                        
						// Linear blur Filter
						newX = (int) (x + (i * distance * sinAngle));
						newY = (int) (y + (i * distance * cosAngle));
                        
						if (newX < 0) {
							break;
						} else if (newX >= width) {
							break;
						}
                        
						if (newY < 0) {
							break;
						} else if (newY >= height) {
							break;
						}
					}
                    
					count++;
                    
					int rgb = luminances[(newY * width) + newX];
					a += ((rgb >> 24) & 0xff);
					r += ((rgb >> 16) & 0xff);
					g += ((rgb >> 8) & 0xff);
					b += (rgb & 0xff);
				}
                
				if (count == 0) {
					luminances[index] = luminances[index];
				} else {
					a = clamp((int) (a / count));
					r = clamp((int) (r / count));
					g = clamp((int) (g / count));
					b = clamp((int) (b / count));
					luminances[index] = ((a << 24) | (r << 16) | (g << 8) | b);
				}
                
				index++;
			}
		}
    }
    
    
}