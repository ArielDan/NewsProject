//
//  ADGoodsFrame.h
//  新闻
//
//  Created by csip on 15/11/13.
//  Copyright © 2015年 ariel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@class ADGroupsModel;

@interface ADGoodsFrame : NSObject

@property(nonatomic,strong) ADGroupsModel *goodsModel;

//第一张大图frame
@property(nonatomic,assign,readonly) CGRect imageF;
//小图
@property(nonatomic,assign,readonly) CGRect oneSmallF;
@property(nonatomic,assign,readonly) CGRect twoSmallF;
@property(nonatomic,assign,readonly) CGRect threeSmallF;

//描述文字
@property(nonatomic,assign,readonly) CGRect descF;
//地址
@property(nonatomic,assign,readonly) CGRect addressF;

//单元格高度
@property(nonatomic,assign) CGFloat cellH;

@end
