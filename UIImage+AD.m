
//
//  UIImage+AD.m
//  仿头条
//
//  Created by csip on 15/10/19.
//  Copyright © 2015年 ariel. All rights reserved.
//

#import "UIImage+AD.h"

@implementation UIImage (AD)


//设置图片背景颜色
+(UIImage *)imageWithColor:(UIColor *)color{
    CGFloat imageW = 100;
    CGFloat imageH = 100;
    
    //开启基于位图的图形上下文
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(imageW, imageH), NO, 0.0);
    
    //color颜色的矩形框
    [color set];
    UIRectFill(CGRectMake(0, 0, imageW, imageH));
    
    //得到图片
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    
    //关闭上下文
    UIGraphicsEndImageContext();
    
    return image;
}

@end
