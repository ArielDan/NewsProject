//
//  ADNavigationBar.h
//  新闻
//
//  Created by yj on 16/4/2.
//  Copyright © 2016年 ariel. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ViewTransformDelegate <NSObject>

-(void)leftBtnClick;

@end

@interface ADNavigationBar : UINavigationBar

+(instancetype)getInstance;

@property(nonatomic,weak) id<ViewTransformDelegate> transDelegate;

@property(nonatomic,strong) void(^titleViewShowBlock)();

@end
