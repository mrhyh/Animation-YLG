//
//  ViewController.m
//  Animation_HitTest
//
//  Created by hyh on 2017/4/13.
//  Copyright © 2017年 hyh. All rights reserved.
//

#import "ViewController.h"
#import "BlockView.h"

@interface ViewController () <CAAnimationDelegate>

// // 关键帧动画1
@property (nonatomic, weak)    CALayer *movingLayer;
@property (nonatomic, strong)  UITapGestureRecognizer *tapGesture;

// 关键帧动画2
@property (nonatomic, strong)  CALayer *layer;

// CADisplayLink动画
@property (nonatomic, strong)  BlockView *blockView;
@property (nonatomic, strong)  CADisplayLink *displayLink;
@property (nonatomic) BOOL     animating;

@end

@implementation ViewController

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
}

- (void)testAction {
    NSLog(@"动画...");
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 100)];
    view.backgroundColor = [UIColor redColor];
    [self.view addSubview:view];
    view.userInteractionEnabled = YES;
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(testAction)];
    [view addGestureRecognizer:tap];
    [UIView animateWithDuration:5.0 delay:0.0 options:UIViewAnimationOptionAllowUserInteraction animations:^{
        view.frame = CGRectMake(300, 0, 100, 100);
    } completion:^(BOOL finished) {
        
    }];
    
#pragma mark 关键帧动画1
    // 关键帧动画

    CGSize layerSize = CGSizeMake(100, 100);
    
    CALayer *movingLayer = [CALayer layer];
    movingLayer.bounds = CGRectMake(-100, 0, layerSize.width, layerSize.height);
    movingLayer.anchorPoint = CGPointMake(0, 0);
    [movingLayer setBackgroundColor:[UIColor orangeColor].CGColor];
    //    movingLayer.position = CGPointMake(50, 50);
    
    [self.view.layer addSublayer:movingLayer];
    self.movingLayer = movingLayer;
    
    self.tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(click:)];
    [self.view addGestureRecognizer:self.tapGesture];
    
    
    CAKeyframeAnimation *moveLayerAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    moveLayerAnimation.values = @[[NSValue valueWithCGPoint:CGPointMake(0, 0)],
                                  [NSValue valueWithCGPoint:CGPointMake(self.view.frame.size.width, 0)]];
    moveLayerAnimation.duration = 5.0;
    moveLayerAnimation.autoreverses = YES; //返回
    moveLayerAnimation.removedOnCompletion = NO;
    moveLayerAnimation.repeatCount = INFINITY; //INFINITY
    moveLayerAnimation.calculationMode = kCAAnimationCubicPaced;
    moveLayerAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear];
    
    // 给图层添加动画
    [self.movingLayer addAnimation:moveLayerAnimation forKey:@"move"];
    
   
#pragma mark 关键帧动画2
    // 设置背景()
    UIImage *backImage = [UIImage imageNamed:@"haha1"];
    self.view.backgroundColor = [UIColor colorWithPatternImage:backImage];
    
    // 自定义一个图层
    _layer = [[CALayer alloc] init];
    _layer.bounds = CGRectMake(50, 50, 10, 20);
    _layer.position = CGPointMake(50, 150);
    _layer.contents = (id)[UIImage imageNamed:@"11.jpg"].CGImage;
    [self.view.layer addSublayer:_layer];
    
    // 创建动画
    [self translationKeyAnimation];
    
    
#pragma mark 关键帧动画3
    
    // 创建动画
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    
    anim.keyPath = @"position";
    
    anim.duration = 2;
    
    // 取消反弹
    // 告诉在动画结束的时候不要移除
    anim.removedOnCompletion = NO;
    // 始终保持最新的效果
    anim.fillMode = kCAFillModeForwards;
    
    // Oval 椭圆  路径轨迹
    anim.path = [UIBezierPath bezierPathWithOvalInRect:CGRectMake(0, 0, 300, 300)].CGPath;
    
    // 将动画对象添加到 绿色视图的layer上去
    //[self.movingLayer addAnimation:anim forKey:nil];
    
    
#pragma makr  CADisplayLink
    
    [self initCADispalyLinkAnimationAction];
}

- (void)initCADispalyLinkAnimationAction {
    
    UIButton *animationButton = [[UIButton alloc] initWithFrame:CGRectMake(100, 150, 200, 50)];
    animationButton.backgroundColor = [UIColor yellowColor];
    [animationButton setTitle:@"开始CDAisplay动画" forState:UIControlStateNormal];
    [animationButton addTarget:self action:@selector(startCDAispalyLinkAnimationAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:animationButton];
    
    _blockView = [[BlockView alloc] initWithFrame:CGRectMake(100, 500, 100, 100)];
    _blockView.backgroundColor = [UIColor blueColor];
    [self.view addSubview:_blockView];
}

- (void)startCDAispalyLinkAnimationAction
{
    if (self.animating) {
        return;
    }
    
    self.animating = YES;
    
    CGFloat from = CGRectGetHeight(self.view.bounds) - CGRectGetHeight(self.blockView.bounds) / 2;
    CGFloat to = 100;
    
    self.blockView.center = CGPointMake(self.blockView.center.x, from);
    
    [self.blockView startAnimationFrom:from to:to];
    [UIView animateWithDuration:1 delay:0 usingSpringWithDamping:0.85 initialSpringVelocity:0 options:0 animations:^{
        self.blockView.center = CGPointMake(self.blockView.center.x, to);
    } completion:^(BOOL finished) {
        [self.blockView completeAnimation];
        self.animating = NO;
    }];
    
    
}

-(void)click:(UITapGestureRecognizer *)tapGesture {
    CGPoint touchPoint = [tapGesture locationInView:self.view];
    if ([self.movingLayer.presentationLayer hitTest:touchPoint]) {
        NSLog(@"presentationLayer");
    }
}



/**
 * _redLayer 抖动动画
 */
- (void)anim{
    CAKeyframeAnimation *anim = [CAKeyframeAnimation animation];
    
    anim.duration = 0.3;
    anim.keyPath = @"transform";
    NSValue *value =  [NSValue valueWithCATransform3D:CATransform3DMakeRotation((-15) / 180.0 * M_PI, 0, 0, 1)];
    NSValue *value1 =  [NSValue valueWithCATransform3D:CATransform3DMakeRotation((15) / 180.0 * M_PI, 0, 0, 1)];
    NSValue *value2 =  [NSValue valueWithCATransform3D:CATransform3DMakeRotation((-15) / 180.0 * M_PI, 0, 0, 1)];
    anim.values = @[value,value1,value2];
    
    anim.repeatCount = MAXFLOAT;
    
    [_layer addAnimation:anim forKey:nil];
}

/**
 *  关键帧动画, 关键帧动画就是在动画控制过程中开发者指定主要的动画状态, 至于各种状态间动画如何进行则由系统自动运算补充(每个两个关键帧之间系统形成的动画成为补间动画), 这种动画的好处就是开发者不用逐个每个动画帧, 而只关心几个关键帧的状态即可
 
 关键帧动画开发分为两种形式, 一种是通过设置不同的属性进行关键帧控制
 另一种是通过绘制路径进行关键帧控制, 后者优先级高于前者, 如果设置了路径则属性就不再起作用
 */

/**
 *  关于关键帧动画路径
 
 *  如果路径不是曲线的话,
 矩形路径是从矩形的左上角开始运行, 顺时针运行一周回到最上角.
 椭圆路径的话就是从椭圆的右侧开始(0度)顺时针一周回到右侧.
 */
/**
 *  keyTimes
 *
 各个关键帧的时间控制。前面使用values设置了四个关键帧，默认情况下每两帧之间的间隔为:8/(4-1)秒。如果想要控制动画从第一帧到第二针占用时间4秒，从第二帧到第三帧时间为2秒，而从第三帧到第四帧时间2秒的话，就可以通过keyTimes进行设置。keyTimes中存储的是时间占用比例点，此时可以设置keyTimes的值为0.0，0.5，0.75，1.0（当然必须转换为NSNumber），也就是说1到2帧运行到总时间的50%，2到3帧运行到总时间的75%，3到4帧运行到8秒结束。
 
 */

/**
 *  caculationMode
 *
 *  动画计算模式。还拿上面keyValues动画举例，之所以1到2帧能形成连贯性动画而不是直接从第1帧经过8/3秒到第2帧是因为动画模式是连续的
 kCAAnimationLinear 这是计算模式的默认值
 kCAAnimationDiscrete离散的那么你会看到动画从第1帧经过8/3秒直接到第2帧，中间没有任何过渡
 kCAAnimationPaced（均匀执行，会忽略keyTimes）、
 kCAAnimationCubic（平滑执行，对于位置变动关键帧动画运行轨迹更平滑
 kCAAnimationCubicPaced（平滑均匀执行）
 */
#pragma mark --- 关键帧动画----> 设置关键帧的点坐标执行动画路径
- (void)translationAnimation
{
    // 1. 创建关键帧动画对象  初始化keyPath
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    // 2.设置关键帧, 有4个关键帧
    // 对于关键帧动画的初始值不能省略, 就是最少要有一个帧
    NSValue *key1 = [NSValue valueWithCGPoint:_layer.position];
    NSValue *key2 = [NSValue valueWithCGPoint:CGPointMake(80, 220)];
    NSValue *key3 = [NSValue valueWithCGPoint:CGPointMake(45, 300)];
    NSValue *key4 = [NSValue valueWithCGPoint:CGPointMake(55, 400)];
    
    // 通哟keyTimes数组来设置关键帧的运行时间
    keyAnimation.keyTimes = @[@(0.1), @(0.2), @(0.3), @(1.0)];
    
    NSArray *keys = @[key1, key2, key3, key4];
    // 设置关键帧
    keyAnimation.values = keys;
    // 3. 设置其他属性
    keyAnimation.duration = 5.0;
    keyAnimation.repeatCount = HUGE_VALF;
    keyAnimation.removedOnCompletion = NO; // 告诉在动画结束的时候不要移除视图
    
    // 设置动画的开始时间 延时两秒执行
    keyAnimation.beginTime = CACurrentMediaTime() + 2;
    
    // 4.给图层添加动画
    [_layer addAnimation:keyAnimation forKey:@"KCKeyframeAnimation_Position"];
    
}

#pragma mark ---- 关键帧动画 ----> 设置贝塞尔曲线作为动画执行的路径
- (void)translationKeyAnimation
{
    // 1. 创建关键帧动画
    CAKeyframeAnimation *keyAnimation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    
    
    [keyAnimation setValue:[NSValue valueWithCGPoint:CGPointMake(50, 614) ]forKey:@"LayerPosition"];
    
    // 2. 设置贝塞尔曲线路径
    CGMutablePathRef path = CGPathCreateMutable();
    // 设置易懂的起始点
    CGPathMoveToPoint(path, NULL, _layer.position.x, _layer.position.y);
    
    
    
    // 绘制二次贝塞尔曲线
    // 可以添加路径,
    CGPathAddCurveToPoint(path, NULL, 160, 280, -30, 300, 50, 400);
    CGPathAddCurveToPoint(path, NULL, 160, 500, -30, 600, 50, 614);
    // 给动画添加路径 设置路径属性
    keyAnimation.path = path;
    
    CGPathRelease(path);
    
    
    keyAnimation.calculationMode = kCAAnimationCubic;
    
    // 设置动画其他属性
    keyAnimation.duration = 15.0;
    keyAnimation.removedOnCompletion = NO;
    keyAnimation.repeatCount = 10000;
    keyAnimation.autoreverses = YES; //返回
    keyAnimation.delegate = self;
    
    // 给图层添加动画
    [_layer addAnimation:keyAnimation forKey:@"KCKeyAnimation_Positon"];
}
#pragma mark --- 动画的代理方法
- (void)animationDidStart:(CAAnimation *)anim
{
    
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    //  开启事务
    [CATransaction begin];
    
    // 关闭隐式动画属性
    [CATransaction setDisableActions:YES];
    
    _layer.position = [[anim valueForKey:@"LayerPosition"] CGPointValue];
    
    [CATransaction commit];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)dealloc
{
    [self.view removeGestureRecognizer:self.tapGesture];
    self.tapGesture = nil;
}



@end
