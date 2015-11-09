//
//  ADTabBarController.m
//  仿头条
//
//  Created by csip on 15/10/21.
//  Copyright © 2015年 ariel. All rights reserved.
//

#import "ADTabBarController.h"
#import "ADTabBar.h"

#import "UIView+Frame.h"

#import "ViewController.h"
#import "ADNavigationController.h"
#import "ADLeftMenu.h"


@interface ADTabBarController()<ADTabBarDelegate,ADLeftMenuDelegate>



@end

@implementation ADTabBarController

-(void)viewDidLoad{
    [super viewDidLoad];
    //[self addBackgroundImage];
    
    //_navController = [[ADNavigationController alloc] init];
    
    
    
    ADTabBar *tabBar = [[ADTabBar alloc] init];
    tabBar.frame = self.tabBar.frame;
    //NSLog(@"%@",NSStringFromCGRect(self.tabBar.bounds));
    //tabBar.backgroundColor = kColor(239, 239, 239, 1);
    tabBar.tintColor = kColor(239, 239, 239, 1);
    //[self.tabBar removeFromSuperview];
    
    [self.view addSubview:tabBar];
    
    tabBar.delegate = self;
    
    [tabBar addImageView];
    
    [tabBar addBarbtnWithNormal:@"tabbar_icon_news_normal" andHeighten:@"tabbar_icon_news_highlight" andTitle:@"新闻"];
    [tabBar addBarbtnWithNormal:@"tabbar_icon_reader_normal" andHeighten:@"tabbar_icon_reader_highlight" andTitle:@"阅读"];
    [tabBar addBarbtnWithNormal:@"tabbar_icon_media_normal" andHeighten:@"tabbar_icon_media_highlight" andTitle:@"发现"];
    [tabBar addBarbtnWithNormal:@"tabbar_icon_found_normal" andHeighten:@"tabbar_icon_found_highlight" andTitle:@"视听"];
    [tabBar addBarbtnWithNormal:@"tabbar_icon_me_normal" andHeighten:@"tabbar_icon_me_highlight" andTitle:@"我"];
    
    
    //默认选中
    self.selectedIndex = 0;
        
}

#pragma mark - 代理方法
-(void)changeSelectedIndexFrom:(NSInteger)from To:(NSInteger)to{
    self.selectedIndex = to;
}

@end
