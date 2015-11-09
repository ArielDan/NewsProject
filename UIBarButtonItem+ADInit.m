//
//  UIBarButtonItem+ADInit.m
//  090506仿头条
//
//  Created by csip on 15/10/17.
//  Copyright © 2015年 ariel. All rights reserved.
//

#import "UIBarButtonItem+ADInit.h"

@implementation UIBarButtonItem (ADInit)

+(UIBarButtonItem *)itemWithIcon:(NSString *)icon target:(id)target action:(SEL)action{
    
    UIButton *btn = [[UIButton alloc] init];
    
    //图片右移  由于是想让图片右移，所以left需要设置为正，right需要设置为负。正在是相反的。
    //[btn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    btn.frame = CGRectMake(0, 20, btn.currentImage.size.width, btn.currentImage.size.height);
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn addTarget:target action:action forControlEvents:UIControlEventTouchUpInside];
    
    return [[UIBarButtonItem alloc] initWithCustomView:btn];
}

@end
