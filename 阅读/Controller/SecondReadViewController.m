//
//  SecondReadViewController.m
//  新闻
//
//  Created by yj on 16/5/13.
//  Copyright © 2016年 ariel. All rights reserved.
//

#import "SecondReadViewController.h"
#import "AFNetworking.h"
#import "AnswerModel.h"
#import "AnswerTableViewCell.h"

@interface SecondReadViewController ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSString *urlString;

@property (nonatomic,strong) NSMutableArray *dataArray;

@property (nonatomic,strong) UITableView *tableView;

@end

@implementation SecondReadViewController

-(NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
        
    }
    return  _dataArray;
}
-(NSString *)urlString{
    if (!_urlString) {
        _urlString = [NSString stringWithFormat:@"http://api.kanzhihu.com/getpostanswers/%@/%@",self.parameterDate,self.parameterName];
        NSLog(@"%@",_urlString);
    }
    return _urlString;
}


-(void)viewWillAppear:(BOOL)animated{
    
    [self getDataFromInternet:self.urlString];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:_tableView];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_tableView registerNib:[UINib nibWithNibName:@"AnswerTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"Answer"];
    
    _tableView.estimatedRowHeight = 240.f;
    _tableView.rowHeight = UITableViewAutomaticDimension;
    
}

-(void)getDataFromInternet:(NSString *)url{
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    [manager GET:url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSArray *list = responseObject[@"answers"];
        
        [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            AnswerModel *model = [[AnswerModel alloc] init];
            [model setValuesForKeysWithDictionary:obj];
            
            [self.dataArray addObject:model];
        }];
        
        [self.tableView reloadData];
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        MBProgressHUD *hub = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hub.mode = MBProgressHUDModeCustomView;
        hub.label.text = @"网络出错";
        [hub hideAnimated:YES afterDelay:5];
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    AnswerTableViewCell *cell = [_tableView dequeueReusableCellWithIdentifier:@"Answer" forIndexPath:indexPath];
    cell.answerModel = self.dataArray[indexPath.row];
    return cell;
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    //获取questionid
    NSString *questionid = [self.dataArray[indexPath.row] valueForKey:@"questionid"];
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"https://www.zhihu.com/question/%@",questionid]];
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:url];
    UIWebView *webView = [[UIWebView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:webView];
    [webView loadRequest:request];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
