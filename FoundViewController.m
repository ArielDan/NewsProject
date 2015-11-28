//
//  FoundViewController.m
//  仿头条
//
//  Created by csip on 15/10/27.
//  Copyright © 2015年 ariel. All rights reserved.
//

#import "FoundViewController.h"
#import "ADChoiceController.h"
#import "ADFindController.h"

#import "ADTitleView.h"

#import "ADNavigationController.h"

#import "UIView+Frame.h"
@interface FoundViewController()

@property(nonatomic,strong) ADTitleView *titleView;


@end

@implementation FoundViewController

-(void)viewDidLoad{
    [super viewDidLoad];
    
    

    [self setupTitleView];
    
    
    
}

-(void)setupTitleView{
    ADTitleView *titleView = [[ADTitleView alloc] init];
    titleView.frame = CGRectMake(0, 0, self.view.width, self.navigationController.navigationBar.height);
    self.navigationItem.titleView = titleView;
    
    titleView.delegate = self;
    
    self.titleView = titleView;
}

//#pragma mark titleView代理方法
//-(void)titleView:(ADTitleView *)titleView pushController:(UIViewController *)controller{
//    [self.navigationController pushViewController:controller animated:YES];
//    //[self presentViewController:controller animated:YES completion:nil];
//}


@end
