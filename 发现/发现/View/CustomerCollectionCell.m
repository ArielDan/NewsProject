//
//  CustomerCollectionCell.m
//  新闻
//
//  Created by yj on 16/4/7.
//  Copyright © 2016年 ariel. All rights reserved.
//

#import "CustomerCollectionCell.h"
#import "ADFindModel.h"
#import "ADImageModel.h"

#define lineMargin 5

#define cellW (kScreenW-4*lineMargin)/2

@interface CustomerCollectionCell()


@end

@implementation CustomerCollectionCell

-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self buildSubviews];
        //[self setBackgroundColor:[UIColor whiteColor]];
        
    }
    return self;
}

-(void)buildSubviews{
    //图片
    CGFloat imageW = cellW ;
    UIImageView *imageV = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, imageW, imageW)];
    
    [self addSubview:imageV];
    self.imageView = imageV;
    //描述
//    UILabel *desc = [[UILabel alloc] init];
//    [self addSubview:desc];
//    desc.numberOfLines = 0;
//    self.desclbl = desc;
    
    //位置
    UILabel *location = [[UILabel alloc] init];
    [self addSubview:location];
    location.textColor = [UIColor lightGrayColor];
    location.font = [UIFont systemFontOfSize:12.0];
    self.locationlbl = location;
    
    //名称
    UILabel *title = [[UILabel alloc] init];
    title.textColor = [UIColor lightGrayColor];
    title.font = [UIFont systemFontOfSize:12.0];
    [self addSubview:title];
    self.titlelbl = title;
    
}


-(void)setDataModel:(ADFindModel *)dataModel{
    self.titlelbl.text = dataModel.goods_name;
    
    self.locationlbl.text = [NSString stringWithFormat:@"%@ %@",dataModel.country,dataModel.city];
    
    self.imgModel = dataModel.main_image;
    
    CGFloat locationX = lineMargin;
    CGFloat locationY =CGRectGetMaxY(self.imageView.frame)+5;
    //CGSize locationSize = [self.locationlbl.text boundingRectWithSize:CGSizeMake(locationX, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:8.0f]} context:nil].size;
    CGSize locationSize = [self.locationlbl.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10.0]}];
    
    self.locationlbl.frame = CGRectMake(locationX, locationY, cellW-2*lineMargin, locationSize.height);
    
    CGFloat titleX = 0;
    CGFloat titleY = CGRectGetMaxY(self.locationlbl.frame)+5;
    CGFloat titleW = cellW - 2*lineMargin;
    
//    CGSize titleSize = [self.titlelbl.text boundingRectWithSize:CGSizeMake(titleX, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:8.0f]} context:nil].size;

    CGSize titleSize = [self.titlelbl.text sizeWithAttributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10.0]}];
    self.titlelbl.frame = CGRectMake(titleX, titleY, titleW, titleSize.height);
    
    __weak typeof (CustomerCollectionCell *) weakSelf = self;
    self.PassingSizeBlock = ^CGSize (){
        CGSize cellSize = CGSizeMake(cellW, CGRectGetMaxY(weakSelf.titlelbl.frame));
        return cellSize;
    };
}

-(void)setImgModel:(ADImageModel *)imgModel{

    NSString *urlStr = [imgModel valueForKey:@"image_poster"];
    
    //[urlStr stringByReplacingOccurrencesOfString:@"\\" withString:@""];
    
    NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:urlStr]];
    
    self.imageView.image = [UIImage imageWithData:imgData];
}


@end
