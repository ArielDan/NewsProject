//
//  ADNavigationController.h
//  仿头条
//
//  Created by csip on 15/10/19.
//  Copyright © 2015年 ariel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ADNavigationController : UINavigationController

+(instancetype)getInstance;
-(void)setUpController:(UIViewController *)vc title:(NSString *)title;
-(void)leftBtnClick;
@end
