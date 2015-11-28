//
//  ADCommonHttpTool.h
//  新闻
//
//  Created by csip on 15/11/14.
//  Copyright © 2015年 ariel. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "AFHTTPSessionManager.h"

@interface ADCommonHttpTool : AFHTTPSessionManager

+(instancetype)sharedNetworkTools;

@end
