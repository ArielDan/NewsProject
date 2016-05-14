//
//  ReadDataModel.h
//  新闻
//
//  Created by yj on 16/5/13.
//  Copyright © 2016年 ariel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ReadDataModel : NSObject

@property (nonatomic,strong) NSString *id;
@property (nonatomic,strong) NSString *name;
@property (nonatomic,strong) NSString *date;
@property (nonatomic,strong) NSString *pic;
@property (nonatomic,strong) NSString *publishtime;
@property (nonatomic,assign) NSInteger count;
@property (nonatomic,strong) NSString *excerpt; //摘要文字

@end
