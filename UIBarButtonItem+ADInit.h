//
//  UIBarButtonItem+ADInit.h
//  090506仿头条
//
//  Created by csip on 15/10/17.
//  Copyright © 2015年 ariel. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIBarButtonItem (ADInit)

+(UIBarButtonItem *)itemWithIcon:(NSString *)icon target:(id)target action:(SEL)action;

@end
