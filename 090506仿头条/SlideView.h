//
//  SlideView.h
//  090506仿头条
//
//  Created by csip on 15/9/5.
//  Copyright (c) 2015年 ariel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SlideView : UIView<UIScrollViewDelegate,UITableViewDataSource,UITableViewDelegate>

//整个视图大小
@property(assign) CGRect mainView;

@property(nonatomic,strong) UIView *topMainView;

//上方按钮scrollerView
@property(nonatomic,strong) UIScrollView *topScrollView;

@property(nonatomic,strong) UIScrollView *scrollView;

@property(nonatomic,strong) NSMutableArray *scrollTableViews;

@property(nonatomic,strong) NSMutableArray *selectBtns;


//TableViews的数据源
@property(nonatomic,strong) NSMutableArray *tabelsDataSource;

//当前选中页数
@property(assign) NSInteger currentPage;

//滑动指示
@property(nonatomic,strong) UIView *slideView;



//选项卡个数
@property(assign) NSInteger tabCount;

-(instancetype)initWithFrame:(CGRect)frame WithCount:(NSInteger)count;


@end
