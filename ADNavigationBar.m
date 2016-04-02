//
//  ADNavigationBar.m
//  新闻
//
//  Created by yj on 16/4/2.
//  Copyright © 2016年 ariel. All rights reserved.
//

#import "ADNavigationBar.h"

@implementation ADNavigationBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self buildView];
    }
    
    return self;
}

-(void)buildView{
    UIButton *leftBtn = [[UIButton alloc] init];
    leftBtn.frame = CGRectMake(0, 15, 50, 50);
    //[self.rightBtn setTitle:@"+" forState:UIControlStateNormal];
    [leftBtn setImage:[UIImage imageNamed:@"top_navigation_menuicon"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
//    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    [self addSubview:leftBtn];
}

-(void)leftBtnClick{
    NSLog(@"1111");
    if ([self.transDelegate respondsToSelector:@selector(leftBtnClick)]) {
        [self.transDelegate leftBtnClick];
    }
}



@end
