//
//  DrawerVC.h
//  Drawer
//
//  Created by test on 2017/10/14.
//  Copyright © 2017年 test. All rights reserved.
//

#import <UIKit/UIKit.h>




@interface DrawerVC : UIViewController

/** 获取抽屉控制器 */
+ (instancetype)drawer;

/** 打开抽屉菜单 */
- (void)openLeftMenu;

/** 创建抽屉控制器 并同时添加 左边菜单控制器 右边的主控制器 */
+ (instancetype)drawerWithLeftVC:(UIViewController *)leftVC mainVC:(UIViewController *)mainVC moveWidth:(CGFloat)moveWidth;



@end
