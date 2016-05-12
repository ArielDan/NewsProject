//
//  ImageTableViewCell.h
//  新闻
//
//  Created by yj on 16/5/11.
//  Copyright © 2016年 ariel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ADNews;

@interface ImageTableViewCell : UITableViewCell

@property (nonatomic,strong) ADNews *news;

@property (nonatomic,assign) CGFloat height;

@end
