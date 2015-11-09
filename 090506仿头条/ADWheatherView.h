//
//  ADWheatherView.h
//  
//
//  Created by csip on 15/9/13.
//
//

#import <UIKit/UIKit.h>

@class ADWeatherModal;

@interface ADWheatherView : UIView

@property(nonatomic,strong)ADWeatherModal *weatherModal;

-(void)addAnimate;
@end
