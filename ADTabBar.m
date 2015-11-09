//
//  ADTabBar.m
//  仿头条
//
//  Created by csip on 15/10/21.
//  Copyright © 2015年 ariel. All rights reserved.
//

#import "ADTabBar.h"
#import "ADBarButton.h"

@interface ADTabBar()

@property(nonatomic,strong) ADBarButton *selectBtn;
@property(nonatomic,strong) UIImageView *imageView;

@end

@implementation ADTabBar
-(void)addImageView{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = [UIImage imageNamed:@""];
    self.imageView = imageView;
    [self addSubview:imageView];
}

-(void)addBarbtnWithNormal:(NSString *)normal andHeighten:(NSString *)heighten andTitle:(NSString *)title{
   // UIButton *btn = [[UIButton alloc] init];
    ADBarButton *btn = [[ADBarButton alloc] init];
    [btn setImage:[UIImage imageNamed:normal] forState:UIControlStateNormal];
    [btn setImage:[UIImage imageNamed:heighten] forState:UIControlStateDisabled];
    
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:kColor(149, 149, 149, 1) forState:UIControlStateNormal];
    [btn setTitleColor:kColor(183, 20, 28, 1) forState:UIControlStateDisabled];
    
    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchDown];
    
    [self addSubview:btn];
    
    //NSLog(@"count:%d",self.subviews.count);
    //设置第一个按钮为默认选中
    if (self.subviews.count == 1) {
        btn.tag = 1;
        [self btnClick:btn];
    }
}

-(void)layoutSubviews{
    UIImageView *imageView = self.subviews[0];
    imageView.frame = self.bounds;
    
    for (int i = 1; i<self.subviews.count; i++) {
        //UIButton *btn = self.subviews[i];
        ADBarButton *btn = self.subviews[i];
        CGFloat btnW = [UIScreen mainScreen].bounds.size.width / 5;
        CGFloat btnH = 49;
        CGFloat btnX = (i-1) * btnW;
        CGFloat btnY = 0;
        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
        
        //绑定tag
        btn.tag = i - 1;
    }
}


-(void)btnClick:(ADBarButton *)sender{
    
    //页面跳转，响应代理方法
    if ([self.delegate respondsToSelector:@selector(changeSelectedIndexFrom:To:)]) {
        [self.delegate changeSelectedIndexFrom:_selectBtn.tag To:sender.tag];
    }
    
    
    //设置按钮显示状态，切换选中按钮
    _selectBtn.enabled = YES;
    _selectBtn = sender;
    sender.enabled = NO;
    
}
@end
