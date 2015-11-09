//
//  ADHeaderCell.m
//  仿头条
//
//  Created by csip on 15/11/4.
//  Copyright © 2015年 ariel. All rights reserved.
//

#import "ADHeaderCell.h"
#import "ADDetailModel.h"
#import "ADNews.h"

@interface ADHeaderCell(){
    //UIImageView *_imageView;
    UILabel *_label;
}

@property(nonatomic,weak)UIImageView *imageView;

@end

@implementation ADHeaderCell
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self addChild];
    }
    
    return self;
}

-(void)addChild{
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.frame = self.bounds;
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:imageView];
    
    imageView.clipsToBounds = YES;//取值为YES时，剪裁超出父视图范围的子视图部分
    
    self.imageView = imageView;
}
-(void)setNews:(ADNews *)news{
    NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:news.imgsrc]];
    
    //NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:news.photoSetID]];
    
    self.imageView.image = [UIImage imageWithData:imageData];
    
}
@end
