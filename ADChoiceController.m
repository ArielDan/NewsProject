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

#define kURL @"http://v.higo.meilishuo.com/goods/goods_discover"

static ADChoiceController *instance;

@interface ADChoiceController()<ADTitleViewDelegate>

@property(nonatomic,assign) int networkCount;

@property(nonatomic,strong) ADTitleView *titleView;
@property(nonatomic,strong) ADGroupsModel *model;
@property(nonatomic,strong) NSMutableArray *arrFrame;

@end

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

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    instance = self;
    [self sendRequest];
    [self setupTitleView];
    
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    
}

-(void)setupTitleView{
    ADTitleView *titleView = [[ADTitleView alloc] init];
    titleView.frame = CGRectMake(0, 0, self.view.width, self.navigationController.navigationBar.height);
    self.navigationItem.titleView = titleView;
    
    titleView.delegate = self;
    
    self.titleView = titleView;
}

#pragma mark - 发送网络请求，获取数据

-(void)sendRequest{
    
    NSString *urlStr = kURL;
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    
    manager.responseSerializer.acceptableContentTypes = [manager.responseSerializer.acceptableContentTypes setByAddingObject:@"text/html"];
    
    // 网络访问是异步的,回调是主线程的,因此程序员不用管在主线程更新UI的事情
    [manager GET:urlStr parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        
        NSArray *list = responseObject[@"data"][@"goods_list"];
//        for (ADGroupsModel *goodsModel in list) {
//            NSLog(@"%@",goodsModel.goods_desc);
//            
//            ADGoodsFrame *frame = [[ADGoodsFrame alloc] init];
//            //传递模型
//            frame.goodsModel = goodsModel;           
//            [arr addObject:frame];
//        }
//        
//        [self.arrFrame addObjectsFromArray:arr];
//        
//        [self.tableView reloadData];
        [list enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //商品展示数据
            ADGroupsModel *model = [[ADGroupsModel alloc] init];;
            [model setValue:obj[@"goods_name"] forKey:@"goods_name"];
            [model setValue:obj[@"goods_id"] forKey:@"goods_id"];
            [model setValue:obj[@"goods_desc"] forKey:@"goods_desc"];
            [model setValue:obj[@"goods_display_final_price"] forKey:@"goods_display_final_price"];
            [model setValue:obj[@"main_image"] forKey:@"goods_image"];
            //[model setValuesForKeysWithDictionary:obj];
            
            ADGoodsFrame *frame = [[ADGoodsFrame alloc] init];
            frame.goodsModel = model;
            
            _model = model;
            //frame模型添加至数组
            [self.arrFrame addObject:frame];
        }];
        
        NSLog(@"%d",self.arrFrame.count);
        [self.tableView reloadData];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"%@",error);
    }];
    
}

#pragma mark titleView代理方法
-(void)titleView:(ADTitleView *)titleView pushController:(UIViewController *)controller{
//    [self.navigationController pushViewController:controller animated:YES];
    [self presentViewController:controller animated:YES completion:nil];
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.arrFrame.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    static NSString *indentifier = @"cell";
    [self.tableView registerClass:[ADChoiceCell class] forCellReuseIdentifier:indentifier];
    
    ADChoiceCell *cell = [self.tableView dequeueReusableCellWithIdentifier:indentifier forIndexPath:indexPath];
    if (cell == nil) {
        cell = [[ADChoiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:indentifier];
    }
    
    cell.goodsFrame = self.arrFrame[indexPath.row];
    return cell;
    
}

@end
