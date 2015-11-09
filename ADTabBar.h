//
//  ADTabBar.h
//  仿头条
//
//  Created by csip on 15/10/21.
//  Copyright © 2015年 ariel. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ADTabBarDelegate <NSObject>

//代理方法
@optional
-(void)changeSelectedIndexFrom:(NSInteger)from To:(NSInteger)to;

@end

@interface ADTabBar : UIView

@property(nonatomic,weak) id<ADTabBarDelegate>delegate;

-(void)addImageView;

-(void)addBarbtnWithNormal:(NSString *)normal andHeighten:(NSString *)heighten andTitle:(NSString *)title;

@end
