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

@property(nonatomic,strong)ADChoiceController *choiceController;
@property(nonatomic,strong)ADFindController *findController;

@end
@implementation ADTitleView

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
    
    segment.frame = CGRectMake(self.width/2 - segment.width, 10, 100, 24);
    segment.tintColor = [UIColor whiteColor];
    [segment addTarget:self action:@selector(segmentClick:) forControlEvents:UIControlEventValueChanged];
    [self addSubview:segment];
    
}

-(void)segmentClick:(UISegmentedControl *)seg{
    switch (seg.selectedSegmentIndex) {
        case 0:
            self.choiceController = [ADChoiceController getInstance];
            if ([self.delegate respondsToSelector:@selector(titleView:pushController:)]) {
                [self.delegate titleView:self pushController:self.choiceController];
                
            }
          
            break;
        case 1:
            if ([self.delegate respondsToSelector:@selector(titleView:pushController:)]) {
                self.findController = [[ADFindController alloc] init];
                [self.delegate titleView:self pushController:self.findController];
                
            }
           
        default:
            break;
    }
    
    seg.enabled = NO;

    
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
