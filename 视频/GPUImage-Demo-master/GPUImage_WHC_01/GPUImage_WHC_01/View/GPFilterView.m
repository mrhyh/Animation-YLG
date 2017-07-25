//
//  GPFilterView.m
//  GPUImage_WHC_01
//
//  Created by hyh on 2017/7/25.
//  Copyright © 2017年 PicVision. All rights reserved.
//

#import "GPFilterView.h"
#import "GPUImageBeautifyFilter.h"

static const CGFloat GPFVImageWidth = 35;

#define GPFVImageToImageSpace  ((kScreenWidth - 5*GPFVImageWidth)/6.0)

@interface GPFilterView () <UIScrollViewDelegate>

@property (strong,nonatomic) UIScrollView *scrollView;

@end

@implementation GPFilterView



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self initData];
        [self setup];
    }
    
    return self;
}

- (void) initData {
    //哈哈镜效果
    GPUImageStretchDistortionFilter *stretchDistortionFilter = [[GPUImageStretchDistortionFilter alloc] init];
    
    //亮度
    GPUImageBrightnessFilter *BrightnessFilter = [[GPUImageBrightnessFilter alloc] init];
    
    //伽马线滤镜
    GPUImageGammaFilter *gammaFilter = [[GPUImageGammaFilter alloc] init];
    
    //边缘检测
    GPUImageXYDerivativeFilter *XYDerivativeFilter = [[GPUImageXYDerivativeFilter alloc] init];
    
    //怀旧
    GPUImageSepiaFilter *sepiaFilter = [[GPUImageSepiaFilter alloc] init];
    
    //反色
    GPUImageColorInvertFilter *invertFilter = [[GPUImageColorInvertFilter alloc] init];
    
    //饱和度
    GPUImageSaturationFilter *saturationFilter = [[GPUImageSaturationFilter alloc] init];
    
    //美颜
    GPUImageBeautifyFilter *beautyFielter = [[GPUImageBeautifyFilter alloc] init];
    
    //初始化滤镜数组
    self.filterArr = @[stretchDistortionFilter,BrightnessFilter,gammaFilter,XYDerivativeFilter,sepiaFilter,invertFilter,saturationFilter,beautyFielter];
}

- (void)setup {
    
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 100)];
    _scrollView.contentSize =  CGSizeMake(GPFVImageWidth * 11 + GPFVImageToImageSpace * 12,0);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    [self addSubview:_scrollView];
    
    for (int i=0; i<11; i++) {
        UIView *view = [self createImageViewButtonWithX:((GPFVImageToImageSpace + GPFVImageWidth) * i) forIndex:i];
        view.tag = i;
        [_scrollView addSubview:view];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewItemClick:)];
        tapGesture.numberOfTapsRequired = 1;
        tapGesture.numberOfTouchesRequired = 1;
        [view addGestureRecognizer:tapGesture];
    }

}

- (UIView *)createImageViewButtonWithX:(CGFloat)x forIndex:(int)index {
    NSArray *imageNameArray = @[@"img1.jpg",@"img1.jpg",@"img1.jpg",@"img1.jpg",@"img1.jpg",@"img1.jpg",@"img1.jpg",@"img1.jpg",@"img1.jpg",@"img1.jpg",@"img1.jpg",@"img1.jpg",@"img1.jpg"];
    NSArray *nameArray = @[@"哈哈镜",@"亮度",@"伽马线",@"边缘检测",@"怀旧",@"反色",@"饱和度",@"美颜",@"新浪微博",@"新浪微博",@"新浪微博",@"新浪微博",@"新浪微博"];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x, 0,(CGRectGetWidth(self.frame) - 2*GPFVImageToImageSpace)/4.0 , 100)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(GPFVImageToImageSpace, 15, GPFVImageWidth, GPFVImageWidth)];
    [imageView setImage:[UIImage imageNamed:imageNameArray[index]]];
    imageView.layer.cornerRadius = GPFVImageWidth/2.0;
    imageView.layer.masksToBounds = YES;
    [view addSubview:imageView];
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(GPFVImageToImageSpace/3.0, CGRectGetMaxY(imageView.frame) + 10, CGRectGetWidth(view.frame) - 2 * GPFVImageToImageSpace/3, 20)];
    label.font = [UIFont systemFontOfSize:11.0];
    label.text = nameArray[index];
    label.textColor = RGBColor(68, 68, 68);
    label.textAlignment = NSTextAlignmentCenter;
    [view addSubview:label];
    
    return view;
}


- (void)scrollViewItemClick:(UITapGestureRecognizer *)recognizer {
    UIView *view = recognizer.view;
    NSLog(@"点击的View的Tag是：%ld",(long)view.tag);

    if ([self.delegate respondsToSelector:@selector(filterViewImageClickWithIndex:)]) {
        [self.delegate filterViewImageClickWithIndex:view.tag];
    }
}


@end
