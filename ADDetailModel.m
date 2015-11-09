//
//  ADDetailModel.m
//  090506仿头条
//
//  Created by csip on 15/10/12.
//  Copyright (c) 2015年 ariel. All rights reserved.
//

#import "ADDetailModel.h"

@implementation ADDetailModel

//遍历构造器
+ (instancetype)detailWithDic:(NSDictionary *)dic{
    ADDetailModel *detail = [[self alloc] init];
    detail.title = dic[@"title"];
    detail.ptime = dic[@"ptime"];
    detail.body = dic[@"body"];
    
    NSArray *imgArray = dic[@"img"];
    
    NSMutableArray *tempArray = [NSMutableArray arrayWithCapacity:imgArray.count];
    
//    for (NSDictionary *dict in imgArray) {
//        <#statements#>
//    }
    
    return detail;
}

@end
