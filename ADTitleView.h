//
//  ADTitleView.h
//  新闻
//
//  Created by csip on 15/11/10.
//  Copyright © 2015年 ariel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ADTitleView;

@protocol ADTitleViewDelegate <NSObject>

@optional
-(void)titleView:(ADTitleView *)titleView pushController:(UIViewController *)controller;

@end

@interface ADTitleView : UIView

@property(nonatomic,weak) id<ADTitleViewDelegate>delegate;

@end
