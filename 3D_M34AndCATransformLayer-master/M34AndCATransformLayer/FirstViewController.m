//
//  FirstViewController.m
//  M34AndCATransformLayer
//
//  Created by FrankLiu on 16/1/19.
//  Copyright © 2016年 FrankLiu. All rights reserved.
//

#import "FirstViewController.h"

#import "GCD.h"
#import "UIView+SetRect.h"

#define DEGREE(d)            ((d) * M_PI / 180.0f)

@interface FirstViewController ()

@property (nonatomic, strong) GCDTimer  *m_timer;

@end

@implementation FirstViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.m_timer = [[GCDTimer alloc]initInQueue:[GCDQueue mainQueue]];
    
    [self staticM34];
    
    [self animateM34];
}

- (void)staticM34 {

    // 普通的一个layer
    CALayer *planeLayer1        = [CALayer layer];
    planeLayer1.anchorPoint     = CGPointMake(0.5, 0.5);                                        // 锚点
    planeLayer1.frame           = (CGRect){CGPointZero, CGSizeMake(100, 100)};                  // 尺寸
    planeLayer1.position        = CGPointMake(self.view.centerX - 55, self.view.centerY - 60);  // 位置
    planeLayer1.opacity         = 0.6;                                                          // 背景透明度
    planeLayer1.backgroundColor = [UIColor redColor].CGColor;                                   // 背景色
    planeLayer1.borderWidth     = 3;                                                            // 边框宽度
    planeLayer1.borderColor     = [[UIColor whiteColor] colorWithAlphaComponent:0.5].CGColor;   // 边框颜色(设置了透明度)
    planeLayer1.cornerRadius    = 10;                                                           // 圆角值
    
    
    // 普通的一个layer
    CALayer *planeLayer2        = [CALayer layer];
    planeLayer2.anchorPoint     = CGPointMake(0.5, 0.5);                                        // 锚点
    planeLayer2.frame           = (CGRect){CGPointZero, CGSizeMake(100, 100)};                  // 尺寸
    planeLayer2.position        = CGPointMake(self.view.centerX + 55, self.view.centerY - 60);  // 位置
    planeLayer2.opacity         = 0.6;                                                          // 背景透明度
    planeLayer2.backgroundColor = [UIColor greenColor].CGColor;                                 // 背景色
    planeLayer2.borderWidth     = 3;                                                            // 边框宽度
    planeLayer2.borderColor     = [[UIColor whiteColor] colorWithAlphaComponent:0.5].CGColor;   // 边框颜色(设置了透明度)
    planeLayer2.cornerRadius    = 10;                                                           // 圆角值
    
    // 创建容器layer
    CALayer *container = [CALayer layer];
    container.frame    = self.view.bounds;
    [self.view.layer addSublayer:container];
    
    CATransform3D plane_3D = CATransform3DIdentity;
    plane_3D.m34           = 1.0/ -500;
    plane_3D               = CATransform3DRotate(plane_3D, DEGREE(30), 0, 1, 0);
    container.transform    = plane_3D;
    
    [container addSublayer:planeLayer1];
    [container addSublayer:planeLayer2];
}

- (void)animateM34 {

    // 普通layer
    CALayer *planeLayer = [CALayer layer];
    [self.view.layer addSublayer:planeLayer];
    
    planeLayer.anchorPoint     = CGPointMake(0.5, 0.5);                                         // 锚点
    planeLayer.frame           = (CGRect){CGPointZero, CGSizeMake(100, 100)};                   // 尺寸
    planeLayer.position        = CGPointMake(self.view.centerX, self.view.centerY + 60);        // 位置
    planeLayer.opacity         = 0.6;                                                           // 背景透明度
    planeLayer.backgroundColor = [UIColor blueColor].CGColor;                                   // 背景色
    planeLayer.borderWidth     = 3.f;                                                           // 边框宽度
    planeLayer.borderColor     = [[UIColor whiteColor] colorWithAlphaComponent:0.5].CGColor;    // 边框颜色(设置了透明度)
    planeLayer.cornerRadius    = 10;                                                            // 圆角值
    
    // 启动定时器
    [self.m_timer event:^{
        
        static float degree = 0;
        
        //起始值
        CATransform3D fromValue = CATransform3DIdentity;
        
        fromValue.m34 = -1.f / 300;
        fromValue     = CATransform3DRotate(fromValue, degree, 0, 1, 0);
        
        // 结束值
        CATransform3D toValue = CATransform3DIdentity;
        
        toValue.m34 = -1.f / 300;
        toValue     = CATransform3DRotate(toValue, degree += 45.f, 0, 1, 0);
        
        // 添加3D动画
        CABasicAnimation *transform3D = [CABasicAnimation animationWithKeyPath:@"transform"];
        
        transform3D.duration  = 1.f;
        transform3D.fromValue = [NSValue valueWithCATransform3D:fromValue];
        transform3D.toValue   = [NSValue valueWithCATransform3D:toValue];
        planeLayer.transform  = toValue;
        
        [planeLayer addAnimation:transform3D forKey:@"transform3D"];
        
    } timeIntervalWithSecs:1.f];
    
    [self.m_timer start];
}

@end
