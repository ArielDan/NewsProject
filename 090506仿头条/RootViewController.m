//
//  RootViewController.m
//  090506仿头条
//
//  Created by csip on 15/10/17.
//  Copyright © 2015年 ariel. All rights reserved.
//

#import "RootViewController.h"
#import "ViewController.h"
#import "ADLeftMenu.h"

#import "UIView+Frame.h"
#import "UIBarButtonItem+ADInit.h"
#import "ADNavigationController.h"
#import "ADTabBarController.h"

#import "FoundViewController.h"
#import "ADChoiceController.h"
#import "ReadViewController.h"
#import "MeViewController.h"
#import "WatchViewController.h"

@interface RootViewController()<ADLeftMenuDelegate>

//左边菜单栏
@property(nonatomic,strong) ADLeftMenu *leftMenu;
//左边按钮
@property(nonatomic,strong) UIButton *leftBtn;
//当前显示控制器
@property(nonatomic,strong) ADNavigationController *navController;

@property(nonatomic,strong) ViewController *viewController;



@end

@implementation RootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    [self addBackgroundImage];
    [self setupLeftMenu];
    ADTabBarController *tabBarController = [[ADTabBarController alloc] init];
    
    ViewController *viewController = [[ViewController alloc] init];
    MeViewController *meController = [[MeViewController alloc] init];
    ADChoiceController *choiceController = [[ADChoiceController alloc] init];
    //FoundViewController *foundController = [[FoundViewController alloc] init];
    ReadViewController *readController = [[ReadViewController alloc] init];
    WatchViewController *watchController = [[WatchViewController alloc] init];
    
    ADNavigationController *nav0 = [[ADNavigationController alloc]initWithRootViewController:viewController];
    [nav0 setUpController:viewController title:@"新闻"];
    ADNavigationController *nav1 = [[ADNavigationController alloc] initWithRootViewController:readController];
    [nav1 setUpController:readController title:@"阅读"];
//    ADNavigationController *nav2 = [[ADNavigationController alloc] initWithRootViewController:foundController];
//    [nav2 setUpController:foundController title:@"发现"];
    ADNavigationController *nav2 = [[ADNavigationController alloc] initWithRootViewController:choiceController];
    [nav2 setUpController:choiceController title:@"发现"];
    ADNavigationController *nav4 = [[ADNavigationController alloc] initWithRootViewController:meController];
    [nav4 setUpController:meController title:@"我"];
    
    ADNavigationController *nav3 = [[ADNavigationController alloc] initWithRootViewController:watchController];
    [nav3 setUpController:watchController title:@"视听"];
    
    
    tabBarController.viewControllers = @[nav0,nav1,nav2,nav3,nav4];
    
    [self addChildViewController:tabBarController];
    [self.view addSubview:tabBarController.view];

//
//    [self.view addSubview:_tabBarController.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//-(void)layout{
//    
//    _leftBtn = [[UIButton alloc] init];
//    _leftBtn.frame = CGRectMake(0, 10, 50, 50);
//
//}

#pragma mark - 添加左边菜单栏
-(void)setupLeftMenu{
    _leftMenu = [[ADLeftMenu alloc] initWithFrame:CGRectMake(0, 0, kLeftMenuW, self.view.height)];
    _leftMenu.delegate = self;
    
    [self.view insertSubview:_leftMenu atIndex:1];
    
    
    
}
-(void)addBackgroundImage{
    UIImageView *back = [[UIImageView alloc] initWithFrame:self.view.bounds];
    back.image = [UIImage imageNamed:@"default_cover_gaussian"];
    [self.view addSubview:back];
    
}
#pragma mark - 添加子控制器
-(void)addChildViewControllers{
    
    ViewController *news = [[ViewController alloc] init];
    [self setupChildController:news title:@"新闻"];
    
    UIViewController *read = [[UIViewController alloc] init];
    [self setupChildController:read title:@"订阅"];
    
//    _tabBarController = [[ADTabBarController alloc] init];
//    _tabBarController.viewControllers = @[news,read];
//    [self addChildViewController:_tabBarController];
}
#pragma mark - 子控制器详细
-(void)setupChildController:(UIViewController *)vc title:(NSString *)title{
    
    ADNavigationController *nav = [[ADNavigationController alloc] initWithRootViewController:vc];
    vc.title = title;
    //vc.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithIcon:@"top_navigation_menuicon" target:self action:@selector(leftBtnClick)];
    
    UIButton *leftBtn = [[UIButton alloc] init];
    leftBtn.frame = CGRectMake(0, 10, 50, 50);
    //[self.rightBtn setTitle:@"+" forState:UIControlStateNormal];
    [leftBtn setImage:[UIImage imageNamed:@"top_navigation_menuicon"] forState:UIControlStateNormal];
    [leftBtn addTarget:self action:@selector(leftBtnClick) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *left = [[UIBarButtonItem alloc] initWithCustomView:leftBtn];
    [leftBtn setImageEdgeInsets:UIEdgeInsetsMake(0, -10, 0, 10)];
    vc.navigationItem.leftBarButtonItem = left;
    
    [self addChildViewController:nav];
    //self.navigationController = [[UINavigationController alloc]initWithRootViewController:vc];
    
    //显示首页界面
    if (self.childViewControllers.count == 1) {
        self.navController = nav;
        [self.view addSubview:nav.view];
    }
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
        _leftMenu.transform = CGAffineTransformIdentity;
        //缩放比例
        CGFloat navH =kScreenH - 2*kLeftMenuBtnY;
        CGFloat scale = navH/kScreenH;
        //左边菜单的距离
        CGFloat leftMargin = kScreenW * (1- scale)*0.5;
        CGFloat translateX = (kLeftMenuW - leftMargin)/scale;
        //设置移动  缩放
        CGAffineTransform scaleForm = CGAffineTransformMakeScale(scale, scale);
        CGAffineTransform translateForm = CGAffineTransformTranslate(scaleForm, translateX, 0);
        //self.navigationController.view.transform = translateForm;
        _navController.view.transform = translateForm;
        //创建一个按钮覆盖首页
        UIButton *cover = [[UIButton alloc] initWithFrame:_navController.view.bounds];
        cover.tag = kButtonTag;
        [cover addTarget:self action:@selector(coverClick:) forControlEvents:UIControlEventTouchUpInside];
        
        //[self.navController.view addSubview:cover];
        [self.navController.view addSubview:cover];
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
    
    _navController = nav;
    
    [self coverClick:(UIButton *)[nav.view viewWithTag:kButtonTag]];
}

#pragma mark - 点击覆盖按钮返回
-(void)coverClick:(UIButton *)cover{
    
    [UIView animateWithDuration:0.25 animations:^{
        //设置左边菜单的动画属性
        CGAffineTransform scaleform = CGAffineTransformMakeScale(0.9, 0.9);
        CGAffineTransform anim = CGAffineTransformTranslate(scaleform, -80, 0);
        _leftMenu.transform = anim;
        
        self.navController.view.transform = CGAffineTransformIdentity;
    } completion:^(BOOL finished) {
        [cover removeFromSuperview];
    }];
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
