//
//  ADChoiceCell.h
//  新闻
//
//  Created by csip on 15/11/28.
//  Copyright © 2015年 ariel. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ADGoodsFrame;
@class ADGroupsModel;

@interface ADChoiceCell : UITableViewCell

@property(nonatomic,strong) ADGoodsFrame *goodsFrame;
@property(nonatomic,strong) ADGroupsModel *groupModel;

@end
