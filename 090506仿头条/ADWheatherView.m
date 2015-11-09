//
//  ADWheatherView.m
//  
//
//  Created by csip on 15/9/13.
//
//

#import "ADWheatherView.h"
#import "ADWeatherModal.h"


#import "UIView+Frame.h"



@interface ADWheatherView()

@property(nonatomic,strong)UIView *mainView;

@property(nonatomic,strong)UIView *buttonView;

@property(nonatomic,strong)UIButton *btn1;
@property(nonatomic,strong)UIButton *btn2;
@property(nonatomic,strong)UIButton *btn3;
@property(nonatomic,strong)UIButton *btn4;
@property(nonatomic,strong)UIButton *btn5;
@property(nonatomic,strong)UIButton *btn6;

@property(nonatomic,strong)UIImageView *img1;
@property(nonatomic,strong)UIImageView *img2;
@property(nonatomic,strong)UIImageView *img3;
@property(nonatomic,strong)UIImageView *img4;
@property(nonatomic,strong)UIImageView *img5;
@property(nonatomic,strong)UIImageView *img6;

@property(nonatomic,strong)UILabel *temperatureLbl;
@property(nonatomic,strong)UILabel *nowTempLbl;
@property(nonatomic,strong)UILabel *climateLbl;
@property(nonatomic,strong)UILabel *locaLbl;
@property(nonatomic,strong)UILabel *dateWeekLbl;
@property(nonatomic,strong)UILabel *airPMLbl;

@property(strong ,nonatomic)ADWheatherView *weatherView;

@end

@implementation ADWheatherView

-(void)layoutSubviews{
    
    [super layoutSubviews];
    
   
    
    _buttonView = [[UIView alloc] init];
    
    [self addSubview:_buttonView];
    _buttonView.x = 0;
    _buttonView.y = 255;
    _buttonView.height = self.height - self.buttonView.y - 20;
    _buttonView.width = self.width;
    //[_buttonView setBackgroundColor:[UIColor greenColor]];
     
    //_buttonView.backgroundColor = [UIColor blueColor];
    
    //[self addSubview:_buttonView];
    
    [self addBtnWithTitle:@"搜索" icon:@"201" color:[UIColor orangeColor] index:0];
    [self addBtnWithTitle:@"上头条" icon:@"202" color:[UIColor redColor] index:1];
    [self addBtnWithTitle:@"离线" icon:@"203" color:kColor(213, 22, 71,1) index:2];
    [self addBtnWithTitle:@"夜间" icon:@"205" color:kColor(58, 153, 208,1) index:3];
    [self addBtnWithTitle:@"扫一扫" icon:@"204" color: kColor(70, 95, 176,1) index:4];
    [self addBtnWithTitle:@"邀请好友" icon:@"201" color:kColor(80,192,70,1) index:5];

    
    //[self addLabel];
    
    NSLog(@"layoutSubviews");
}

-(void)setWeatherModal:(ADWeatherModal *)weatherModal{
    [self addLabel];
    
    _weatherModal = weatherModal;
    int pm = weatherModal.pm2d5.intValue;
    
    NSMutableString *temp = [weatherModal.temperature mutableCopy];
    _temperatureLbl.text = temp;
    
    _dateWeekLbl.text = [NSString stringWithFormat:@"%@  %@",weatherModal.date,weatherModal.week];
    _airPMLbl.text = [NSString stringWithFormat:@"PM2.5 %d ",pm];
    _climateLbl.text = [NSString stringWithFormat:@"%@,%@",weatherModal.climate,weatherModal.wind];
    _locaLbl.text = @"北京";
    NSLog(@"%@",[NSString stringWithFormat:@"%@,%@",weatherModal.climate,weatherModal.wind]);
    //_temperatureLbl = [[UILabel alloc] init];
    
    //NSLog(@"%@",_temperatureLbl.text);

    NSLog(@"Set WeatherModal");
    
}
-(void)addLabel{
    [self setBackgroundColor:[UIColor lightGrayColor]];
    
    _mainView = [[UIView alloc] init];
    
    [self addSubview:_mainView];
    _mainView.x = 0;
    _mainView.y = 0;
    _mainView.height = self.height - 20;
    _mainView.width = self.width;
    
    _temperatureLbl = [[UILabel alloc] init];
    _temperatureLbl.frame = CGRectMake(200, 100, 100, 50);
    //_temperatureLbl.backgroundColor = [UIColor blackColor];
    
    _temperatureLbl.textColor = [UIColor blackColor];
    
    _nowTempLbl = [[UILabel alloc] init];
    _nowTempLbl.frame = CGRectMake(20, 100, 100, 50);
    //_nowTempLbl.backgroundColor = [UIColor blackColor];
    
    _airPMLbl = [[UILabel alloc] init];
    _airPMLbl.frame = CGRectMake(200, 25, 100, 50);
    //_airPMLbl.backgroundColor = [UIColor blackColor];
    
    _locaLbl = [[UILabel alloc] init];

    _locaLbl.frame = CGRectMake(20, 40, 100, 50);
    
    //_locaLbl.textColor = [UIColor blackColor];
    //_locaLbl.backgroundColor = [UIColor greenColor];
    
    _climateLbl = [[UILabel alloc] init];
    _climateLbl.frame = CGRectMake(200, 160, 100, 50);
    //_climateLbl.textColor = [UIColor blackColor];
    //_climateLbl.backgroundColor = [UIColor greenColor];
    
    _dateWeekLbl = [[UILabel alloc] init];
    _dateWeekLbl.frame = CGRectMake(20, 165, 100, 50);
    //_dateWeekLbl.backgroundColor = [UIColor greenColor];
    [self.mainView addSubview:_dateWeekLbl];
    [self.mainView addSubview:_climateLbl];
    [self.mainView addSubview:_temperatureLbl];
    [self.mainView addSubview:_nowTempLbl];
    [self.mainView addSubview:_locaLbl];
    [self.mainView addSubview:_airPMLbl];
    
    NSLog(@"Add Label...");
    
}

-(void)addBtnWithTitle:(NSString *)title icon:(NSString *)icon color:(UIColor *)color index:(int)index{
    int row = index /3;
    int col = index %3;
    
    CGFloat w = self.width /3;
    CGFloat h = self.buttonView.height /2;
    
    UIView *itemView = [[UIView alloc] init];
    //[itemView setBackgroundColor:[UIColor yellowColor]];
    itemView.height = h;
    itemView.width = w;
    itemView.x = col * w;
    itemView.y = row * h;
    
    [self.buttonView addSubview:itemView];
    
    UIButton *btn = [[UIButton alloc]init];
    
    btn.x = 20;
    btn.y = 40;
    
    if (index > 2) {
        btn.y = 10;
    }
    
    btn.width = w - 40;
    
    btn.height = btn.width;
    
    btn.backgroundColor = color;
    
    btn.layer.cornerRadius = btn.width /2;
    btn.layer.masksToBounds = YES;
    
    [itemView addSubview:btn];
    
    UIImageView *image = [[UIImageView alloc] initWithImage:[UIImage imageNamed:icon]];
    
    image.width = btn.width;
    
    image.height = image.width;
    
    image.center = btn.center;
    
    [itemView addSubview:image];
    
    UILabel *btnName = [[UILabel alloc] initWithFrame:CGRectMake(0, btn.y + btn.height, itemView.width, 40)];
    
    btnName.text = title;
    
    btnName.textAlignment = NSTextAlignmentCenter;
    
    [itemView addSubview:btnName];
    
}
- (void)addAnimate{
    
    self.btn1.transform = CGAffineTransformMakeScale(0.2, 0.2);
    self.btn2.transform = CGAffineTransformMakeScale(0.2, 0.2);
    self.btn3.transform = CGAffineTransformMakeScale(0.2, 0.2);
    self.btn4.transform = CGAffineTransformMakeScale(0.2, 0.2);
    self.btn5.transform = CGAffineTransformMakeScale(0.2, 0.2);
    self.btn6.transform = CGAffineTransformMakeScale(0.2, 0.2);
    
    self.img1.transform = CGAffineTransformMakeScale(1.4, 1.4);
    self.img2.transform = CGAffineTransformMakeScale(1.4, 1.4);
    self.img3.transform = CGAffineTransformMakeScale(1.4, 1.4);
    self.img4.transform = CGAffineTransformMakeScale(1.4, 1.4);
    self.img5.transform = CGAffineTransformMakeScale(1.4, 1.4);
    self.img6.transform = CGAffineTransformMakeScale(1.4, 1.4);
    [UIView animateWithDuration:0.2 animations:^{
        self.btn1.transform = CGAffineTransformMakeScale(1.2, 1.2);
        self.btn2.transform = CGAffineTransformMakeScale(1.2, 1.2);
        self.btn3.transform = CGAffineTransformMakeScale(1.2, 1.2);
        self.btn4.transform = CGAffineTransformMakeScale(1.2, 1.2);
        self.btn5.transform = CGAffineTransformMakeScale(1.2, 1.2);
        self.btn6.transform = CGAffineTransformMakeScale(1.2, 1.2);
        
        self.img1.transform = CGAffineTransformMakeScale(0.7, 0.7);
        self.img2.transform = CGAffineTransformMakeScale(0.7, 0.7);
        self.img3.transform = CGAffineTransformMakeScale(0.7, 0.7);
        self.img4.transform = CGAffineTransformMakeScale(0.7, 0.7);
        self.img5.transform = CGAffineTransformMakeScale(0.7, 0.7);
        self.img6.transform = CGAffineTransformMakeScale(0.7, 0.7);
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.2 animations:^{
            self.btn1.transform = CGAffineTransformIdentity;
            self.btn2.transform = CGAffineTransformIdentity;
            self.btn3.transform = CGAffineTransformIdentity;
            self.btn4.transform = CGAffineTransformIdentity;
            self.btn5.transform = CGAffineTransformIdentity;
            self.btn6.transform = CGAffineTransformIdentity;
            
            self.img1.transform = CGAffineTransformIdentity;
            self.img2.transform = CGAffineTransformIdentity;
            self.img3.transform = CGAffineTransformIdentity;
            self.img4.transform = CGAffineTransformIdentity;
            self.img5.transform = CGAffineTransformIdentity;
            self.img6.transform = CGAffineTransformIdentity;
        }];
        
    }];
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
