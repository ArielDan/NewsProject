//
//  ADNews.h
//  090506仿头条
//
//  Created by csip on 15/10/9.
//  Copyright (c) 2015年 ariel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ADNews : NSObject

//图片
@property(nonatomic,copy)NSString *imgsrc;
//标题
@property(nonatomic,copy)NSString *title;
@property(nonatomic,copy)NSString *subtitle;

//描述
@property(nonatomic,copy)NSString *digest;

//头部大图



//多图数组
@property(nonatomic,strong)NSArray *imgextra;
@property(nonatomic,copy)NSString *hasHead;

@property(nonatomic,copy)NSString *skipType;
@property(nonatomic,copy)NSString *photoSetID;

#pragma mark - 详细内容

@property(nonatomic,copy)NSString *replyCount;

@property(nonatomic,copy)NSString *publishTime;

@property(nonatomic,copy)NSString *content;

@property(nonatomic,copy)NSString *docid;


@end
