//
//  ADNewsHeaderView.h
//  仿头条
//
//  Created by csip on 15/11/3.
//  Copyright © 2015年 ariel. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ADNews,ADNewsHeaderView;

@protocol ADHeaderViewDelegate <NSObject>

@optional
-(void)headerView:(ADNewsHeaderView*)headerView news:(ADNews*)news;

@end

@interface ADNewsHeaderView : UIView

@property(nonatomic,weak) id<ADHeaderViewDelegate> delegate;

@property(nonatomic,strong)NSMutableArray *array;

@end
