//
//  ADDetailModel.h
//  090506仿头条
//
//  Created by csip on 15/10/12.
//  Copyright (c) 2015年 ariel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADDetailModel : NSObject

@property(nonatomic,copy) NSString *title;

@property(nonatomic,copy) NSString *ptime;

@property(nonatomic,copy) NSString *body;

//存放图片

@property(nonatomic,copy)NSArray *img;

@property(nonatomic,copy) NSString *src;
//配图尺寸
@property(nonatomic,copy) NSString *pixel;
//配图位置
@property(nonatomic,copy) NSString *ref;


@end
