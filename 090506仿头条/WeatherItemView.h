//
//  WeatherItemView.h
//  090506仿头条
//
//  Created by csip on 15/9/15.
//  Copyright (c) 2015年 ariel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeatherItemView : UIView

@property(weak,nonatomic) UILabel *titleLbl;

@property(weak,nonatomic) UILabel *tLbl;

@property(weak,nonatomic) UILabel *weatherLbl;

@property(weak,nonatomic) UILabel *windLbl;

@property(weak,nonatomic) UIImageView *weatherImg;

@property(strong,nonatomic) NSString *weather;

@end
