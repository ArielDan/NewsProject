//
//  ADTitleView.m
//  新闻
//
//  Created by csip on 15/11/10.
//  Copyright © 2015年 ariel. All rights reserved.
//

#import "ADTitleView.h"
#import "UIView+Frame.h"

#import "ADChoiceController.h"
#import "ADFindController.h"

@interface ADTitleView()

@property(nonatomic,strong) UIView *mainView;

@end
@implementation ADTitleView

-(UIView *)mainView{
    if (!_mainView) {
        _mainView = [[UIView alloc] init];
    }
    return _mainView;
}

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
//    if (self) {
//        [self setupButton];
//    }
    
    return self;
}

//-(void)layoutSubviews{
//    CGFloat btnY = 0;
//    int count = (int)self.subviews.count;
//    CGFloat btnX = 0;
//    CGFloat btnH = self.height;
//    CGFloat btnW = self.width/count;
//    
//    for (int i=0; i<count; i++) {
//        btnX = btnW * i;
//        UIButton *btn = self.subviews[i];
//        btn.tag = i;
//        btn.frame = CGRectMake(btnX, btnY, btnW, btnH);
//    }
//}
-(void)layoutSubviews{
    
    NSArray *array = @[@"精选",@"发现"];
    UISegmentedControl *segment = [[UISegmentedControl alloc] initWithItems:array];
    //默认选中
    segment.selectedSegmentIndex = 0;
    
    segment.frame = CGRectMake(self.width/2 - segment.width/2, 20, 100, 24);
    segment.tintColor = [UIColor whiteColor];
    [segment addTarget:self action:@selector(segmentClick:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:segment];
    self.segment = segment;
    
}
-(void)segmentClick:(UISegmentedControl *)segment{
    self.segment.selectedSegmentIndex = segment.selectedSegmentIndex;
    //self.segment.enabled = NO;
    if ([self.delegate respondsToSelector:@selector(titleView:scrollToIndex:)]) {
        [self.delegate titleView:self scrollToIndex:segment.selectedSegmentIndex];
    }
}


-(void)segmentSelected:(NSInteger)tag{
    self.segment.selectedSegmentIndex = tag;
}

//-(void)setupButton{
//    [self addBtn:@"精选"];
//    [self addBtn:@"发现"];
//    [self addBtn:@"专场"];
//}
//
//-(void)addBtn:(NSString *)title{
//    UIButton *btn = [[UIButton alloc] init];
//    [btn setTitle:title forState:UIControlStateNormal];
//    [btn setTitleColor:kColor(75, 75, 75, 1) forState:UIControlStateNormal];
//    [btn addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:btn];
//}

@end
