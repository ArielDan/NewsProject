//
//  ADChoiceController.m
//  新闻
//
//  Created by csip on 15/11/13.
//  Copyright © 2015年 ariel. All rights reserved.
//

#import "ADChoiceController.h"
#import "ADTitleView.h"
#import "UIView+Frame.h"

#import "AFNetworking.h"

#import "ADHttpTool.h"
#import "ADDataCache.h"

#import "ADGroupsModel.h"
#import "ADGoodsFrame.h"

#import "ADChoiceCell.h"
#import "ADNavigationBar.h"
#import "ADNavigationController.h"
#import "ADFindController.h"

#define kURL @"http://v.higo.meilishuo.com/goods/goods_discover"

static ADChoiceController *instance;

@interface ADChoiceController()

@property(nonatomic,assign) int networkCount;

@property(nonatomic,strong) ADTitleView *titleView;
@property(nonatomic,strong) ADGroupsModel *model;
@property(nonatomic,strong) NSMutableArray *arrFrame;

@end

 static NSString *indentifier = @"cell";

@implementation ADChoiceController
+(instancetype)getInstance{
    return instance;
}
-(NSMutableArray *)arrFrame{
    if (!_arrFrame) {
        _arrFrame = [NSMutableArray array];
    }
    
    return _arrFrame;
}
//-(ADTitleView *)titleView{
//    if (!_titleView) {
//        _titleView = [[ADTitleView alloc] init];
//        _titleView.backgroundColor =[UIColor cyanColor];
//        [self.navigationController.view addSubview:_titleView];
//    }
//    return _titleView;
//}

-(void)viewWillAppear:(BOOL)animated{
    instance = self;
   // [self setupTitleView];
}

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    
    [self sendRequest];
   // [self addTopView];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
    [self.tableView registerClass:[ADChoiceCell class] forCellReuseIdentifier:indentifier];   
    
//    ADFindController *findVC = [[ADFindController alloc] init];
//    
//    __weak typeof(ADChoiceController) *weakSelf = self;
//    self.showControllerBlock = ^(){
//        [weakSelf presentViewController:findVC animated:YES completion:nil];
//    };
}



#pragma mark - 发送网络请求，获取数据

-(void)sendRequest{
    
    NSString *urlStr = kURL;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    // 网络访问是异步的,回调是主线程的,因此程序员不用管在主线程更新UI的事情
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *list = responseObject[@"data"][@"goods_list"];

        [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //商品展示数据
            ADGroupsModel *model = [[ADGroupsModel alloc] init];;
            [model setValue:obj[@"goods_name"] forKey:@"goods_name"];
            [model setValue:obj[@"goods_id"] forKey:@"goods_id"];
            //[model setValue:obj[@"goods_desc"] forKey:@"goods_desc"];
            [model setValue:obj[@"goods_display_final_price"] forKey:@"goods_display_final_price"];
            [model setValue:obj[@"group_info"] forKey:@"group_info"];
            [model setValue:obj[@"main_image"] forKey:@"goods_image"];
            //[model setValuesForKeysWithDictionary:obj];
            
            ADGoodsFrame *frame = [[ADGoodsFrame alloc] init];
            frame.goodsModel = model;
            
            _model = model;
            //frame模型添加至数组
            [self.arrFrame addObject:frame];
        }];
        
        
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.arrFrame.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    ADChoiceCell *cell = [self.tableView dequeueReusableCellWithIdentifier:indentifier forIndexPath:indexPath];
    
    cell.goodsFrame = self.arrFrame[indexPath.row];
    //cell.groupModel = self.arrFrame[indexPath.row];
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 180.f;
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ADGoodsFrame *frame = self.arrFrame[indexPath.row];
    return frame.cellH;
}

@end
