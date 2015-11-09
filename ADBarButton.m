//
//  ADBarButton.m
//  仿头条
//
//  Created by csip on 15/11/1.
//  Copyright © 2015年 ariel. All rights reserved.
//

#import "ADBarButton.h"
#import "UIView+Frame.h"

@implementation ADBarButton

-(void)setHighlighted:(BOOL)highlighted{
    
}
-(void)layoutSubviews{
    [super layoutSubviews];
    
    self.imageView.y = 5;
    self.imageView.width = 20;
    self.imageView.height = 20;
    self.imageView.x = (self.width - self.imageView.width)/2;
    self.imageView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.titleLabel.x = self.imageView.x - (self.titleLabel.width - self.imageView.width)/2.0;
    self.titleLabel.y = CGRectGetMaxY(self.imageView.frame) + 2.5;
    
    self.titleLabel.font =[UIFont systemFontOfSize:12];
    self.titleLabel.shadowColor = [UIColor clearColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
}

@end
