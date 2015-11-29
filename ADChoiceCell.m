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

@interface ADChoiceCell()

@property(nonatomic,weak) ADChoiceShowView *showView;

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
    ADChoiceShowView *showView = [[ADChoiceShowView alloc] init];
    showView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:showView];
    _showView = showView;
    
}
-(void)setGoodsFrame:(ADGoodsFrame *)goodsFrame{
    self.showView.frame = goodsFrame;
}

@end
