
//
//  ADImageModel.h
//  新闻
//
//  Created by csip on 15/11/13.
//  Copyright © 2015年 ariel. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface ADImageModel : NSObject

@property(nonatomic,copy) NSString *image_id;
@property(nonatomic,copy) NSString *image_original;
@property(nonatomic,copy) NSString *image_middle;
@property(nonatomic,copy) NSString *image_thumbnail;
@property(nonatomic,assign) CGFloat image_width;
@property(nonatomic,assign) CGFloat image_height;

@end
