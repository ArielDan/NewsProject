//
//  ADCommon.h
//  090506仿头条
//
//  Created by csip on 15/10/17.
//  Copyright © 2015年 ariel. All rights reserved.
//

#ifndef ADCommon_h
#define ADCommon_h


//覆盖层按钮tag
#define kButtonTag 1200


#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

//头部视图高度
#define kHeaderViewH 230

//左边菜单栏的宽高
#define kLeftMenuW kScreenW*0.65



#define kColor(r,g,b,a) [UIColor colorWithRed:r/255.0 green:g/255.0 blue:b/255.0 alpha: a]

// 随机色
#define  XWRandomColor XWColor(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))

#define kCollectionViewH (kHeaderViewH - 30)

#endif /* ADCommon_h */
