//
//  FoundViewController.m
//  仿头条
//
//  Created by csip on 15/10/27.
//  Copyright © 2015年 ariel. All rights reserved.
//

#import "FoundViewController.h"
#import "ADChoiceController.h"
#import "ADFindController.h"

#import "ADTitleView.h"

#import "ADFindController.h"
#import "ADChoiceController.h"
#import "ADNavigationController.h"

#import "UIView+Frame.h"
@interface FoundViewController()<UIScrollViewDelegate,ADTitleViewDelegate>

@property(nonatomic,weak) ADTitleView *titleView;

//子视图、控制器
@property(nonatomic,strong) NSMutableArray *childViewsArray;

@property(nonatomic,weak) UIScrollView *scrollerView;

@end

@implementation FoundViewController

-(NSMutableArray *)childViewsArray{
    if (!_childViewsArray) {
        _childViewsArray = [[NSMutableArray alloc] init];
    }
    return _childViewsArray;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    
    [self setupScrollerView];
    
    [self setupTitleView];
}

-(void)viewWillDisappear:(BOOL)animated{

    self.titleView.hidden = YES;
    
}
-(void)viewWillAppear:(BOOL)animated{
    self.titleView.hidden = NO;
    
}

-(void)setupTitleView{
    ADTitleView *titleView = [[ADTitleView alloc] init];
    
    titleView.frame = CGRectMake(0, 0, self.view.width, self.navigationController.navigationBar.height);
    
    self.navigationItem.titleView = titleView;

    titleView.delegate = self;
    
    self.titleView = titleView;
}

#pragma mark- 添加滚动视图
-(void)setupScrollerView{
    
    ADChoiceController *choiceVC = [[ADChoiceController alloc] init];
    ADFindController *findVC = [[ADFindController alloc] init];
//    findVC.view.frame = CGRectMake(0, self.navigationController.navigationBar.frame.size.height, kScreenW, kScreenH - self.navigationController.navigationBar.frame.size.height);
    
    [self addChildViewController:choiceVC];
    [self addChildViewController:findVC];
    
    //子视图添加到数组中
    [self.childViewsArray addObject:choiceVC.view];
    [self.childViewsArray addObject:findVC.view];
    
    //UIScrollView *scrollerView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame), kScreenW, kScreenH)];
    UIScrollView *scrollerView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    
    scrollerView.delegate = self;
    [self.view addSubview:scrollerView];
    //[self.navigationController.view addSubview:scrollerView];
    //创建、添加滚动视图
    for (int i=0; i<self.childViewsArray.count; i++) {
        CGFloat childViewX = kScreenW *i;
        UIView *childView = self.childViewsArray[i];
        childView.frame = CGRectMake(childViewX, 0, kScreenW, self.view.height);
        [scrollerView addSubview:childView];
    }
    
    //滚动属性
    scrollerView.showsHorizontalScrollIndicator = NO; //是否显示滑动条
    scrollerView.showsVerticalScrollIndicator = NO;
    scrollerView.pagingEnabled = YES;   //是否整页翻动
    
    
    //content内容的宽和高
    scrollerView.contentSize = CGSizeMake(kScreenW*2, 0);
    
    scrollerView.bounces = NO;
    self.scrollerView = scrollerView;
    
}

#pragma mark- scrollerView delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //NSLog(@"contentoffSize:%f && n=%f",scrollView.contentOffset.x,scrollView.contentOffset.x/kScreenW);
    if (scrollView.contentOffset.x/kScreenW == 0) {
        
        
        [self.titleView segmentSelected:0];
    }else{
        [self.titleView segmentSelected:1];
    }
}



#pragma mark- titleView代理方法
-(void)titleView:(ADTitleView *)titleView scrollToIndex:(NSInteger)tagIndex{
   
    
    [self.scrollerView scrollRectToVisible:CGRectMake(kScreenW * tagIndex, 0, self.view.width, self.view.height) animated:YES];
   // [self.scrollerView setContentOffset:CGPointMake(kScreenW*tagIndex, 0) animated:YES];

}

//#pragma mark titleView代理方法
//-(void)titleView:(ADTitleView *)titleView pushController:(UIViewController *)controller{
//    [self.navigationController pushViewController:controller animated:YES];
//    //[self presentViewController:controller animated:YES completion:nil];
//}


@end
