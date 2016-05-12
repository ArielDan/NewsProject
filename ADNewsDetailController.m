//
//  ADNewsDetailController.m
//  090506仿头条
//
//  Created by csip on 15/10/10.
//  Copyright (c) 2015年 ariel. All rights reserved.
//

#import "ADNewsDetailController.h"
#import "ADNews.h"
#import "GetDataInterfaceJSON.h"

#import "ADDetailModel.h"


@interface ADNewsDetailController ()<UIWebViewDelegate>{
    
}

//@property(nonatomic,strong)ViewController *mainController;

@property(nonatomic,strong) ADDetailModel *detail;

@property(nonatomic,strong)UIWebView *webView;

@property(nonatomic,strong)UIView *topView;


@end

//http://c.m.163.com/nc/article/AHHQIG5B00014JB6/full.html

@implementation ADNewsDetailController



-(void)viewWillAppear:(BOOL)animated{
    
    NSString *urlStr = [NSString stringWithFormat:@"http://c.m.163.com/nc/article/%@/full.html",_getNews];

    //    NSString *escapedURL = [urlStr stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    //
    //    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:escapedURL]];
    
    //[_webView loadRequest:request];

    
    NSString *url = [[NSString alloc] initWithString:[GetDataInterfaceJSON getDataWithRequest:urlStr]];

    //对象序列化
    NSData *jsonData = [url dataUsingEncoding:NSUTF8StringEncoding];
    NSDictionary *new = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableLeaves error:nil];
    
    // NSArray *news = [new objectForKey:[NSString stringWithFormat:@"%@",_getNews]];
    NSDictionary *news = [new objectForKey:[NSString stringWithFormat:@"%@",_getNews]];
    
    //NSDictionary *newsInfo = [news objectAtIndex:0];
    _detail = [[ADDetailModel alloc] init];
    
    [_detail setValue:[news objectForKey:@"title"] forKey:@"title"];
    [_detail setValue:[news objectForKey:@"ptime"] forKey:@"ptime"];
    [_detail setValue:[news objectForKey:@"body"] forKey:@"body"];
    [_detail setValue:[news objectForKey:@"img"] forKey:@"img"];
    
    //"img":[{"ref":"","pixel":"549*309","alt":"","src":"http://img3.cache.netease.com/tech/2015/10/12/20151012195441aa107_550.jpg"}]
    
        [_detail setValue:[_detail.img valueForKey:@"src"] forKey:@"src"];
        [_detail setValue:[_detail.img valueForKey:@"pixel"] forKey:@"pixel"];
        [_detail setValue:[_detail.img valueForKey:@"ref"] forKey:@"ref"];

    
    [self showInWebView];
    
    [self.navigationController setNavigationBarHidden:YES animated:YES];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //ViewController *mainController = [ViewController getInstance];

    //CGRect bounds = [[UIScreen mainScreen]applicationFrame];

    _webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, self.navigationController.navigationBar.frame.size.height + 20, self.view.frame.size.width, self.view.frame.size.height - self.navigationController.navigationBar.frame.size.height-self.tabBarController.tabBar.frame.size.height-20)];
    [self.view addSubview:_webView];
    _webView.delegate = self;
    
    //_webView.scalesPageToFit = YES;//自动对页面缩放以适应屏幕
    
    [self.tabBarController.tabBar setHidden:YES];
    
    _topView = [[UIView alloc] initWithFrame:CGRectMake(0, 20, [[UIScreen mainScreen]applicationFrame].size.width, self.navigationController.navigationBar.frame.size.height)];
    [_topView setBackgroundColor:[UIColor whiteColor]];
    
    
    [self.view addSubview:_topView];
    
    UIButton *back = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 60, 40)];
    
    [back setImage:[UIImage imageNamed:@"night_icon_back@2x.png"] forState:UIControlStateNormal];
    
    [_topView addSubview:back];
    
    [back addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];

    
}

//拼接html语言
-(void)showInWebView{
    NSMutableString *html = [NSMutableString string];
    [html appendString:@"<html>"];
    [html appendString:@"<head>"];
    [html appendFormat:@"<link rel=\"stylesheet\" href=\"%@\">",[[NSBundle mainBundle] URLForResource:@"SXDetails.css" withExtension:nil]];
    [html appendString:@"</head>"];
    [html appendString:@"<body>"];
//    [html appendString:[NSString stringWithFormat:@"%@",_detail.title]];
//    [html appendString:[NSString stringWithFormat:@"%@",_detail.body]];
    [html appendFormat:@"<div class=\"title\">%@</div>",_detail.title];
    [html appendFormat:@"<div class=\"ptime\">%@</div>",_detail.ptime];
    [html appendString:_detail.body];
    /**
    <html><head><link rel="stylesheet" href="file:///Users/csip/Library/Developer/CoreSimulator/Devices/C46511FC-3E51-46EA-81AE-A2E31287D577/data/Containers/Bundle/Application/7410190A-9533-4757-8378-E25D40B24936/090506%E4%BB%BF%E5%A4%B4%E6%9D%A1.app/SXDetails.css"></head><body><div class="title">每日轻松一刻(10月14日午间)</div><div class="ptime">2015-10-14 09:39:07</div><p>　　听说再过几天就是万圣节啦？</p><!--IMG#0--><p>　　SO，开篇表侄女先给大家分享一个万圣节的黑暗料理。</p><p>　　拿好不谢！</p><!--IMG#1--><!--IMG#2--><p>　　再用一根翻糖揉成细条做装饰。</p><!--IMG#3--><p>　　最后，撒上果酱....</p><!--IMG#4--><p>　　OK！就这么完成啦！怎么样？壮士，干了这碗脑浆！我先去吐会儿！</p><!--IMG#5--><p>　　这种黑暗料理你敢尝试吗？</p><p>　　<!--@@PKVOTEID=45062--></p><p>　　相比之下，岛国的这个小伙子万圣节装扮就很萌。</p><p>　　一日本哥们在地铁碰见了一个把刷锅刷带出来的大叔！目测是魔法上班族。</p><!--IMG#77--><p>　　据说听过以上三首神曲的人事纯粹得早泄到对动物产生性幻想的怂备胎，你听过几首(多选）？</p><p>　　<!--@@VOTEID=45067--></p><!--IMG#78--><!--IMG#79--><!--IMG#80--><!--IMG#81--><!--IMG#82--><!--IMG#83-->
     **/
    
    
    //遍历img
    
    //for (ADDetailModel *detailModel in self.detail.img){

    //    for (int j; j<_detail.img.count; j++) {
//    NSLog(@"%@",_detail.img[j]);
//    }
//[_detail.img[i] valueForKey:@"pixel"] = detailModel.pixel;
    for (int i = 0; i < _detail.img.count; i++) {
        ADDetailModel *detailModel = [[ADDetailModel alloc] init];
        
        //NSLog(@"%@",[_detail.img valueForKey:@"pixel"]);
        
        detailModel.pixel = [_detail.img[i] valueForKey:@"pixel"];
        detailModel.ref = [_detail.img[i] valueForKey:@"ref"];
        detailModel.src = [_detail.img[i] valueForKey:@"src"];

        //数组存放被切割的像素
        NSArray *pixel = [detailModel.pixel componentsSeparatedByString:@"*"];
        CGFloat width = [[pixel firstObject] floatValue];
        CGFloat height = [[pixel lastObject] floatValue];
        
        //判断是否超过最大宽度
        CGFloat maxWidth = [UIScreen mainScreen].bounds.size.width;
        
        if (width > maxWidth) {
            height = maxWidth / width *height;
            width = maxWidth;
        }
        
        NSMutableString *imgHtml = [NSMutableString string];
        
        [imgHtml appendString:@"<div class=\"img-parent\">"];
        
        //NSLog(@"%@",detailModel.pixel);
        
        [imgHtml appendFormat:@"<img width=\"%f\" height=\"%f\" src=\"%@\">",width,height,detailModel.src];
        
        [imgHtml appendString:@"</div>"];
        
    
        
        //替换标记
        [html replaceOccurrencesOfString:detailModel.ref withString:imgHtml options:NSCaseInsensitiveSearch range:NSMakeRange(0, html.length)];
        NSLog(@"%@",detailModel.ref);
        //NSLog(@"%@",html);
    }
            //[_detail.img valueForKey:@"pixel"] = detailModel.pixel;
    
    
    
    [html appendString:@"</body>"];
    [html appendString:@"</html>"];

    [_webView loadHTMLString:html baseURL:nil];

    
    //将httml文件读取为字符串，其中baseURL是我们自己设置的一个路径，用于寻找html文件中引用的图片等素材
}
-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
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
