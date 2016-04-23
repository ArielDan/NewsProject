//
//  GetDataInterfaceJSON.m
//  090506仿头条
//
//  Created by csip on 15/10/9.
//  Copyright (c) 2015年 ariel. All rights reserved.
//

#import "GetDataInterfaceJSON.h"
#import "AFNetworking.h"
#import "MBProgressHUD.h"

@implementation GetDataInterfaceJSON

#pragma mark - 判断是否连接网络


+(void)connectedToNetwork{
    
    //创建一个用于测试的url
    NSURL *url = [NSURL URLWithString:@"www.baidu.com"];
    AFHTTPRequestOperationManager *operationManager = [[AFHTTPRequestOperationManager alloc] initWithBaseURL:url];
    
    //不同网络状态
    [operationManager.reachabilityManager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status){
                case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"2/3/4G Connection");
                break;
                case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WIFI");
                break;
                case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"Not Connection");
                break;
                
                default:
                NSLog(@"Unknown");
                break;
        }
        
    }];
    
    //开始监控
    [operationManager.reachabilityManager startMonitoring];
    
}

+(id)getDataWithRequest:(NSString *)requestStr{
    NSString *escapedURLStr = [requestStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    NSError *error;
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:escapedURLStr]];
    
    NSData *response = [NSURLConnection sendSynchronousRequest:request returningResponse:nil error:&error];
    
    NSString *responseStr = [[NSString alloc] initWithData:response encoding:NSUTF8StringEncoding];
    return responseStr;
}



@end
