//
//  GetDataInterfaceJSON.h
//  090506仿头条
//
//  Created by csip on 15/10/9.
//  Copyright (c) 2015年 ariel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GetDataInterfaceJSON : NSObject<NSURLConnectionDataDelegate>

+(id)getDataWithRequest:(NSString *)requestStr;

@end
