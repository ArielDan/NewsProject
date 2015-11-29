//
//  ADGoodsFrame.m
//  新闻
//
//  Created by csip on 15/11/13.
//  Copyright © 2015年 ariel. All rights reserved.
//

#import "ADGoodsFrame.h"
#import "ADGroupsModel.h"
#import "ADImageModel.h"

#import "UIView+Frame.h"

#define kMoreImageH 150

@implementation ADGoodsFrame

-(void)setGoodsModel:(ADGroupsModel *)goodsModel{
    _goodsModel = goodsModel;

    //goods_image为空
    void(^frame)()=^(){
        //1.第一张图片的frame
        CGFloat imageX=0;
        CGFloat imageY=0;
        CGFloat imageW=kScreenW;
        CGFloat imageH=kMoreImageH;
        _imageF=CGRectMake(imageX, imageY, imageW, imageH);
    };
   // NSLog(@"%d",goodsModel.goods_image.count);
    if (goodsModel.goods_image.count>1) {
        //1.第一张图片的frame
        frame();
    }else{
        frame();
        //标签文字frame
        CGFloat labelOriginW = kScreenW - 20;
        CGSize finalSize = [goodsModel.goods_name boundingRectWithSize:CGSizeMake(labelOriginW, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
        CGFloat descX = 10;
        CGFloat descY = CGRectGetMaxY(_imageF)+20;
        _descF = CGRectMake(descX, descY, finalSize.width, finalSize.height);
        //地址frame
        CGFloat addressX = 20;
        CGFloat addressY = CGRectGetMaxY(_descF)+5;
        _addressF = CGRectMake(addressX, addressY, 120, 20);
        
        _cellH = CGRectGetMaxY(_addressF)+20;
        
    }
}


@end
