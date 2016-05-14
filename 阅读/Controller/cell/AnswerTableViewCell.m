//
//  AnswerTableViewCell.m
//  新闻
//
//  Created by yj on 16/5/13.
//  Copyright © 2016年 ariel. All rights reserved.
//

#import "AnswerTableViewCell.h"
#import "AnswerModel.h"

@interface AnswerTableViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *answerLbl;
@property (weak, nonatomic) IBOutlet UILabel *authorName;
@property (weak, nonatomic) IBOutlet UILabel *answerTime;

@end

@implementation AnswerTableViewCell

- (void)awakeFromNib {
    // Initialization code
    _answerTime.textColor = [UIColor lightGrayColor];
    _answerTime.font = [UIFont systemFontOfSize:14.0];
    _authorName.font = [UIFont systemFontOfSize:15.0];
    _answerLbl.font = [UIFont systemFontOfSize:15.0];
    self.answerLbl.numberOfLines = 0;
    
    //圆角显示
    _iconImage.layer.cornerRadius = _iconImage.width/2;
    _iconImage.clipsToBounds = YES;
}

-(void)setAnswerModel:(AnswerModel *)answerModel{
    _answerModel = answerModel;
    
    _iconImage.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:answerModel.avatar]]];
    _authorName.text = answerModel.authorname;
    _answerTime.text = answerModel.time;
    _answerLbl.text = answerModel.summary;
    NSLog(@"%@",answerModel.summary);
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
