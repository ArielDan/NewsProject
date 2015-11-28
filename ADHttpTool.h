//
//  ADHttpTool.h
//  新闻
//
//  Created by csip on 15/11/13.
//  Copyright © 2015年 ariel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADHttpTool : NSObject


//请求新闻列表
+(void)getWithUrl:(NSString *)str parms:(NSDictionary *)parms idstr:(NSString *)idstr networkCount:(int)networkCount success:(void (^)(id))success failture:(void (^)(id))failture;

@end
