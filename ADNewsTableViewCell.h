//
//  ADNewsTableViewCell.h
//  090506仿头条
//
//  Created by csip on 15/10/9.
//  Copyright (c) 2015年 ariel. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ADNews.h"

@interface ADNewsTableViewCell : UITableViewCell

@property(nonatomic,strong) ADNews *news;


@property(nonatomic,assign) CGFloat height;

@end
