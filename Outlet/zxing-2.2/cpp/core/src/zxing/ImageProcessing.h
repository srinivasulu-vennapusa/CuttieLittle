#ifndef __ImageProcessing_H__
#define __ImageProcessing_H__
//
//  ImageProcessing.h
//  VINWidget
//
//  Created by ___saradhi___ on 08/12/11.
//  Copyright 2011 ___technolabssoftware___. All rights reserved.
//

namespace zxing {
    
    class ImageProcessing  {
    private:
        void SharpenRow(unsigned char* luminances, int width, int height);
        int clamp(int c);
        void Blur(unsigned char* luminances, int width, int height);
        void SharpenRow2(unsigned char* luminances, int width, int height);
        void Blur2(unsigned char* luminances, int width, int height);
        
    public:
        
        void HandleImage(unsigned char* luminances, int width, int height);
        void HandleImage2(unsigned char* luminances, int width, int height);
        
    };
    
    
}




#endif // __ImageProcessing_H__