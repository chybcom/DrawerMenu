//
//  MineViewController.m
//  Drawer
//
//  Created by test on 2017/10/15.
//  Copyright © 2017年 test. All rights reserved.
//

#import "MineViewController.h"

@interface MineViewController ()

@end

@implementation MineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blueColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"退出" style:UIBarButtonItemStylePlain target:self action:@selector(leftClick)];
    
    
}

- (void)leftClick{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    NSLog(@"%s",__FUNCTION__);
    
}

@end
