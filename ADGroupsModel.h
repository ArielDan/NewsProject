//
//  ADGroupsModel.h
//  新闻
//
//  Created by csip on 15/11/13.
//  Copyright © 2015年 ariel. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ADImageModel;

@interface ADGroupsModel : NSObject

@property (nonatomic,copy) NSString *goods_id;  //group_id  goods_name  goods_desc
@property (nonatomic,copy) NSString *group_info;
@property (nonatomic,copy) NSString *goods_name;
@property (nonatomic,copy) NSString *goods_desc;
@property (nonatomic,copy) NSString *goods_display_final_price;  //产品的价格
@property (nonatomic,copy) NSString *goods_display_color_name;  //产品的颜色

//图片模型
@property(nonatomic,strong) ADImageModel *image;

//存放图片模型数组
@property(nonatomic,strong) NSArray *goods_image;
@end
