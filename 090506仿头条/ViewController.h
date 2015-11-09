//
//  ViewController.h
//  090506仿头条
//
//  Created by csip on 15/9/5.
//  Copyright (c) 2015年 ariel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,copy)NSMutableArray *newsDetail;

@property(nonatomic,copy)NSString *indexPath;

//@property(nonatomic,strong)NSString *getNews;

+(instancetype)getInstance;

@end

