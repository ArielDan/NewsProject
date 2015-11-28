//
//  ADCommonHttpTool.m
//  新闻
//
//  Created by csip on 15/11/14.
//  Copyright © 2015年 ariel. All rights reserved.
//

#import "ADCommonHttpTool.h"

@implementation ADCommonHttpTool

+(instancetype)sharedNetworkTools{
    
    static ADCommonHttpTool *httpTool;
    static dispatch_once_t onceToken;
    
    //单例
    dispatch_once(&onceToken,^{
        NSURL *url = [NSURL URLWithString:@"http://c.m.163.com/"];
        NSURLSessionConfiguration *config = [NSURLSessionConfiguration defaultSessionConfiguration];
        httpTool = [[self alloc] initWithBaseURL:url];
        
        httpTool.responseSerializer.acceptableContentTypes=[NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript", @"text/html", nil];
    });
    
    return  httpTool;
}

@end
