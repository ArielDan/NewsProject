//
//  ADDataCache.h
//  新闻
//
//  Created by csip on 15/11/13.
//  Copyright © 2015年 ariel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADDataCache : NSObject

+(NSArray *)dataWithDic:(NSString *)ID;

+(void)deleteWithId:(NSString *)ID;

+(void)addArr:(NSArray *)arr andID:(NSString *)idStr;

+(void)addDict:(NSDictionary *)dict andID:(NSString *)idStr;

@end
