//
//  ADChoiceView.m
//  新闻
//
//  Created by csip on 15/11/13.
//  Copyright © 2015年 ariel. All rights reserved.
//

#import "ADChoiceView.h"
#import "ADGoodsFrame.h"
#import "ADImageModel.h"
#import "ADGroupsModel.h"

@interface ADChoiceView()

@property(nonatomic,weak) UILabel *addressLbl;
@property(nonatomic,weak) UILabel *descLbl;

@property(nonatomic,weak) UIImageView *bigImage;
@property(nonatomic,weak) UIImageView *oneImga;
@property(nonatomic,weak) UIImageView *twoImage;
@property(nonatomic,weak) UIImageView *threeImage;

@end

@implementation ADChoiceView

-(instancetype) initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addChild];
    }
    
    return  self;
}

-(void)addChild{
    UIImageView *bigImage = [[UIImageView alloc] init];
    bigImage.contentMode = UIViewContentModeScaleAspectFit;
    [self addSubview:bigImage];
    _bigImage = bigImage;
    
    UILabel *address = [[UILabel alloc] init];
    address.textColor = kColor(164, 164, 164, 1);
    address.font = [UIFont systemFontOfSize:12];
    [self addSubview:address];
    _addressLbl = address;
    
    UILabel *desc = [[UILabel alloc] init];
    desc.textColor = kColor(75, 75, 75, 1);
    //自动换行
    desc.numberOfLines = 0;
    [self addSubview:desc];
    _descLbl = desc;
    
}

@end
