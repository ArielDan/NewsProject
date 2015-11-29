//
//  ADChoiceShowView.m
//  新闻
//
//  Created by csip on 15/11/28.
//  Copyright © 2015年 ariel. All rights reserved.
//

#import "ADChoiceShowView.h"
#import "ADGoodsFrame.h"
#import "ADGroupsModel.h"
#import "ADImageModel.h"

@interface ADChoiceShowView()

@property(nonatomic,strong) UIImageView *bigImage;
@property(nonatomic,strong) UILabel *desc;
@property(nonatomic,strong) UILabel *address;


@end

@implementation ADChoiceShowView

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        //添加子控件
        [self addChildControl];
    }
    return  self;
}

-(void)addChildControl{
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

-(void)setFrame:(ADGoodsFrame *)frame{
    _frame = frame;
    //设置第一张大图
    

    NSData* (^img)(void) = ^NSData*(void){
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:[frame.goodsModel.goods_image valueForKey:@"image_original"]]];
        return imageData;
    };
    self.bigImage.image = [UIImage imageWithData:img()];
    
    
}

@end
