//
//  SecondViewController.m
//  M34AndCATransformLayer
//
//  Created by FrankLiu on 16/1/19.
//  Copyright © 2016年 FrankLiu. All rights reserved.
//

#import "SecondViewController.h"

#import "GCD.h"
#import "UIView+SetRect.h"

#define DEGREE(d)            ((d) * M_PI / 180.0f)

@interface SecondViewController ()

@property (nonatomic, strong) GCDTimer  *m_timer1;
@property (nonatomic, strong) GCDTimer  *m_timer2;

@end

@implementation SecondViewController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    self.m_timer1 = [[GCDTimer alloc]initInQueue:[GCDQueue mainQueue]];
    self.m_timer2 = [[GCDTimer alloc]initInQueue:[GCDQueue mainQueue]];
    
    [self animateCALayer];
    
    [self animateCATransformLayer];
}

- (void)animateCALayer {
    
    // 普通的一个layer
    CALayer *planeLayer1        = [CALayer layer];
    planeLayer1.anchorPoint     = CGPointMake(0.5, 0.5);                                        // 锚点
    planeLayer1.frame           = (CGRect){CGPointZero, CGSizeMake(100, 100)};                  // 尺寸
    planeLayer1.position        = CGPointMake(self.view.centerX, self.view.centerY - 55);       // 位置
    planeLayer1.opacity         = 0.6;                                                          // 背景透明度
    planeLayer1.backgroundColor = [UIColor redColor].CGColor;                                   // 背景色
    planeLayer1.borderWidth     = 3;                                                            // 边框宽度
    planeLayer1.borderColor     = [[UIColor whiteColor] colorWithAlphaComponent:0.5].CGColor;   // 边框颜色(设置了透明度)
    planeLayer1.cornerRadius    = 10;                                                           // 圆角值
    
    // Z轴平移
    CATransform3D planeLayer1_3D = CATransform3DIdentity;
    planeLayer1_3D               = CATransform3DTranslate(planeLayer1_3D, 0, 0, -10);
    planeLayer1.transform        = planeLayer1_3D;
    
    // 普通的一个layer
    CALayer *planeLayer2        = [CALayer layer];
    planeLayer2.anchorPoint     = CGPointMake(0.5, 0.5);                                        // 锚点
    planeLayer2.frame           = (CGRect){CGPointZero, CGSizeMake(100, 100)};                  // 尺寸
    planeLayer2.position        = CGPointMake(self.view.centerX, self.view.centerY - 55);       // 位置
    planeLayer2.opacity         = 0.6;                                                          // 背景透明度
    planeLayer2.backgroundColor = [UIColor greenColor].CGColor;                                 // 背景色
    planeLayer2.borderWidth     = 3;                                                            // 边框宽度
    planeLayer2.borderColor     = [[UIColor whiteColor] colorWithAlphaComponent:0.5].CGColor;   // 边框颜色(设置了透明度)
    planeLayer2.cornerRadius    = 10;                                                           // 圆角值
    
    // Z轴平移
    CATransform3D planeLayer2_3D = CATransform3DIdentity;
    planeLayer2_3D               = CATransform3DTranslate(planeLayer2_3D, 0, 0, -30);
    planeLayer2.transform        = planeLayer2_3D;
    
    // 创建容器layer
    CALayer *container = [CALayer layer];
    container.frame    = self.view.bounds;
    [self.view.layer addSublayer:container];
    [container addSublayer:planeLayer1];
    [container addSublayer:planeLayer2];
    
    // 启动定时器
    [self.m_timer1 event:^{
        static float degree = 0.f;
        
        // 起始值
        CATransform3D fromValue = CATransform3DIdentity;
        fromValue.m34           = 1.0/ -500;
        fromValue               = CATransform3DRotate(fromValue, degree, 0, 1, 0);
        
        // 结束值
        CATransform3D toValue   = CATransform3DIdentity;
        toValue.m34             = 1.0/ -500;
        toValue                 = CATransform3DRotate(toValue, degree += 45.f, 0, 1, 0);
        
        // 添加3d动画
        CABasicAnimation *transform3D = [CABasicAnimation animationWithKeyPath:@"transform"];
        transform3D.duration  = 1.f;
        transform3D.fromValue = [NSValue valueWithCATransform3D:fromValue];
        transform3D.toValue   = [NSValue valueWithCATransform3D:toValue];
        container.transform = toValue;
        [container addAnimation:transform3D forKey:@"transform3D"];
        
    } timeIntervalWithSecs:1.f];
    
    [self.m_timer1 start];
}

- (void)animateCATransformLayer {

    // 普通的一个layer
    CALayer *planeLayer1        = [CALayer layer];
    planeLayer1.anchorPoint     = CGPointMake(0.5, 0.5);                                        // 锚点
    planeLayer1.frame           = (CGRect){CGPointZero, CGSizeMake(100, 100)};                  // 尺寸
    planeLayer1.position        = CGPointMake(self.view.centerX, self.view.centerY + 55);       // 位置
    planeLayer1.opacity         = 0.6;                                                          // 背景透明度
    planeLayer1.backgroundColor = [UIColor redColor].CGColor;                                   // 背景色
    planeLayer1.borderWidth     = 3;                                                            // 边框宽度
    planeLayer1.borderColor     = [[UIColor whiteColor] colorWithAlphaComponent:0.5].CGColor;   // 边框颜色(设置了透明度)
    planeLayer1.cornerRadius    = 10;                                                           // 圆角值
    
    // Z轴平移
    CATransform3D planeLayer1_3D = CATransform3DIdentity;
    planeLayer1_3D               = CATransform3DTranslate(planeLayer1_3D, 0, 0, -10);
    planeLayer1.transform        = planeLayer1_3D;
    
    // 普通的一个layer
    CALayer *planeLayer2        = [CALayer layer];
    planeLayer2.anchorPoint     = CGPointMake(0.5, 0.5);                                        // 锚点
    planeLayer2.frame           = (CGRect){CGPointZero, CGSizeMake(100, 100)};                  // 尺寸
    planeLayer2.position        = CGPointMake(self.view.centerX, self.view.centerY + 55);       // 位置
    planeLayer2.opacity         = 0.6;                                                          // 背景透明度
    planeLayer2.backgroundColor = [UIColor greenColor].CGColor;                                 // 背景色
    planeLayer2.borderWidth     = 3;                                                            // 边框宽度
    planeLayer2.borderColor     = [[UIColor whiteColor] colorWithAlphaComponent:0.5].CGColor;   // 边框颜色(设置了透明度)
    planeLayer2.cornerRadius    = 10;                                                           // 圆角值
    
    // Z轴平移
    CATransform3D planeLayer2_3D = CATransform3DIdentity;
    planeLayer2_3D               = CATransform3DTranslate(planeLayer2_3D, 0, 0, -30);
    planeLayer2.transform        = planeLayer2_3D;
    
    // 创建容器layer
    CATransformLayer *container = [CATransformLayer layer];
    container.frame    = self.view.bounds;
    [self.view.layer addSublayer:container];
    [container addSublayer:planeLayer1];
    [container addSublayer:planeLayer2];
    
    // 启动定时器
    [self.m_timer2 event:^{
        static float degree = 0.f;
        
        // 起始值
        CATransform3D fromValue = CATransform3DIdentity;
        fromValue.m34           = 1.0/ -500;
        fromValue               = CATransform3DRotate(fromValue, degree, 0, 1, 0);
        
        // 结束值
        CATransform3D toValue   = CATransform3DIdentity;
        toValue.m34             = 1.0/ -500;
        toValue                 = CATransform3DRotate(toValue, degree += 45.f, 0, 1, 0);
        
        // 添加3d动画
        CABasicAnimation *transform3D = [CABasicAnimation animationWithKeyPath:@"transform"];
        transform3D.duration  = 1.f;
        transform3D.fromValue = [NSValue valueWithCATransform3D:fromValue];
        transform3D.toValue   = [NSValue valueWithCATransform3D:toValue];
        container.transform = toValue;
        [container addAnimation:transform3D forKey:@"transform3D"];
        
    } timeIntervalWithSecs:1.f];
    
    [self.m_timer2 start];
}

@end
