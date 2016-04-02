//
//  ADNavigationController.m
//  仿头条
//
//  Created by csip on 15/10/19.
//  Copyright © 2015年 ariel. All rights reserved.
//

#import "ADNavigationController.h"
#import "ADLeftMenu.h"
#import "ADNavigationBar.h"

static ADNavigationController *instance;

@interface ADNavigationController()<ViewTransformDelegate>

@property(nonatomic,strong) ADLeftMenu *leftMenu;

@end

@implementation ADNavigationController

+(instancetype)getInstance{
    return instance;
}

+(void)initialize{
    
    
    UINavigationBar *bar = [UINavigationBar appearance];
    
    [bar setBarTintColor:[UIColor redColor]];
    
    bar.shadowImage=[[UIImage alloc]init];  //隐藏掉导航栏底部的那条线
    
}
-(void)viewDidLoad{
    ADNavigationBar *navBar = [[ADNavigationBar alloc] initWithFrame:self.navigationBar.frame];
    navBar.transDelegate = self;
    [self.view addSubview:navBar];
}

-(void)setUpController:(UIViewController *)vc title:(NSString *)title{
    //ADTabBarController *tab = [[ADTabBarController alloc] init];
    //ADNavigationController *nav = [[ADNavigationController alloc] init];
    //vc.title = title;
    vc.navigationItem.title = title;
    //vc.navigationController.title = title;
    UIButton *leftBtn = [[UIButton alloc] init];
    leftBtn.frame = CGRectMake(0, 10, 50, 50);
    //[self.rightBtn setTitle:@"+" forState:UIControlStateNormal];
    [leftBtn setImage:[UIImage imageNamed:@"top_navigation_menuicon"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    vc.navigationItem.leftBarButtonItem = left;
    
    //[vc addChildViewController:nav];
}

#pragma mark - 导航栏左边按钮点击
-(void)leftBtnClick{
    self.leftMenu.hidden = NO;
    //左边菜单的动画属性 之后在下面的block里面调回去
    //    CGAffineTransform scaleform = CGAffineTransformMakeScale(0.5, 0.5);//缩放
    //    CGAffineTransform anim = CGAffineTransformTranslate(scaleform, -80, 0);//平移
    //    _leftMenu.transform = anim;
    
    
    [UIView animateWithDuration:0.25 animations:^{
        
        //调回左边菜单的动画属性
        self.leftMenu.transform = CGAffineTransformIdentity;
        //缩放比例
        CGFloat navH =kScreenH - 2*kLeftMenuBtnY;
        CGFloat scale = navH/kScreenH;
        //左边菜单的距离
        CGFloat leftMargin = kScreenW * (1- scale)*0.5;
        CGFloat translateX = (kLeftMenuW - leftMargin)/scale;
        //设置移动  缩放
        CGAffineTransform scaleForm = CGAffineTransformMakeScale(scale, scale);//缩放
        CGAffineTransform translateForm = CGAffineTransformTranslate(scaleForm, translateX, 0);
        
        //self.navigationController.view.transform = translateForm;
        self.view.transform = translateForm;
        //创建一个按钮覆盖首页
        UIButton *cover = [[UIButton alloc] initWithFrame:self.view.bounds];
        cover.tag = kButtonTag;
        [cover addTarget:self action:@selector(coverClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //[self.navController.view addSubview:cover];
        [self.view addSubview:cover];
    }];
}

#pragma mark - 左侧边栏点击的代理方法
-(void)leftMenu:(ADLeftMenu *)leftMenu didSelectedForm:(NSInteger)from to:(NSInteger)to{
    //取出上一个
    ADNavigationController *last = self.childViewControllers[from];
    [last.view removeFromSuperview];
    
    //要切换到的控制器
    ADNavigationController *nav = self.childViewControllers[to];
    //赋予动画属性
    nav.view.transform = last.view.transform;
    
    [self.view addSubview:nav.view];
    
    instance = nav;
    //self.navController = nav;
    
    [self coverClick:(UIButton *)[nav.view viewWithTag:kButtonTag]];
}

#pragma mark - 点击覆盖按钮返回
-(void)coverClick:(UIButton *)cover{
    
    [UIView animateWithDuration:0.25 animations:^{
        //设置左边菜单的动画属性
        CGAffineTransform scaleform = CGAffineTransformMakeScale(0.9, 0.9);
        CGAffineTransform anim = CGAffineTransformTranslate(scaleform, -80, 0);
        self.leftMenu.transform = anim;
        
        self.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [cover removeFromSuperview];
    }];
    
    
}








@end
