//
//  AnswerModel.h
//  新闻
//
//  Created by yj on 16/5/13.
//  Copyright © 2016年 ariel. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AnswerModel : NSObject

@property (nonatomic,strong) NSString *title;
@property (nonatomic,strong) NSString *time;
@property (nonatomic,strong) NSString *summary;
@property (nonatomic,strong) NSString *questionid;
@property (nonatomic,strong) NSString *answerid;
@property (nonatomic,strong) NSString *authorname;
@property (nonatomic,strong) NSString *authorhash;
@property (nonatomic,strong) NSString *avatar;
@property (nonatomic,assign) NSInteger vote;

@end
