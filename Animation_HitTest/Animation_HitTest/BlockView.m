//
//  BlockView.m
//  Animation_HitTest
//
//  Created by hyh on 2017/4/13.
//  Copyright © 2017年 hyh. All rights reserved.
//

#import "BlockView.h"

@interface BlockView()

@property (strong, nonatomic) CADisplayLink *displayLink;
@property (nonatomic) CGFloat from;
@property (nonatomic) CGFloat to;
@property (nonatomic) BOOL animating;

@end

@implementation BlockView

- (void)startAnimation
{
    if (self.displayLink == nil) {
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(tick:)];
        [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop]
                               forMode:NSDefaultRunLoopMode];
    }
    
    
    
}

- (void)completeAnimation
{
    self.animating = NO;
    [self.displayLink invalidate];
    self.displayLink = nil;
}


//在drawRect中，我们计算当前动画的progress，然后进行绘制。需要注意的是，我们需要通过self.layer.presentationLayer来获取动画过程中的位置信息。
- (void)drawRect:(CGRect)rect
{
    CALayer *layer =self.layer.presentationLayer;
    
    CGFloat progress = 1;
    if (!self.animating) {
        progress = 1;
    } else {
        progress = 1 - (layer.position.y - self.to) / (self.from - self.to);
    }
    
    CGFloat height = CGRectGetHeight(rect);
    CGFloat deltaHeight = height / 2 * (0.5 - fabs(progress - 0.5));
    NSLog(@"delta:%f", deltaHeight);
    
    CGPoint topLeft = CGPointMake(0, deltaHeight);
    CGPoint topRight = CGPointMake(CGRectGetWidth(rect), deltaHeight);
    CGPoint bottomLeft = CGPointMake(0, height);
    CGPoint bottomRight = CGPointMake(CGRectGetWidth(rect), height);
    
    UIBezierPath* path = [UIBezierPath bezierPath];
    [[UIColor blueColor] setFill];
    [path moveToPoint:topLeft];
    [path addQuadCurveToPoint:topRight controlPoint:CGPointMake(CGRectGetMidX(rect), 0)];
    [path addLineToPoint:bottomRight];
    [path addQuadCurveToPoint:bottomLeft controlPoint:CGPointMake(CGRectGetMidX(rect), height - deltaHeight)];
    [path closePath];
    [path fill];
}


- (void)startAnimationFrom:(CGFloat)from to:(CGFloat)to
{
    self.from = from;
    self.to = to;
    self.animating = YES;
    if (self.displayLink == nil) {
        self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(tick:)];
        
        [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop]
                               forMode:NSDefaultRunLoopMode];
    }
}

// 每个tick中，我们需要根据当前的位置重绘边缘，所以只需调用setNeedsDisplay即可：
- (void)tick:(CADisplayLink *)displayLink
{
    [self setNeedsDisplay];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
