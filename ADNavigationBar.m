//
//  ADNavigationBar.m
//  新闻
//
//  Created by yj on 16/4/2.
//  Copyright © 2016年 ariel. All rights reserved.
//

#import "ADNavigationBar.h"
#import "ADTitleView.h"
#import "ADChoiceController.h"

@interface ADNavigationBar()<ADTitleViewDelegate>

@property (nonatomic,strong) ADTitleView *titleView;

@end

static ADNavigationBar *instance;

@implementation ADNavigationBar

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/
+(instancetype)getInstance{
    return instance;
}


-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self buildView];
        instance = self;
    }
    
    return self;
}

-(void)buildView{
    UIButton *leftBtn = [[UIButton alloc] init];
    leftBtn.frame = CGRectMake(0, 15, 50, 50);
    //[self.rightBtn setTitle:@"+" forState:UIControlStateNormal];
    [leftBtn setImage:[UIImage imageNamed:@"top_navigation_menuicon"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnClicks) forControlEvents:UIControlEventTouchUpInside];
//    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
//    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    [self addSubview:leftBtn];
    
//    ADChoiceController *vc = [ADChoiceController getInstance];
//    vc.controllerDelegate = self;

//    __weak typeof(ADNavigationBar) *weakSelf = self;
//    
//    self.titleViewShowBlock = ^(){
//        ADTitleView *titleView = [[ADTitleView alloc] init];
//        titleView.frame = CGRectMake(0, 0, weakSelf.frame.size.width, 40);
//        //self.navigationItem.titleView = titleView;
//        
//        [titleView setBackgroundColor:[UIColor blueColor]];
//        titleView.delegate = weakSelf;
//        [weakSelf addSubview:titleView];
//        weakSelf.titleView = titleView;
//       
//    };
}

-(void)leftBtnClicks{
    
    if ([self.transDelegate respondsToSelector:@selector(leftBtnClick)]) {
        [self.transDelegate leftBtnClick];
    }
}




@end
