//
//  ADLeftMenu.h
//  090506仿头条
//
//  Created by csip on 15/10/16.
//  Copyright © 2015年 ariel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

//左边菜单最上面按钮的Y值
#define kLeftMenuBtnY 50

@class ADLeftMenu;

@protocol ADLeftMenuDelegate<NSObject>

@optional
-(void)leftMenu:(ADLeftMenu *)leftMenu didSelectedForm:(NSInteger)from to:(NSInteger)to;

@end

@interface ADLeftMenu : UIView

@property( nonatomic,weak) id<ADLeftMenuDelegate> delegate;

@end
