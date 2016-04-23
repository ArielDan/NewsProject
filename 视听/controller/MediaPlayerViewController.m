//
//  MediaPlayerViewController.m
//  新闻
//
//  Created by yj on 16/4/23.
//  Copyright © 2016年 ariel. All rights reserved.
//

#import "MediaPlayerViewController.h"
#import <MediaPlayer/MediaPlayer.h>

@interface MediaPlayerViewController ()

@property (nonatomic,strong) MPMoviePlayerController *movieController;//播放控制器

@end

@implementation MediaPlayerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [super viewDidLoad];
    
    //播放
    [self.movieController play];
    [self addNotification];
    [self.view setBackgroundColor:[UIColor whiteColor]];
}


-(MPMoviePlayerController *)movieController{
    if (!_movieController) {
        NSURL *url = [self getNetworkURL];
        _movieController = [[MPMoviePlayerController alloc] initWithContentURL:url];
        _movieController.view.frame = self.view.bounds;
        _movieController.view.autoresizingMask = UIViewAutoresizingFlexibleWidth |UIViewAutoresizingFlexibleHeight;
        _movieController.controlStyle = MPMovieControlStyleDefault;
        [self.view addSubview:_movieController.view];
        
    }
    return _movieController;
}

-(NSURL *)getNetworkURL{
    // NSString *urlStr = @"http://www.tudou.com/a/Lqfme5hSolM/&iid=130827115/v.swf";
    NSString *urlStr = @"http://v1.mukewang.com/19954d8f-e2c2-4c0a-b8c1-a4c826b5ca8b/L.mp4";
    NSURL *url = [NSURL URLWithString:urlStr];
    return url;
}

//监控媒体播放器状态
-(void)addNotification{
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    [notificationCenter addObserver:self selector:@selector(mediaPlayerStatusChange:) name:MPMoviePlayerPlaybackStateDidChangeNotification object:self.movieController];
    
}
//状态改变
-(void)mediaPlayerStatusChange:(NSNotification *)notification{
    switch (self.movieController.playbackState) {
        case MPMoviePlaybackStatePlaying:
            NSLog(@"播放中。。。");
            
            break;
        case MPMoviePlaybackStatePaused:
            NSLog(@"暂停");
            break;
        case MPMoviePlaybackStateStopped:
            NSLog(@"停止");
            break;
        default:
            break;
    }
}

#pragma mark- 添加触摸手势事件
-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    if (self.navigationController.navigationBar.hidden){
        self.navigationController.navigationBar.hidden = NO;
        self.tabBarController.tabBar.hidden = NO;
    }else{
        self.navigationController.navigationBar.hidden = YES;
        self.tabBarController.tabBar.hidden = YES;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
