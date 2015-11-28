//
//  ADNewsHeaderView.m
//  仿头条
//
//  Created by csip on 15/11/3.
//  Copyright © 2015年 ariel. All rights reserved.
//

#import "ADNewsHeaderView.h"
#import "UIView+Frame.h"

#import "ADDetailModel.h"
#import "ADHeaderCell.h"
#import "ADNews.h"

#define kMaxCount 100

@interface ADNewsHeaderView()<UICollectionViewDataSource,UICollectionViewDelegate>

@property(nonatomic,weak)UICollectionView *collectionView;


//标题
@property(nonatomic,weak)UIPageControl *page;
@property(nonatomic,weak)UILabel *titleLbl;
@property(nonatomic,strong)NSTimer *timer;

@end

@implementation ADNewsHeaderView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addCollection];
        [self setupPage];
        [self addLabel];
    }
    
    return  self;
}
#pragma mark - 传递数据
-(void)setArray:(NSMutableArray *)array{
    
    _array = array;
    
    if (array.count > 0 ) {
        //添加定时器
        if (self.timer == nil) {
            [self addTimer];
        }
        
        //初始titlelbl
        ADNews *news = array[0];
        self.titleLbl.text = news.title;
        
        //[self.collectionView reloadData];
        
        //page数量
        self.page.numberOfPages = array.count;
    }
    
}

//#pragma mark - 添加定时器
-(void)addTimer{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
    self.timer = timer;
}

-(NSIndexPath *)resetIndexPath{
    NSIndexPath *currentIndexPage = [[self.collectionView indexPathsForVisibleItems] lastObject];
    NSIndexPath *currentIndexPageReset = [NSIndexPath indexPathForItem:currentIndexPage.item inSection:kMaxCount/2];
    [self.collectionView scrollToItemAtIndexPath:currentIndexPageReset atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    return currentIndexPageReset;
}

#pragma mark - 定时器下一页
-(void)nextPage{
    NSIndexPath *currentIndexPageReset = [self resetIndexPath];
    NSInteger item = currentIndexPageReset.item;
    NSInteger sec = currentIndexPageReset.section;
    item++;
    if (item == self.array.count) {
        item = 0;
        sec++;
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:item inSection:sec];
    [self.collectionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}

#pragma mark - 添加collectionViw
-(void)addCollection{
    UICollectionViewFlowLayout *flow = [[UICollectionViewFlowLayout alloc] init];
    flow.minimumLineSpacing = 0;
    
    flow.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    flow.itemSize = CGSizeMake(self.width, kCollectionViewH);
    
    UICollectionView *collection = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.bounds.size.width, kCollectionViewH) collectionViewLayout:flow];
    
    [collection registerClass:[ADHeaderCell class] forCellWithReuseIdentifier:@"cell"];
    collection.showsHorizontalScrollIndicator = NO;
    collection.backgroundColor = kColor(20, 20, 20, 0.1);
    collection.pagingEnabled = YES;
    collection.delegate = self;
    collection.dataSource = self;
    
    [self addSubview:collection];
    self.collectionView = collection;
}

#pragma mark - 底部label
-(void)addLabel{
    
    //小图标
    UIImageView *icon = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"night_photoset_list_cell_icon"]];
    icon.frame = CGRectMake(10, self.collectionView.height + 10, 20, 20);
    [self addSubview:icon];
    
    UILabel *title = [[UILabel alloc] init];
    title.font = [UIFont systemFontOfSize:12];
    CGFloat titleW = self.width - CGRectGetMaxX(icon.frame) - self.page.width -10;
    title.frame = CGRectMake(CGRectGetMaxX(icon.frame)+5, self.collectionView.height+10, titleW, 20);
    
    [self addSubview:title];
    self.titleLbl = title;
}

#pragma mark - 添加页控件
-(void)setupPage{
    UIPageControl *page = [[UIPageControl alloc] init];
    page.numberOfPages = self.array.count;
    page.pageIndicatorTintColor = [UIColor lightGrayColor];
    page.currentPageIndicatorTintColor = kColor(0, 0, 0, 0.8);
   
    CGFloat pageW = 80;
    CGFloat pageH = 30;
    CGFloat pageX = self.width - pageW;
    CGFloat pageY = self.collectionView.height +5;
    page.frame = CGRectMake(pageX, pageY, pageW, pageH);
    [self addSubview:page];
    self.page = page;
}

#pragma mark  返回多少组
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return kMaxCount;
}
#pragma mark  每组返回多少行
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    [self setArray:_array];
    return _array.count;
}
#pragma mark  返回单元
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ADHeaderCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    //ADDetailModel *detailModal = self.array[indexPath.row];
    ADNews *news = self.array[indexPath.row];
    cell.news = news;
    return cell;
    
}
#pragma mark  点击方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.array.count == 0) return;
    
    ADNews *news = self.array[indexPath.row];
    if ([self.delegate respondsToSelector:@selector(headerView:news:)]) {
        [self.delegate headerView:self news:news];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    int page = (scrollView.contentOffset.x/scrollView.frame.size.width+0.5);
    int currentPage = page%self.array.count;
    self.page.currentPage = currentPage;
    
    ADNews *news = self.array[currentPage];
    self.titleLbl.text = news.title;
}
@end
