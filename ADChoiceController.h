//
//  ADChoiceController.h
//  新闻
//
//  Created by csip on 15/11/13.
//  Copyright © 2015年 ariel. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol TwoControllerSegmentDelegate <NSObject>

-(void)addControllerTitleView;

@end

@interface ADChoiceController : UITableViewController<UITableViewDataSource,UITableViewDelegate>

+(instancetype)getInstance;

@property (nonatomic,weak) id<TwoControllerSegmentDelegate> controllerDelegate;

//@property(nonatomic,strong) void(^showControllerBlock)();

@end
