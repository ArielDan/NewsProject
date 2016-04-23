//
//  ADImageModel.h
//  新闻
//
//  Created by yj on 16/4/7.
//  Copyright © 2016年 ariel. All rights reserved.
//

#import <Foundation/Foundation.h>

//"main_image":{"image_id":"196829814671139956","image_path":"","fdfs_path":"","mfs_path":"","higo_path":"pic\/_o\/a3\/df\/8cd78729867add8ab77cbc457ab5_750_750.cz.jpg","image_width":"750","image_height":"750","image_size":"27433","image_original":"http:\/\/pic.lehe.com\/pic\/_o\/a3\/df\/8cd78729867add8ab77cbc457ab5_750_750.cz.jpg","image_middle":"http:\/\/pic.lehe.com\/pic\/_o\/a3\/df\/8cd78729867add8ab77cbc457ab5_750_750.cz.jpg_3e918539_s1_q0_150_5_0_640_3000.jpg","image_poster":"http:\/\/pic.lehe.com\/pic\/_o\/a3\/df\/8cd78729867add8ab77cbc457ab5_750_750.cz.jpg_b26657b4_s1_q0_150_5_0_290_2000.jpg","image_thumbnail":"http:\/\/pic.lehe.com\/pic\/_o\/a3\/df\/8cd78729867add8ab77cbc457ab5_750_750.cz.jpg_64e9eae6_s5_q0_150_5_0_120_120.jpg"},

@interface ADImageModel : NSObject

@property (nonatomic,copy) NSString *image_id;
@property (nonatomic,copy) NSString *image_path;
@property (nonatomic,copy) NSString *fdfs_path;

@property (nonatomic,copy) NSString *higo_path;

@property (nonatomic,assign) NSInteger image_width;
@property (nonatomic,assign) NSInteger image_height;
@property (nonatomic,assign) NSInteger image_size;
@property (nonatomic,assign) NSInteger image_original;
@property (nonatomic,copy) NSString *image_middle;
@property (nonatomic,copy) NSString *image_poster;
@property (nonatomic,copy) NSString *mage_thumbnail;



@end
