//
//  ADNewsTableViewCell.m
//  090506仿头条
//
//  Created by csip on 15/10/9.
//  Copyright (c) 2015年 ariel. All rights reserved.
//

#import "ADNewsTableViewCell.h"
#import "ADNews.h"
#define kMarginTop 10
#define kMarginLeft 10
//图片之间间距
#define kImgMargin 5
//一张图片存在的宽度、高度
#define konePictureW 80
#define konePictureH 60
//多张图片状态
#define kmorePictureW
#define kmorePictureH

//cell宽高
#define kCellBorder 8
//图片
#define kPhotoWidth 80
#define kPhotoHeight 60

#define kReplyWidth 50
#define kReplyHeight 20

@interface ADNewsTableViewCell(){
    UIImageView *_photo;
    UILabel *_lblTitle;
    UILabel *_lblReply;
    UIButton *_reply;
    UILabel *_lblSubtitle;
    
    UILabel *_digest;
//    UIImageView *_imageOther1;
//    UIImageView *_imageOther2;
}

@end

@implementation ADNewsTableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    
    if (self) {
        [self initSubviews];
        self.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    }
    
    return  self;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

#pragma mark -初始化视图
-(void)initSubviews{
    _photo = [[UIImageView alloc] init];
    [self.contentView addSubview:_photo];
    
    _lblSubtitle = [[UILabel alloc] init];
    [self.contentView addSubview:_lblSubtitle];
    _lblSubtitle.numberOfLines = 0;
    
    _lblTitle = [[UILabel alloc] init];
    [self.contentView addSubview:_lblTitle];
    _lblTitle.numberOfLines = 0;//自动换行
    
    _lblReply = [[UILabel alloc] init];
    [self.contentView addSubview:_lblReply];
    
    _digest = [[UILabel alloc ]init];
    [self.contentView addSubview:_digest];
    //_digest.lineBreakMode = NSLineBreakByCharWrapping;
    _digest.numberOfLines = 0;
    
//    _imageOther1 = [[UIImageView alloc] init];
//    [self.contentView addSubview:_imageOther1];
//    
//    _imageOther2 = [[UIImageView alloc] init];
//    [self.contentView addSubview:_imageOther2];
    
//    _reply = [[UIButton alloc] init];
//    [self.contentView addSubview:_reply];
//    [_reply setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
//    [_reply setBackgroundImage:[UIImage imageNamed:@"night_contentcell_comment_border"] forState:UIControlStateNormal];
//    _reply.userInteractionEnabled = NO;
//    [_reply.titleLabel addSubview:_lblReply];
    _photo.frame = CGRectMake(kCellBorder, kCellBorder, kPhotoWidth, kPhotoHeight);
    
    
    _lblReply.textColor = [UIColor lightGrayColor];
    
    _lblReply.font = [UIFont systemFontOfSize:10];

}

#pragma  mark - 内容设置
-(void)setNews:(ADNews *)news{
    
    _news = news;
//    if (news.imgextra.count) {
//        [self imgextra];
//    }else{
    
//    }

    NSData *imgData = [NSData dataWithContentsOfURL:[NSURL URLWithString:news.imgsrc]];
    _photo.image = [UIImage imageWithData:imgData];
    
    _lblTitle.text = self.news.title;
    _lblReply.text = [NSString stringWithFormat:@"%@跟帖",news.replyCount];
    
   [self normalShow];
}
//多张图片
//-(void)imgextra{
//    CGFloat titleX = kMarginLeft;
//    CGFloat titleY = kMarginTop;
//    CGFloat titleW = self.frame.size.width - kCellBorder;
//    CGSize titleS = [self.news.title boundingRectWithSize:CGSizeMake(titleW, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
//    _lblTitle.frame = CGRectMake(titleX, titleY, titleW, titleS.height);
//    _lblTitle.font = [UIFont systemFontOfSize:15];
//    
//    CGFloat imgY=CGRectGetMaxY(_lblTitle.frame)+kMarginTop;
//    CGFloat imgX=kMarginLeft;
//    CGFloat imgW=(kScreenW-kMarginLeft*2-kImgMargin*2)/3;  //多张图片显示的时候的宽度
//    CGFloat imgH=70;
//    
//    _photo.frame = CGRectMake(imgX, imgY, imgW, imgH);
//    //第二三张图片
//    
//    CGFloat img2X = CGRectGetMaxX(_photo.frame) + kImgMargin;
//    _imageOther1.frame = CGRectMake(img2X, imgY, imgW, imgH);
//    
//    CGFloat img3X = CGRectGetMaxX(_imageOther1.frame) + kImgMargin;
//    _imageOther2.frame = CGRectMake(img3X, imgY, imgW, imgH);
//    
//    //单元格高度
//    _height = CGRectGetMaxY(_imageOther1.frame)+2.5*kCellBorder;
//}

//正常情况下的显示
-(void)normalShow{
    
    CGFloat titleX = CGRectGetMaxX(_photo.frame) +kCellBorder;
    CGFloat titleY = kCellBorder;
    CGFloat titleW = self.frame.size.width - kPhotoWidth-2*kCellBorder;
    
    CGSize titleSize = [self.news.title boundingRectWithSize:CGSizeMake(titleW, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12]} context:nil].size;
    
    _lblTitle.frame = CGRectMake(titleX, titleY, titleW, titleSize.height);
    
    _lblTitle.font = [UIFont systemFontOfSize:14];
    
    CGFloat subtitleX = titleX;
    CGFloat subtitleY = CGRectGetMaxY(_lblTitle.frame) +5;
    CGFloat subtitleW = titleW;
    //CGSize subtitleSize = [_news.subtitle sizeWithAttributes:@{NSFontAttributeName:[UIFont fontWithName:_lblSubtitle.text size:MAXFLOAT]}];
    
    //根据文本绘制矩形空间
    CGSize subtitleSize = [self.news.subtitle boundingRectWithSize:CGSizeMake(subtitleW, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:10]} context:nil].size;
    
    /**
     NSStringDrawingUsesLineFragmentOrigin，整个文本将以每行组成的矩形为单位计算整个文本的尺寸。
     NSStringDrawingUsesFontLeading则以字体间的行距（leading，行距：从一行文字的底部到另一行文字底部的间距。）计算。
     
     */
    _lblSubtitle.frame = CGRectMake(subtitleX, subtitleY, subtitleW, subtitleSize.height);
    _lblSubtitle.text = self.news.subtitle;
    
    CGFloat digestX = CGRectGetMaxX(_photo.frame)+kCellBorder;
    CGFloat digestY = CGRectGetMaxY(_lblTitle.frame)+kCellBorder;
    CGFloat digestW = titleW;
    
    CGSize digestSize = [self.news.digest boundingRectWithSize:CGSizeMake(digestW, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:14]} context:nil].size;
    _digest.frame = CGRectMake(digestX, digestY, digestW, digestSize.height);
    _digest.textColor = [UIColor lightGrayColor];
    _digest.font = [UIFont systemFontOfSize:13];
    
    _digest.text = self.news.digest;
    
     CGSize replySize = [_lblReply.text boundingRectWithSize:CGSizeMake(self.contentView.frame.size.width, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size;
    
    CGFloat replyX = self.contentView.frame.size.width - (replySize.width + 5);
    CGFloat replyY = self.contentView.frame.size.height - 20;
    
    CGFloat replyW = replySize.width;
    CGFloat replyH = kReplyHeight;
    //_reply.frame = CGRectMake(replyX-10, replyY, replyW, replyH);
    //NSLog(@"%@",NSStringFromCGRect(CGRectMake(replyX, replyY, replyW, replyH)));
    _lblReply.frame = CGRectMake(replyX, replyY, replyW, replyH);
    
    //单元格高度
     _height = CGRectGetMaxY(_photo.frame)+ 2 * kCellBorder;
}

@end
