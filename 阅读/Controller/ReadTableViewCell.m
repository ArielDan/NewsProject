//
//  ReadTableViewCell.m
//  新闻
//
//  Created by yj on 16/5/13.
//  Copyright © 2016年 ariel. All rights reserved.
//

#import "ReadTableViewCell.h"
#import "ReadDataModel.h"

@interface ReadTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *imageV;
@property (weak, nonatomic) IBOutlet UILabel *contentLbl;
@property (weak, nonatomic) IBOutlet UILabel *dateLbl;

@end

@implementation ReadTableViewCell

- (void)awakeFromNib {
    // Initialization code
    _contentLbl.numberOfLines = 0;
    _contentLbl.font = [UIFont systemFontOfSize:14];
    _dateLbl.font = [UIFont systemFontOfSize:12];
    _dateLbl.textColor = [UIColor lightGrayColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


-(void)setDataModel:(ReadDataModel *)dataModel{
    _dataModel = dataModel;
    _imageV.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:dataModel.pic]]];
    _contentLbl.text = dataModel.excerpt;
    _dateLbl.text = dataModel.date;
}
@end
