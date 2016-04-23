//
//  CustomerCollectionCell.h
//  新闻
//
//  Created by yj on 16/4/7.
//  Copyright © 2016年 ariel. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ADFindModel;
@class ADImageModel;

@interface CustomerCollectionCell : UICollectionViewCell

@property (nonatomic,strong) ADFindModel *dataModel;

@property (nonatomic,strong) ADImageModel *imgModel;

@property (nonatomic,assign) NSInteger cellH;

@property (nonatomic,strong) UIImageView *imageView;
@property (nonatomic,strong) UILabel *titlelbl;
@property (nonatomic,strong) UILabel *desclbl;
@property (nonatomic,strong) UILabel *locationlbl;


@property (nonatomic,strong) CGSize(^PassingSizeBlock)();

@end
