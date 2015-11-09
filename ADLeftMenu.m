//
//  ADLeftMenu.m
//  090506仿头条
//
//  Created by csip on 15/10/16.
//  Copyright © 2015年 ariel. All rights reserved.
//

#import "ADLeftMenu.h"
#import "UIView+Frame.h"

#import "UIImage+AD.h"

@interface ADLeftMenu()

@property(nonatomic,weak) UIButton *selectedBtn;
//存放按钮数组
@property(nonatomic,strong) NSMutableArray *btnArray;
//存放箭头数组
@property(nonatomic,strong) NSMutableArray *arrowArray;
//背景滚动视图
@property(nonatomic,weak) UIScrollView *backgroundScroll;

@end

@implementation ADLeftMenu

-(NSMutableArray *)btnArray{
    if ([_btnArray isEqual:[NSNull null] ]) {
        _btnArray = [NSMutableArray array];
    }
    
    return _btnArray;
}

-(NSMutableArray *)arrowArray{
    if (_arrowArray == nil) {
        _arrowArray = [NSMutableArray array];
    }
    
    return  _arrowArray;
}

-(instancetype) initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        self.backgroundColor = [UIColor clearColor];
        
        //添加背景滚动图
        [self setupScrollView];
        CGFloat alpha = 0.4;
        _btnArray = [[NSMutableArray alloc] init];
        _arrowArray = [[NSMutableArray alloc] init];
        [self setupBtnWithIcon:@"sidebar_nav_news" title:@"新闻" bgColor:kColor(202, 68, 73,alpha)];
        [self setupBtnWithIcon:@"sidebar_nav_reading" title:@"订阅" bgColor:kColor(190, 111, 69,alpha)];
        
    }
    
    
    return self;
}

-(void)setupScrollView{
    UIScrollView *backgroundScroll = [[UIScrollView alloc]init];
    backgroundScroll.showsHorizontalScrollIndicator = NO;
    backgroundScroll.showsVerticalScrollIndicator = NO;
    backgroundScroll.contentSize = CGSizeMake(self.width, [UIScreen mainScreen].bounds.size.height + 0.5);
    [self addSubview:backgroundScroll];
    
    _backgroundScroll = backgroundScroll;
    
}

//创建按钮
-(UIButton *)setupBtnWithIcon:(NSString *)icon title:(NSString *)title bgColor:(UIColor *)bgColor{
    
    UIButton *btn = [[UIButton alloc] init];
    btn.tag  =self.subviews.count;
    [btn addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    
    //设置图片、文字
    [btn setImage:[UIImage imageNamed:icon] forState:UIControlStateNormal];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    btn.titleLabel.font = [UIFont systemFontOfSize:16];
    
    [_backgroundScroll addSubview:btn];
    
    //设置按钮选中的背景
    [btn setBackgroundImage:[UIImage imageWithColor:bgColor] forState:UIControlStateSelected];
    
    //设置高亮不让图片变色
    btn.adjustsImageWhenHighlighted = NO;
    
    //按钮内容左对齐
    btn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    
    //按钮右边箭头→
    UIImageView *arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"top_navigation_back_photo"]];
    
    [btn addSubview:arrow];
    
    [self.arrowArray addObject:arrow];
    //NSLog(@"arrow:%d",_arrowArray.count);
    //设置间距
    btn.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    btn.contentEdgeInsets = UIEdgeInsetsMake(0, 30, 0, 0);
    
    //按钮存放数组
    [self.btnArray addObject:btn];
    //NSLog(@"array:%d",_btnArray.count);

    //如果是第一个按钮则默认选中
    if (self.btnArray.count == 1 ) {
        [self buttonClick:btn];
        
    }
    
    
    return btn;
}


#pragma mark - 按钮点击事件
-(void)buttonClick:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(leftMenu:didSelectedForm:to:)]) {
        [self.delegate leftMenu:self didSelectedForm:self.selectedBtn.tag to:sender.tag];
    }
    self.selectedBtn.selected = NO;
    sender.selected = YES;
    self.selectedBtn = sender;
}

-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.backgroundScroll.frame = self.bounds;
    //NSLog(@"array:%d",_btnArray.count);
    int btnCount = (int)self.btnArray.count;
    CGFloat btnW = self.width;
    CGFloat btnH = 60;
    
    //箭头
    CGFloat arrowW = 30;
    CGFloat arrowH = arrowW;
    NSLog(@"count:%d",btnCount);
    for (int i = 0; i < btnCount; i++) {
        UIButton *btn = self.btnArray[i];
        btn.width = btnW;
        btn.height = btnH;
        btn.y = i * btnH + kLeftMenuBtnY;
        btn.tag = i;
        
        UIImageView *arrow = self.arrowArray[i];
        CGFloat arrowX = btn.width - arrowW - 10;
        CGFloat arrowY = (btn.height - arrowH) * 0.5;
        arrow.frame = CGRectMake(arrowX, arrowY, arrowW, arrowH);
    }
}



@end
