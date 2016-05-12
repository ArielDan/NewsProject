//
//  ImageTableViewCell.m
//  新闻
//
//  Created by yj on 16/5/11.
//  Copyright © 2016年 ariel. All rights reserved.
//

#import "ImageTableViewCell.h"
#import "ADNews.h"

@interface ImageTableViewCell()
@property (weak, nonatomic) IBOutlet UILabel *titleLbl;
@property (weak, nonatomic) IBOutlet UIImageView *imageF;
@property (weak, nonatomic) IBOutlet UIImageView *imageS;
@property (weak, nonatomic) IBOutlet UIImageView *imageT;
@property (weak, nonatomic) IBOutlet UILabel *readedNum;


@end

//图片
#define kPhotoWidth 80
#define kPhotoHeight 60
#define kMarginTop 10
#define kMarginLeft 10

#define kReplyWidth 50
#define kReplyHeight 20
//图片之间间距
#define kImgMargin 5
//cell宽高
#define kCellBorder 8

@implementation ImageTableViewCell

- (void)awakeFromNib {
    // Initialization code
//    CGFloat replyX = self.frame.size.width - 50;
//    CGFloat replyY = self.frame.size.height - 20;
//    CGFloat replyW = kReplyWidth;
//    CGFloat replyH = kReplyHeight;
//    
//    _readedNum.frame = CGRectMake(replyX, replyY, replyW, replyH);
    _readedNum.textColor = [UIColor lightGrayColor];
    
    _readedNum.font = [UIFont systemFontOfSize:10];
}

-(void)setNews:(ADNews *)news{
//    CGFloat titleX = kMarginLeft;
//    CGFloat titleY = kMarginTop;
//    CGFloat titleW = self.frame.size.width - kCellBorder;
//    CGSize titleS = [self.news.title boundingRectWithSize:CGSizeMake(titleW, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
//    _titleLbl.frame = CGRectMake(titleX, titleY, titleW, titleS.height);
    _titleLbl.font = [UIFont systemFontOfSize:15];
    _titleLbl.text = news.title;
    
//    CGFloat imgY=CGRectGetMaxY(_titleLbl.frame)+kMarginTop;
//    CGFloat imgX=kMarginLeft;
//    CGFloat imgW=(kScreenW-kMarginLeft*2-kImgMargin*2)/3;  //多张图片显示的时候的宽度
//    CGFloat imgH=70;
//    
//    _imageF.frame = CGRectMake(imgX, imgY, imgW, imgH);
    NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:news.imgsrc]];
    _imageF.image = [UIImage imageWithData:imgData];
    //第二三张图片
    
//    CGFloat img2X = CGRectGetMaxX(_imageF.frame) + kImgMargin;
//    _imageS.frame = CGRectMake(img2X, imgY, imgW, imgH);
    _imageS.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[news.imgextra[0] valueForKey:@"imgsrc"]]]];
    
//    CGFloat img3X = CGRectGetMaxX(_imageS.frame) + kImgMargin;
//    _imageT.frame = CGRectMake(img3X, imgY, imgW, imgH);
    _imageT.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:[news.imgextra[1] valueForKey:@"imgsrc"]]]];

    _readedNum.text = [NSString stringWithFormat:@"%@跟帖",news.replyCount];
    
    //单元格高度
   // _height = CGRectGetMaxY(_imageS.frame)+2.5*kCellBorder;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
