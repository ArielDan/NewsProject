//
//  ADChoiceCell.m
//  新闻
//
//  Created by csip on 15/11/28.
//  Copyright © 2015年 ariel. All rights reserved.
//

#import "ADChoiceCell.h"
#import "ADChoiceShowView.h"
#import "ADGoodsFrame.h"
#import "ADGroupsModel.h"

@interface ADChoiceCell()

@property(nonatomic,strong) ADChoiceShowView *showView;

@property(nonatomic,strong) UIImageView *bigImage;
@property(nonatomic,strong) UILabel *desc;
@property(nonatomic,strong) UILabel *address;

@end

@implementation ADChoiceCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self addChildControl];
    }
    return self;
    
}

-(void)addChildControl{
//    ADChoiceShowView *showView = [[ADChoiceShowView alloc] init];
//    showView.backgroundColor = [UIColor whiteColor];
//    [self.contentView addSubview:showView];
//    _showView = showView;
    _bigImage = [[UIImageView alloc] init];
    _bigImage.contentMode = UIViewContentModeScaleAspectFill;
    _bigImage.clipsToBounds = YES;
    [self addSubview:_bigImage];
    
    
    //商品描述
    _desc = [[UILabel alloc]init];
    _desc.textColor = kColor(75, 75, 75, 75);
    _desc.numberOfLines = 0;
    [self addSubview:_desc];
    
    
    //地址
    _address = [[UILabel alloc] init];
    _address.textColor = kColor(164, 164, 164, 1);
    _address.font = [UIFont systemFontOfSize:11];
    [self addSubview:_address];
    
    
}
-(void)setGoodsFrame:(ADGoodsFrame *)goodsFrame{
    //self.showView.frame = goodsFrame;
    _goodsFrame = goodsFrame;
    //设置第一张大图
    
    
    NSData* (^img)(void) = ^NSData*(void){
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[goodsFrame.goodsModel.goods_image valueForKey:@"image_original"]]];
        return imageData;
    };
    self.bigImage.image = [UIImage imageWithData:img()];
    
    _bigImage.frame = _goodsFrame.imageF;
    _desc.frame = _goodsFrame.descF;
    _address.frame = _goodsFrame.addressF;
    
    _desc.text = goodsFrame.goodsModel.goods_name;
    if (goodsFrame.goodsModel.group_info) {
        
        NSString *country = [goodsFrame.goodsModel.group_info valueForKey:@"country"];
        NSString *city = [goodsFrame.goodsModel.group_info valueForKey:@"city"];
        
        _address.text = [NSString stringWithFormat:@"%@ %@",country,city];
    }
    
}

-(void)setGroupModel:(ADGroupsModel *)groupModel{
    _desc.text = groupModel.goods_name;
    
    if (groupModel.group_info) {
        
        NSString *country = [groupModel.group_info valueForKey:@"country"];
        NSString *city = [groupModel.group_info valueForKey:@"city"];
        
        _address.text = [NSString stringWithFormat:@"%@ %@",country,city];
    }
}

@end
