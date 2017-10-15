//
//  DrawerVC.m
//  Drawer
//
//  Created by test on 2017/10/14.
//  Copyright © 2017年 test. All rights reserved.
//

#import "DrawerVC.h"

@interface DrawerVC ()

/** 左边菜单VC */
@property (nonatomic,strong) UIViewController *leftMenuVC;

/** 主控制器VC */
@property (nonatomic,strong) UIViewController *mainVC;

/** 菜单移动宽度 */
@property (nonatomic,assign) CGFloat moveWidth;

/** cover 覆盖按钮 */
@property (nonatomic,strong) UIButton *coverButton;


@end

@implementation DrawerVC

/** 遮盖按钮 */
- (UIButton *)coverButton{
    if (_coverButton == nil) {
        UIButton *button = [[UIButton alloc]initWithFrame:self.mainVC.view.bounds];
//        button.backgroundColor = [UIColor orangeColor];
        [button addTarget:self action:@selector(coverButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        // 给按钮添加拖拽手势
        [button addGestureRecognizer:[[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(buttonPanGesture:)]];
        _coverButton = button;
    }
    return _coverButton;
}

- (void)buttonPanGesture:(UIPanGestureRecognizer *)pan{
    
    CGFloat offset = [pan translationInView:pan.view].x;
    
    NSLog(@"%f",offset);
    
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    
    if (offset > 0) {
        return;
    }
    
    CGFloat distance = self.moveWidth - ABS(offset);
    
    if (pan.state == UIGestureRecognizerStateEnded || pan.state == UIGestureRecognizerStateCancelled) { //手势结束或取消时
        if (offset > screenW * 0.5) {
            [self openLeftMenu];
        }else{
            [self coverButtonClick:nil];
        }
    }else if (pan.state == UIGestureRecognizerStateChanged){
        self.mainVC.view.transform = CGAffineTransformMakeTranslation(MAX(0,distance), 0);
        
        self.leftMenuVC.view.transform = CGAffineTransformMakeTranslation(-self.moveWidth + distance, 0);
    }
    
}

- (void)coverButtonClick:(UIButton *)button{
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        self.mainVC.view.transform = CGAffineTransformIdentity;
        
        self.leftMenuVC.view.transform = CGAffineTransformMakeTranslation(-self.moveWidth, 0);

    } completion:^(BOOL finished) {
        
        [self.coverButton removeFromSuperview];
        
        self.coverButton = nil;
        
    }];

}

- (void)viewDidLoad {
    // 112233
    
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.leftMenuVC.view.transform = CGAffineTransformMakeTranslation(-self.moveWidth, 0);
    
    
    //给 main控制器view添加左边阴影效果
    self.mainVC.view.layer.shadowColor = [UIColor blackColor].CGColor;
    //阴影位置
    self.mainVC.view.layer.shadowOffset = CGSizeMake(-3, -3);
    // 图层透明度
    self.mainVC.view.layer.shadowOpacity = 0.2;
    // 阴影半径
    self.mainVC.view.layer.shadowRadius = 5;
    
    
    //给mainVC里面的每个控制器的view添加边缘拖拽手势
    for (UIViewController *vc in self.mainVC.childViewControllers) {
        UIScreenEdgePanGestureRecognizer *edgePan = [[UIScreenEdgePanGestureRecognizer alloc]initWithTarget:self action:@selector(mainVCEdgePan:)];
        edgePan.edges = UIRectEdgeLeft; //设置左边缘有拖拽手势
        [vc.view addGestureRecognizer:edgePan];
    }
}

- (void)mainVCEdgePan:(UIScreenEdgePanGestureRecognizer *)edgePan{
    
    CGFloat screenW = [UIScreen mainScreen].bounds.size.width;
    /** 手势移动距离 */
    CGFloat offset = [edgePan translationInView:edgePan.view].x;
    
    if (edgePan.state == UIGestureRecognizerStateEnded || edgePan.state == UIGestureRecognizerStateCancelled) { //手势结束或取消时
        if (offset > screenW * 0.5) {
            [self openLeftMenu];
        }else{
            [self coverButtonClick:nil];
        }
    }else if (edgePan.state == UIGestureRecognizerStateChanged){
        
        if (-self.moveWidth+ABS(offset) > 0) return;
        
        self.mainVC.view.transform = CGAffineTransformMakeTranslation(offset, 0);
 
        self.leftMenuVC.view.transform = CGAffineTransformMakeTranslation(-self.moveWidth+ABS(offset), 0);
    }
}

/** 获取抽屉控制器 */
+ (instancetype)drawer{

    return (DrawerVC *)[UIApplication sharedApplication].keyWindow.rootViewController;
}

/** 打开抽屉菜单 */
- (void)openLeftMenu{
    
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        
        self.mainVC.view.transform = CGAffineTransformMakeTranslation(self.moveWidth, 0);
        
        self.leftMenuVC.view.transform = CGAffineTransformIdentity;
        
    } completion:^(BOOL finished) {
        
        [self.mainVC.view addSubview:self.coverButton];
        
    }];
  
}


+ (instancetype)drawerWithLeftVC:(UIViewController *)leftVC mainVC:(UIViewController *)mainVC moveWidth:(CGFloat)moveWidth{
    
    DrawerVC *drawerVC = [[DrawerVC alloc]init];
    
    drawerVC.leftMenuVC = leftVC;
    drawerVC.mainVC = mainVC;
    drawerVC.moveWidth = moveWidth;
 
    [drawerVC.view addSubview:leftVC.view];
    [drawerVC.view addSubview:mainVC.view];
    [drawerVC addChildViewController:leftVC];
    [drawerVC addChildViewController:mainVC];

    return drawerVC;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
