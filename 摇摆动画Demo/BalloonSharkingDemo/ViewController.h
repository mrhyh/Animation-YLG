//
//  ViewController.h
//  BalloonSharkingDemo
//
//  Created by 张培川 on 13-12-17.
//  Copyright (c) 2013年 张培川. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@interface ViewController : UIViewController
{
    
    UIButton                   *btn;
    
    
    CALayer                   *ballLayer;;//摇动的气球
    UIImageView               *imageView;
    UIImageView               *imageView2;
    float                     angle;
    float                     timeInter;
    
    
    float                     angle2;
    float                     timeInter2;
    
}
@end
