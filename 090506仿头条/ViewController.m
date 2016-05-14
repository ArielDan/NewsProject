//
//  ViewController.m
//  090506仿头条
//
//  Created by csip on 15/9/5.
//  Copyright (c) 2015年 ariel. All rights reserved.
//

#import "ViewController.h"
#import "ADWheatherView.h"
#import "ADWeatherModal.h"
#import "ADHeaderCell.h"
#import "ADNewsHeaderView.h"

#import "MJRefresh.h"

#import "ADNewsTableViewCell.h"
#import "ImageTableViewCell.h"

#import "GetDataInterfaceJSON.h"
#import "ADNews.h"

#import "AFNetworking.h"

#import "UIView+Frame.h"

#import "ADNewsDetailController.h"
#import "ADTabBar.h"
#import "ADTabBarController.h"
#import "ADNewsHeaderView.h"

//NEWS:http://c.m.163.com/nc/article/headline/T1348647853363/0-30.html


static ViewController *instance;
static NSString *indentifier = @"commondCell";
static NSString *extraIndentify = @"extraCell";

@interface ViewController ()<ADTabBarDelegate,ADHeaderViewDelegate>{
    ADNewsDetailController *_newsController;
    
    //NSMutableArray *_newsDetail;
    
    NSMutableArray *_cellHeight;//单元格高度
    
}

//@property(strong,nonatomic) SlideView *slideView;
@property(strong,nonatomic) ADTabBarController *tabBarController;

@property(strong,nonatomic) ADWheatherView *weatherView;

@property(strong,nonatomic) ADWeatherModal *weatherModal;

@property(strong,nonatomic) UIView *bottomView;

@property(assign) NSInteger tabCount;

@property(strong,nonatomic) UIButton *rightBtn;
@property(nonatomic,strong) UIBarButtonItem *rightItem;

@property(strong,nonatomic) UIImageView *tran;

@property(nonatomic,assign,getter=isWeatherShow)BOOL weatherShow;

@property(nonatomic,strong) UITableView *tableView;

//标题栏
@property(nonatomic,strong) UIScrollView *titleScroll;


//存放新闻URL数组
@property(nonatomic,strong) NSMutableArray *newsLists;
//头部视图
@property(nonatomic,strong) ADNewsHeaderView *headerView;

@property(nonatomic,strong) ImageTableViewCell *imageCell;
@property(nonatomic,strong) ADNewsTableViewCell *cell;

@end

#define kURL @"http://c.m.163.com/nc/article/headline/T1348647853363/0-10.html"

@implementation ViewController

#pragma mark - 懒加载
-(NSArray *)newsLists{
    if (_newsLists == nil) {
        _newsLists = [NSMutableArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"NewsURLs.plist" ofType:nil]];
    }
   
    return _newsLists;
}
-(void)viewWillAppear:(BOOL)animated{
    
    //异步请求数据
   // [self loadNewsDataWithMutiThread];
    [self getNewsData:kURL];
    
    self.rightBtn.hidden = NO;
    self.rightBtn.alpha = 0;
    [UIView animateWithDuration:0.4 animations:^{
        self.rightBtn.alpha = 1;
    }];
    
    [self.navigationController setNavigationBarHidden:NO animated:YES];
    
    // 马上进入刷新状态
    //[self.tableView.header beginRefreshing];
}


-(void)viewWillDisappear:(BOOL)animated{
    self.rightBtn.hidden = YES;
    self.rightBtn.transform = CGAffineTransformIdentity;
    [self.rightBtn setImage:[UIImage imageNamed:@"top_navigation_square"] forState:UIControlStateNormal];
    
}

- (void)viewDidLoad {
  
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self layout];
    [self addHeaderView];
    
    _newsController = [[ADNewsDetailController alloc] init];
    //_tabBarController = [[ADTabBarController alloc] init];
    
    
    //[self getNewsData:url];
    
    //[self tableRefresh];
    [self setupRefresh];
    [_tableView registerClass:[ADNewsTableViewCell class]  forCellReuseIdentifier:indentifier];
    [_tableView registerNib:[UINib nibWithNibName:@"ImageTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:extraIndentify];
    
    //获取cell实例
    _imageCell = [_tableView dequeueReusableCellWithIdentifier:extraIndentify];
    _cell = [_tableView dequeueReusableCellWithIdentifier:indentifier];

    //添加约束后代替高度的代理方法
//    _tableView.estimatedRowHeight = 240;
//    _tableView.rowHeight = UITableViewAutomaticDimension;
}

-(void)layout{
    
    _newsDetail = [[NSMutableArray alloc] init];
    
    _cellHeight = [[NSMutableArray alloc] init];
    
    self.rightBtn = [[UIButton alloc]init];
    
//    UIWindow *win = [UIApplication sharedApplication].windows.firstObject;
//
//    [win addSubview:_rightBtn];
//    
//    [self.view addSubview:_rightBtn];
//    
//    self.rightBtn.y = 20;
//    self.rightBtn.width = 45;
//    self.rightBtn.height = 45;
//    self.rightBtn.x = [UIScreen mainScreen].bounds.size.width - self.rightBtn.width;
    
    self.rightBtn.frame = CGRectMake([UIScreen mainScreen].bounds.size.width  - _rightBtn.width, 10, 45, 45);
    //[self.rightBtn setTitle:@"+" forState:UIControlStateNormal];
    [self.rightBtn setImage:[UIImage imageNamed:@"top_navigation_square"] forState:UIControlStateNormal];
    [self.rightBtn addTarget:self action:@selector(rightBtnClick) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithCustomView:self.rightBtn];
    _rightItem = rightItem;
    self.navigationItem.rightBarButtonItem = rightItem;
    
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    
    [self.view addSubview:_tableView];
}

#pragma mark - 数据刷新
-(void)setupRefresh{
    //__block使变量能在block中被修改
    __block int temp = 10;
    
    //下拉刷新
    //进入刷新状态后自动调用
    _tableView.header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [self loadData];
        [self.tableView.header endRefreshing];

    }];
    //自动切换透明度
    _tableView.header.automaticallyChangeAlpha = YES;

    //上拉刷新
    _tableView.footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        
        NSString *url = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/headline/T1348647853363/%d-10.html",temp];
        [self getNewsData:url];
        
        [self loadMoreData:url];
        
        temp = temp + 10;
        
    }];
}

#pragma mark - 添加头部视图
-(void)addHeaderView{
    ADNewsHeaderView *headerView = [[ADNewsHeaderView alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(self.navigationController.navigationBar.frame), self.view.width, kHeaderViewH)];
    headerView.delegate = self;
    self.tableView.tableHeaderView = headerView;
    self.headerView = headerView;
    
}
#pragma mark 头部视图的代理方法
#warning 头部视图代理方法--点击
-(void)headerView:(ADNewsHeaderView *)headerView news:(ADNews *)news{
    
}

-(void)loadMoreData:(NSString *)url{
    [_tableView reloadData];
    [_tableView.footer endRefreshing];
    
}
-(void)loadData{

    [_tableView reloadData];
    [self.tableView.header endRefreshing];
}

#pragma mark- 导航栏右键点击
-(void)rightBtnClick{
    
    if (self.isWeatherShow) {
        self.weatherView.hidden = YES;
        self.tran.hidden = YES;
        
        [UIView animateWithDuration:0.1 animations:^{
            self.rightBtn.transform = CGAffineTransformRotate(self.rightBtn.transform, M_1_PI * 5);
        } completion:^(BOOL finished) {
            [self.rightBtn setImage:[UIImage imageNamed:@"top_navigation_square"] forState:UIControlStateNormal];
        }];
    }else {
        
        [self getWeather];
        
        [self.rightBtn setImage:[UIImage imageNamed:@"223"] forState:UIControlStateNormal];
      
        self.weatherView.hidden = NO;
        self.tran.hidden = NO;
        //[self.weatherView addAnimate];
        [UIView animateWithDuration:0.2 animations:^{
            self.rightBtn.transform = CGAffineTransformRotate(self.rightBtn.transform, -M_1_PI * 6);
        } completion:^(BOOL finished) {
            
            [UIView animateWithDuration:0.1 animations:^{
                self.rightBtn.transform = CGAffineTransformRotate(self.rightBtn.transform, M_1_PI);
            }];
        }];
    }
   
    self.weatherShow = !self.isWeatherShow;
    
    
}

#pragma mark - 天气信息
-(void)addWeather{
    
    ADWheatherView *weatherView = [[ADWheatherView alloc] init];
    weatherView.frame = [UIScreen mainScreen].bounds;
    
    weatherView.weatherModal = self.weatherModal;
    _weatherView = weatherView;
    
    weatherView.alpha = 0.9;

    [self.view insertSubview:weatherView atIndex:1];
    
    _tran = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"224"]];
    
    _tran.width = 7;
    _tran.height = 7;
    _tran.y = 57;
    _tran.x = [UIScreen mainScreen].bounds.size.width - 33;
    
    //[win addSubview:_tran];
    [self.view insertSubview:_tran atIndex:2];
    
    
    weatherView.y = 64;
    weatherView.height -= 64;
    
    self.weatherView.hidden = YES;
    
    self.tran.hidden = YES;
    
    //注册观察者
    //[[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(pushWeatherDetail) name:@"pushWeahterDetail" object:nil];
    
    //NSLog(@"addWeather");
}

//http://c.3g.163.com/nc/weather/5YyX5LqsfOWMl%2BS6rA%3D%3D.html

#pragma mark 获取天气数据
-(void)getWeather{
    NSString *path = @"http://c.3g.163.com/nc/weather/5YyX5LqsfOWMl%2BS6rA%3D%3D.html";
    
    path = [path stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSURL *url = [NSURL URLWithString:path];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:url cachePolicy:NSURLRequestReloadIgnoringLocalCacheData timeoutInterval:10.0];
    
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:nil];

    //使用IOS5自带解析类NSJSONSerialization方法解析
    NSError *error;
    NSDictionary *weatherDic = [NSJSONSerialization JSONObjectWithData:response options:NSJSONReadingMutableLeaves error:&error];
    
    NSArray *dic = [weatherDic objectForKey:@"北京|北京"];
    
    NSDictionary *weatherInfo = [dic objectAtIndex:0];
    
    //_weatherModal = [[ADWeatherModal alloc] init];
    ADWeatherModal *modal = [[ADWeatherModal alloc] init];

    //[modal setValue:[weatherInfo objectForKey:@"nongli"] forKey:@"nongli"];
    [modal setValue:[weatherInfo objectForKey:@"climate"] forKey:@"climate"];
    [modal setValue:[weatherInfo objectForKey:@"date"] forKey:@"date"];
    [modal setValue:[weatherInfo objectForKey:@"wind"] forKey:@"wind"];
    [modal setValue:[weatherInfo objectForKey:@"dt"] forKey:@"dt"];
    [modal setValue:[weatherInfo objectForKey:@"pm2_5"] forKey:@"pm2d5"];
    [modal setValue:[weatherInfo objectForKey:@"temperature"] forKey:@"temperature"];
    [modal setValue:[weatherInfo objectForKey:@"nongli"] forKey:@"nongli"];
    [modal setValue:[weatherInfo objectForKey:@"week"] forKey:@"week"];
    _weatherModal = modal;

    [self addWeather];
    
}

#pragma mark - 新闻

-(void)loadNewsDataWithMutiThread{
    
    //取得全局队列
    dispatch_queue_t globalQueue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    //异步执行队列任务
    dispatch_async(globalQueue, ^{
        [self getNewsData:kURL];
    });
}

-(void)getNewsData:(NSString *)url{
    
    NSError *error;
    //NSString *url = @"http://c.m.163.com/nc/article/headline/T1348647853363/0-15.html";
    NSString *str = [[NSString alloc] initWithString:[GetDataInterfaceJSON getDataWithRequest:url]];
    
    //对象序列化为字典
    
    NSData *jsonData = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:&error];
    NSArray *list = [dic objectForKey:@"T1348647853363"];
    
    //数组遍历
    [list enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        ADNews *news = [[ADNews alloc] init];
        
        [news setValue:obj[@"imgsrc"] forKey:@"imgsrc"];
        [news setValue:obj[@"title"] forKey:@"title"];
        [news setValue:obj[@"digest"] forKey:@"digest"];
        [news setValue:obj[@"replyCount"] forKey:@"replyCount"];
        [news setValue:obj[@"docid"] forKey:@"docid"];
        
        [news setValue:obj[@"imgextra"] forKey:@"imgextra"];
        [news setValue:obj[@"hasHead"] forKey:@"hasHead"];
        [news setValue:obj[@"skipType"] forKey:@"skipType"];
    
        if (news.skipType != nil) {
            [news setValue:obj[@"photosetID"] forKey:@"photoSetID"];
        }
        
        [_newsDetail addObject:news];
        
        //存储tableViewCell
        ADNewsTableViewCell *cell = [[ADNewsTableViewCell alloc] init];
        [_cellHeight addObject:cell];
        
        
    }];
    if (_newsDetail.count == 0) {
        MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.mode = MBProgressHUDModeText;
        hud.label.text = @"网络请求失败";
        hud.margin = 10.f;
        hud.removeFromSuperViewOnHide = YES;
        [hud hideAnimated:YES afterDelay:5];
    }else{
        //取前五个放入头部视图
        NSRange range = NSMakeRange(0, 5);
        self.headerView.array = [_newsDetail subarrayWithRange:range];
        //更新UI界面，调用GCD主线程队列的方法
//        dispatch_queue_t mainQueue = dispatch_get_main_queue();
//        dispatch_sync(mainQueue, ^{
//            [self.tableView reloadData];
//        });
        //self.headerView.array = _newsDetail;
    }
   

}



#pragma  mark - 网络状态变化提示
-(void)alert:(NSString *)message{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction *okBtn = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil];
    [alert addAction:okBtn];
    
    
    [self.navigationController pushViewController:alert animated:YES];
}

#pragma mark - 检测网络状态
-(void)chectNetworkStatus{
    //创建用于测试的url
    NSURL *url = [NSURL URLWithString:@"www.baidu.com"];
    AFHTTPRequestOperationManager *operationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
    
    //不同的网络状态
    [operationManager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusReachableViaWWAN:
                [self alert:@"2G/3G/4G Connection."];
                NSLog(@"2G/3G/4G Connection.");
                break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                [self alert:@"WiFi Connection."];
                NSLog(@"WiFi Connection.");
                break;
                case AFNetworkReachabilityStatusNotReachable:
                [self alert:@"Network not found."];
                NSLog(@"Network not found.");
                break;
                case AFNetworkReachabilityStatusUnknown:
                [self alert:@"Unknown."];
                NSLog(@"Unknown.");
                break;
                
            default:
                break;
        }
    }];
    
    
    //开始监控
    [operationManager.reachabilityManager startMonitoring];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - tableview data source
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _newsDetail.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
   // NSLog(@"%@",[_newsDetail valueForKey:@"imgextra"]);
    if ([_newsDetail[indexPath.row] valueForKey:@"imgextra"] != nil ) {
        ImageTableViewCell *imageCell = [_tableView dequeueReusableCellWithIdentifier:extraIndentify forIndexPath:indexPath];
        
        imageCell.news = _newsDetail[indexPath.row];
        
        return imageCell;
    }else{
        ADNewsTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:indentifier forIndexPath:indexPath];
        
        cell.news = _newsDetail[indexPath.row];
        
        return  cell;
    }
    

}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //获取当前点击的cell
//    ADNewsTableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    _indexPath = [NSString stringWithFormat:@"%ld",(long)indexPath.row];
    
    NSMutableArray *get = [[NSMutableArray alloc] init];
    get = [_newsDetail objectAtIndex:indexPath.row];
    NSString *getNews = [NSString stringWithFormat:@"%@",[get valueForKey:@"docid"]];
    
    _newsController.getNews = getNews;
 
    [self.navigationController pushViewController:_newsController animated:YES];

}


#pragma mark - tableView代理方法,单元格高度

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if ([_newsDetail[indexPath.row] valueForKey:@"imgextra"] != nil ){
        //ImageTableViewCell *imageCell = _newsDetail[indexPath.row];
        //_imageCell.news = _newsDetail[indexPath.row];
        CGSize size = [_imageCell.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
        
        return size.height + 1;
    }else{
        //ADNewsTableViewCell *cell = _newsDetail[indexPath.row];
        _cell.news = _newsDetail[indexPath.row];
        
        return _cell.height;
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 240.f;
}



@end
