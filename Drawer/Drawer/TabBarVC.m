//
//  TabBarVC.m
//  Drawer
//
//  Created by test on 2017/10/14.
//  Copyright © 2017年 test. All rights reserved.
//

#import "TabBarVC.h"
#import "ConnectionTVC.h"
#import "messageTVC.h"
#import "DynamicTVC.h"



@interface TabBarVC ()

@end

@implementation TabBarVC

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self addChildVC:[[ConnectionTVC alloc]init] title:@"联系人" imageName:nil HighlightedImage:nil];
    [self addChildVC:[[messageTVC alloc]init] title:@"消息" imageName:nil HighlightedImage:nil];
    [self addChildVC:[[DynamicTVC alloc]init] title:@"动态" imageName:nil HighlightedImage:nil];
    
}

- (void)addChildVC:(UIViewController *)childVC title:(NSString *)title imageName:(NSString *)imageName HighlightedImage:(NSString *)highlightedImage{

    childVC.title = title;
    
    childVC.tabBarItem.image = [[UIImage imageNamed:imageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    childVC.tabBarItem.selectedImage = [[UIImage imageNamed:highlightedImage] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
    
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:childVC];

    return [self addChildViewController:nav];
}


@end
