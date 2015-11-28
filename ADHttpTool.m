//
//  ADHttpTool.m
//  新闻
//
//  Created by csip on 15/11/13.
//  Copyright © 2015年 ariel. All rights reserved.
//

#import "ADHttpTool.h"
#import "ADDataCache.h"
#import "ADCommonHttpTool.h"

@implementation ADHttpTool

//networkCount:请求新数据次数

+(void)getWithUrl:(NSString *)str parms:(NSDictionary *)parms idstr:(NSString *)idstr networkCount:(int)networkCount success:(void (^)(id))success failture:(void (^)(id))failture{
    
    //如果数据库里面有值就先读取数据库
    //第一次请求数据
    if (idstr.length>0 && networkCount<=1) {
        //获取所有新闻
        NSArray *arr = [ADDataCache dataWithDic:idstr];
        if (arr.count>0) {
            success(arr);
            return;
        }
    }
    
    //数据库里面没有直接发送网络请求
    [[ADCommonHttpTool sharedNetworkTools] GET:str parameters:parms success:^(NSURLSessionDataTask *task, id responseObject) {
        NSDictionary *dict = (NSDictionary*)responseObject;
        NSString *key = [dict.keyEnumerator nextObject];
        NSArray *tempArray = dict[key];
        //idstr有值，表示下拉刷新获取新数据
        if (idstr.length>0) {
            //发送网络请求获取最新数据  先清空旧的数据
            [ADDataCache deleteWithId:idstr];
            //数据缓存
            [ADDataCache addArr:tempArray andID:idstr];
            
        }
        
        if (success) {
            success(tempArray);
        }
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        if (failture) {
            failture(error);
        }
    }];
    
    
}

@end
