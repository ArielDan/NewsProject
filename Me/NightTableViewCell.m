//
//  NightTableViewCell.m
//  新闻
//
//  Created by yj on 16/5/8.
//  Copyright © 2016年 ariel. All rights reserved.
//

#import "NightTableViewCell.h"


@interface NightTableViewCell()

@property (weak, nonatomic) IBOutlet UISwitch *modeSwitch;
@property (weak, nonatomic) IBOutlet UILabel *descLbl;

@end

@implementation NightTableViewCell

- (void)awakeFromNib {
    // Initialization code
    [_modeSwitch setOn:NO];
    //self.dk_backgroundColorPicker = DKColorPickerWithKey(BG);
    
}
- (IBAction)switchValueChange:(id)sender {
    DKNightVersionManager *nightManager = [DKNightVersionManager sharedManager];
    BOOL isBtnOn = [sender isOn];
    if (isBtnOn) {
        
        nightManager.themeVersion = DKThemeVersionNight;
        
        _descLbl.dk_textColorPicker = DKColorPickerWithKey(TEXT);
        
        NSLog(@"夜间模式");

    }else{
        nightManager.themeVersion = DKThemeVersionNormal;
        NSLog(@"正常");
    }
    
    //向观察者发送信息
    [[NSNotificationCenter defaultCenter] postNotification:[NSNotification notificationWithName:@"modeChange" object:nil]];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
