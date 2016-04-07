//
//  ADFindController.m
//  新闻
//
//  Created by csip on 15/11/13.
//  Copyright © 2015年 ariel. All rights reserved.
//

#import "ADFindController.h"
#import "ADNavigationBar.h"
#import "ADTitleView.h"

#import "UIView+Frame.h"

@interface ADFindController()

//@property (nonatomic,strong) ADTitleView *titleView;

@end

static ADFindController *instance;
@implementation ADFindController

+(instancetype)getInstance{
    return instance;
}

-(void)viewDidLoad{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor blueColor]];
    
}



@end
