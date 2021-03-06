//
//  ADNavigationController.h
//  仿头条
//
//  Created by csip on 15/10/19.
//  Copyright © 2015年 ariel. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ADTitleView;
@class ADNavigationBar;

@interface ADNavigationController : UINavigationController

+(instancetype)getInstance;
-(void)setUpController:(UIViewController *)vc title:(NSString *)title;
-(void)leftBtnClick;

@property (nonatomic,strong) ADTitleView *titleView;

@property (nonatomic,strong) ADNavigationBar *navBar;


//调用，隐藏titleView;
//@property (nonatomic,strong) void(^hideTitleViewBlock)();
//
//@property (nonatomic,strong) void(^showTitleViewBlock)();
@property (nonatomic,strong) void(^hiddenBarBlock)();

@end
