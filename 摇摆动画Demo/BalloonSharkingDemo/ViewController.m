//
//  ViewController.m
//  BalloonSharkingDemo
//
//  Created by 张培川 on 13-12-17.
//  Copyright (c) 2013年 张培川. All rights reserved.
//
#define IS_IPHONE_5 ( fabs( ( double )[ [ UIScreen mainScreen ] bounds ].size.height - ( double )568 ) < DBL_EPSILON )
#define DEGREES_TO_RADIANS(d) (d * M_PI / 180)

#define kScreenWidth        ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight       ([UIScreen mainScreen].bounds.size.height)


#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.view.backgroundColor = [UIColor lightGrayColor];
    [self initLayer];
    btn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    btn.frame = CGRectMake(280, 5, 44, 44);
    [btn setTitle:@"click" forState:UIControlStateNormal];
    // 这里替换执行的方法就可测试不同的动画效果
    [btn addTarget:self action:@selector(moveAnmationAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)initLayer {
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 435*0.3,126*0.3)];
    imageView.bounds = CGRectMake(0, 0, 435*0.3,126*0.3);
    imageView.layer.position = CGPointMake(160, IS_IPHONE_5?416+88:416);
    [imageView setImage:[UIImage imageNamed:@"live_recordHit"]];
    imageView.layer.anchorPoint = CGPointMake(0.5, 1.0);
    [self.view addSubview:imageView];
    
    imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 435*0.3,126*0.3)];
    imageView2.bounds = CGRectMake(0, 0, 435*0.3,126*0.3);
    imageView2.layer.position = CGPointMake(160, 300);
    [imageView2 setImage:[UIImage imageNamed:@"live_recordHitThird"]];
    imageView2.layer.anchorPoint = CGPointMake(0.5, 1.0);
    [self.view addSubview:imageView2];
    
    
    
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //设置默认参数
    angle =10.0;
    timeInter = 0.1;
}

// 来回旋转渐停动画
-(void)rotateAnimation {
    btn.userInteractionEnabled = NO;
    
    //左右摇摆时间是定义的时间的2倍
    [NSTimer scheduledTimerWithTimeInterval:timeInter*2
                                     target:self
                                   selector:@selector(ballAnmation:)
                                   userInfo:nil
                                    repeats:YES];
}

// 位移左右波动渐停动画
-(void)moveAnimation {
    btn.userInteractionEnabled = NO;
    
    //左右摇摆时间是定义的时间的2倍
    [NSTimer scheduledTimerWithTimeInterval:timeInter*2
                                     target:self
                                   selector:@selector(ballAnmation:)
                                   userInfo:nil
                                    repeats:YES];
}


-(void)moveAnmationAction {
    //顺便看看旋转动画
    [self moveAnimation];
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animation];
    animation.keyPath = @"position";
    CGFloat commonSpace = 70.0;
    
    NSValue *value1 = [NSValue valueWithCGPoint:CGPointMake(-145, 50)];
    NSValue *value2 = [NSValue valueWithCGPoint:CGPointMake(10 + commonSpace, 50)];
    NSValue *value3 = [NSValue valueWithCGPoint:CGPointMake(1 + commonSpace, 50)];
    NSValue *value4 = [NSValue valueWithCGPoint:CGPointMake(8 + commonSpace, 50)];
    NSValue *value5 = [NSValue valueWithCGPoint:CGPointMake(3 + commonSpace, 50)];
    NSValue *value6 = [NSValue valueWithCGPoint:CGPointMake(6 + commonSpace, 50)];
    NSValue *value7 = [NSValue valueWithCGPoint:CGPointMake(5 + commonSpace, 50)];
    
    animation.values = @[value1, value2,value3,value4,value5, value6, value7];
    animation.removedOnCompletion = NO;
    animation.fillMode = kCAFillModeForwards;
    animation.duration = 0.3f;
    animation.timingFunction=[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [imageView2.layer addAnimation:animation forKey:@"values"];
}



-(void)ballAnmation:(NSTimer *)theTimer {
    //设置左右摇摆
    angle=-angle;
    if (angle > 0) {
        angle--;
    }else{
        angle++;
    }
    CABasicAnimation* rotationAnimation = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    rotationAnimation.toValue = [NSNumber numberWithFloat:(DEGREES_TO_RADIANS(angle))];
    rotationAnimation.duration = timeInter;
    rotationAnimation.autoreverses = YES; // Very convenient CA feature for an animation like this
    rotationAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    [imageView.layer addAnimation:rotationAnimation forKey:@"revItUpAnimation"];
    if (angle == 0) {
        [theTimer invalidate];
        //动画完毕操作
        btn.userInteractionEnabled = YES;
    
        angle =10.0;
        timeInter = 0.1;
    }
}

@end
