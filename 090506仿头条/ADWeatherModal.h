//
//  ADWeatherModal.h
//  090506仿头条
//
//  Created by csip on 15/9/14.
//  Copyright (c) 2015年 ariel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADWeatherModal : NSObject

//@property(nonatomic,strong)NSArray *detailArray;
@property(nonatomic,copy)NSString *dt;

@property(nonatomic,copy)NSString *pm2d5;

@property(nonatomic,copy)NSString *wind;

@property(nonatomic,copy)NSString *nongli;

@property(nonatomic,copy)NSString *date;
@property(nonatomic,copy)NSString *climate;
@property(nonatomic,copy)NSString *temperature;
@property(nonatomic,copy)NSString *week;

@end
