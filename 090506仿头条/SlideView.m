//
//  SlideView.m
//  090506仿头条
//
//  Created by csip on 15/9/5.
//  Copyright (c) 2015年 ariel. All rights reserved.
//

#import "SlideView.h"

#define kTopHeight 60

@implementation SlideView

//传入SlideTabBarView的frame和选项卡的个数
-(instancetype)initWithFrame:(CGRect)frame WithCount:(NSInteger)count{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        _mainView = frame;
        _tabCount = count;
        
        _selectBtns = [[NSMutableArray alloc] init];
        _scrollTableViews= [[NSMutableArray alloc] init];
        
        [self initDataSource];
        
        [self initScrollView];
        
        [self initTopBtns];
        
        [self initTableViews];
        
        
        [self initSlideView];
    }
    
   
    
    return self;
}

#pragma mark -初始化表格数据源
-(void)initDataSource{
    _tabelsDataSource = [[NSMutableArray alloc] initWithCapacity:_tabCount];
    
    for (int i = 1; i <= _tabCount; i++) {
        
        NSMutableArray *tempArray = [[NSMutableArray alloc] initWithCapacity:20];
        
        for (int j = 1 ; j <= 20; j++) {
            
            NSString *tempStr = [NSString stringWithFormat:@"我是第%d个TabelView的第%d条数据",i,j];
            //NSLog(@"%@",tempStr);
            
            [tempArray addObject:tempStr];
        }
        
        [_tabelsDataSource addObject:tempArray];
    }
    
}

#pragma mark -初始化滑动指示器
-(void)initSlideView{
    
    CGFloat width = _mainView.size.width / 6;
    
    _slideView = [[UIView alloc] initWithFrame:CGRectMake(0, kTopHeight - 5, width, 5)];
    
    //_slideView.backgroundColor = [UIColor redColor];
    
    [_slideView setBackgroundColor:[UIColor redColor]];
    
    [_topScrollView addSubview:_slideView];
}

#pragma mark - 实例化scrollView
-(void)initScrollView{
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, _mainView.origin.y, _mainView.size.width, _mainView.size.height - kTopHeight)];
    
    _scrollView.contentSize = CGSizeMake(_mainView.size.width * _tabCount, _mainView.size.height - kTopHeight);
    
    _scrollView.pagingEnabled = YES;
    
    _scrollView.delegate  = self;
    
    [self addSubview:_scrollView];
}

#pragma mark-实例化顶部按钮
-(void)initTopBtns{
    
    CGFloat width = _mainView.size.width / 6;
    
    if (_tabCount <= 6) {
        width = _mainView.size.width / self.tabCount;
    }
    
    _topMainView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, _mainView.size.width, kTopHeight)];
    
    _topScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, _mainView.size.width, kTopHeight)];
    
    _topScrollView.showsHorizontalScrollIndicator = NO;
    
    _topScrollView.showsVerticalScrollIndicator = YES;
    
    _topScrollView.bounces = NO;
    
    _topScrollView.delegate = self;
    
    if (_tabCount >= 6){
        _topScrollView.contentSize = CGSizeMake(width * _tabCount, kTopHeight);
    } else {
        _topScrollView.contentSize = CGSizeMake(_mainView.size.width, kTopHeight);
    }
    
    [self addSubview:_topMainView];
    
    [_topMainView addSubview:_topScrollView];
    
    
    for (int i =0 ; i < _tabCount; i++) {
        
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(width * i, 0, width, kTopHeight)];
        
        [view setBackgroundColor:[UIColor lightGrayColor]];
        
        if (i % 2) {
            [view setBackgroundColor:[UIColor grayColor]];
        }
        
        UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, width, kTopHeight)];
        
        button.tag = i;
        
        [button setTitle:[NSString stringWithFormat:@"按钮%d",i+1] forState:UIControlStateNormal];
        
        [button addTarget:self action:@selector(tapButton:) forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview:button];
        
        [_selectBtns addObject:view];
        
        [_topScrollView addSubview:view];
    }
    
    
}

#pragma mark - 点击按钮触发
-(void)tapButton:(id)sender{
    
    UIButton *button = sender;
    
    [_scrollView setContentOffset:CGPointMake(button.tag * _mainView.size.width, 0) animated:YES];
}

#pragma mark - 初始化下方TableViews
-(void) initTableViews{
    
    //实例化两个tableView减少内存的占用
    for (int i = 0; i < 2; i++) {
        
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(i * _mainView.size.width, 0, _mainView.size.width, _mainView.size.height - kTopHeight) style:UITableViewStylePlain];
        
        tableView.delegate = self;
        
        tableView.dataSource = self;
        
        tableView.tag = i;
        
        [_scrollTableViews addObject:tableView];
        
        [_scrollView addSubview:tableView];
    }
}

#pragma mark -scrollView代理方法

-(void)modifyTopScrollViewPosition:(UIScrollView *)scrollView{
    
    if ([_topScrollView isEqual:scrollView]) {
        
        CGFloat contentOffsetX = _topScrollView.contentOffset.x;
        
        CGFloat width = _slideView.frame.size.width;
        
        int count = (int)contentOffsetX/(int)width;
        
        CGFloat step = (int)contentOffsetX%(int)width;
        
        CGFloat sumStep = width * count;
        
        if (step > width/2) {
            
            sumStep = width * (count + 1);
            
        }
        
        [_topScrollView setContentOffset:CGPointMake(sumStep, 0) animated:YES];
        return;
    }
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    
    [self scrollViewDidEndDecelerating:scrollView];
    
}
            /*根据scrollView 偏移量计算红色指示器偏移量*/
-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if ([scrollView isEqual:_scrollView]) {
        _currentPage = _scrollView.contentOffset.x / _mainView.size.width;
        
        //UITableView *currentTable = _scrollTableViews[_currentPage];
        
        //[currentTable reloadData];
        [self updateTableViewWithNumber:_currentPage];
    
        return;
    }
    
    [self modifyTopScrollViewPosition:scrollView];
    
}


#pragma mark - 根据scrollView滚动位置复用tableView，减少内存开支
-(void) updateTableViewWithNumber: (NSInteger)pageNumber{
    
    int tableViewTag = pageNumber % 2;
    
    CGRect tableNewFrame = CGRectMake(pageNumber * _mainView.size.width, 0, _mainView.size.height, _mainView.size.height - kTopHeight);
    
    UITableView *reuseTableView = _scrollTableViews[tableViewTag];
    
    reuseTableView.frame = tableNewFrame;
    
    [reuseTableView reloadData];
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    if ([_scrollView isEqual:scrollView]){
        
        CGRect frame = _slideView.frame;
        
        if (_tabCount <= 6) {
            frame.origin.x = scrollView.contentOffset.x / _tabCount;
        } else {
            frame.origin.x = scrollView.contentOffset.x / 6;
        }
        
        _slideView.frame = frame;
        
        
    }
    
    
}

#pragma mark - tableView代理方法
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    NSMutableArray *tables = _tabelsDataSource[_currentPage];
    
    return tables.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return  60;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    NSString *indentifier = @"Slide";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:indentifier];
    
    if (cell == nil) {
        
        cell = [[UITableViewCell alloc ]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
        
    }
    
    if ([tableView isEqual:_scrollTableViews[_currentPage % 2]]) {
        
        cell.textLabel.text = _tabelsDataSource[_currentPage][indexPath.row];
    }
    
    return cell;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
