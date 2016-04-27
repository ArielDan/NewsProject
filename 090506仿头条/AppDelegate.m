//
//  AppDelegate.m
//  090506仿头条
//
//  Created by csip on 15/9/5.
//  Copyright (c) 2015年 ariel. All rights reserved.
//

#import "AppDelegate.h"
#import "RootViewController.h"
#import "ADTabBarController.h"
#import "ADNavigationController.h"

#import "ViewController.h"
#import "MeViewController.h"
#import "FoundViewController.h"
#import "ReadViewController.h"
#import "WatchViewController.h"

#import "UIViewController+AD.h"
#import <MediaPlayer/MediaPlayer.h>

@interface AppDelegate (){
    BOOL _isFullScrenn;
}

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    //注册进入全屏和退出全屏
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willEnterFullScreen) name:MPMoviePlayerWillEnterFullscreenNotification object:nil];
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willExitFullScreen) name:MPMoviePlayerWillExitFullscreenNotification object:nil];
    
//    
    UIApplication *app = [UIApplication sharedApplication];
    
    app.statusBarStyle = UIStatusBarStyleLightContent;
    //[UITabBar appearance].barTintColor = [UIColor redColor];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    //[self.window makeKeyAndVisible];

    //设置主窗口
    RootViewController *root = [[RootViewController alloc ]init];
    self.window.rootViewController = root;
    
    //ADTabBarController *tab = [[ADTabBarController alloc] init];

    //self.window.rootViewController = tabBarController;
   // self.window.rootViewController = root;
    [self.window makeKeyAndVisible];
    

    return YES;
}

//-(void)willEnterFullScreen{
//    _isFullScrenn = YES;
//}
//-(void)willExitFullScreen{
//    _isFullScrenn = NO;
//}

//- (NSUInteger)application:(UIApplication *)application supportedInterfaceOrientationsForWindow:(UIWindow *)window
//{
//    if (_isFullScrenn) {
//    return UIInterfaceOrientationMaskPortrait |    UIInterfaceOrientationMaskLandscapeLeft | UIInterfaceOrientationMaskLandscapeRight;
//} else {
//    return UIInterfaceOrientationMaskPortrait;
//}
//}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}



@end
