//
//  ADFindModel.h
//  新闻
//
//  Created by yj on 16/4/7.
//  Copyright © 2016年 ariel. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ADImageModel;

@interface ADFindModel : NSObject

//"goods_id":"196830213480237050","goods_name":"\u3010\u8857\u62cd\u5fc5\u5907\u3011\u96f7\u670bray-ban\u98de\u884c\u5458\u7cfb\u5217\u65f6\u5c1a\u592a\u9633\u955c \u7ecf\u5178\u86e4\u87c6\u955c","goods_repertory":21,"goods_status":"1","goods_display_currency_unit_cny":"CNY","goods_display_currency_unit_cny_symbol":"\uffe5","goods_display_discount":"5.7","goods_display_list_price_cny":"1580.00","goods_display_final_price_cny":"899.00","goods_display_final_price":"899.00","goods_display_list_price":"1580.00",
//"group_info":{"country":"\u6cd5\u56fd","city":"\u963f\u57fa\u5766"},
//"main_image":
//"label":[],"pro":"0","hearts_number":"22"}

@property (nonatomic,copy) NSString *goods_id;  //group_id  goods_name  goods_desc
@property (nonatomic,copy) NSDictionary *group_info; //城市信息
@property (nonatomic,copy) NSString *shop_id;
@property (nonatomic,copy) NSString *goods_name;
@property (nonatomic,copy) NSString *goods_repertory;//库存
@property (nonatomic,copy) NSString *goods_status;
@property (nonatomic,copy) NSString *goods_display_currency_unit_cny;
@property (nonatomic,copy) NSString *goods_display_currency_unit_cny_symbol;
@property (nonatomic,copy) NSString *goods_display_discount;
@property (nonatomic,copy) NSString *goods_desc;
@property (nonatomic,copy) NSString *goods_display_list_price_cny;
@property (nonatomic,copy) NSString *goods_display_final_price_cny;
@property (nonatomic,copy) NSString *goods_display_list_price;
@property (nonatomic,copy) NSString *goods_display_final_price;  //产品的价格
@property (nonatomic,copy) NSString *goods_display_color_name;  //产品的颜色
@property (nonatomic,copy) NSArray *label;
@property (nonatomic,copy) NSString *superGreatFlag;
@property (nonatomic,copy) NSString *goodsTags;
@property (nonatomic,assign) NSInteger salesVolume;
@property (nonatomic,copy) NSString *pro;
@property (nonatomic,copy) NSString *hearts_number;
@property (nonatomic,assign) BOOL isWish;

//图片模型
@property (nonatomic,strong) ADImageModel *main_image;

@property (nonatomic,copy) NSString *country;
@property (nonatomic,copy) NSString *city;

@end
