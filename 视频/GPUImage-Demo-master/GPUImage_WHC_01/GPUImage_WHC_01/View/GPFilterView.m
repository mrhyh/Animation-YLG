//
//  GPFilterView.m
//  GPUImage_WHC_01
//
//  Created by hyh on 2017/7/25.
//  Copyright © 2017年 PicVision. All rights reserved.
//

#import "GPFilterView.h"

static const CGFloat GPFVImageWidth = 35;

#define GPFVImageToImageSpace  ((ScreenW - 5*GPFVImageWidth)/6.0)

@interface GPFilterView () <UIScrollViewDelegate>

@property (strong,nonatomic) UIScrollView *scrollView;

@end

@implementation GPFilterView



- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setup];
    }
    
    return self;
}

- (void)setup {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, ScreenH-100, ScreenW, 100)];
    _scrollView.contentSize = CGSizeMake(ScreenW, 100);
    _scrollView.contentSize =  CGSizeMake(GPFVImageWidth * 5,0);
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.pagingEnabled = YES;
    _scrollView.delegate = self;
    
    
    for (int i=0; i<6; i++) {
        UIView *view = [self createImageViewButtonWithX:((GPFVImageToImageSpace * 2 + GPFVImageWidth) * i) forIndex:i];
        view.tag = i;
        [_scrollView addSubview:view];
        
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(scrollViewItemClick:)];
        tapGesture.numberOfTapsRequired = 1;
        tapGesture.numberOfTouchesRequired = 1;
        [view addGestureRecognizer:tapGesture];
    }
}

- (UIView *)createImageViewButtonWithX:(CGFloat)x forIndex:(int)index {
    NSArray *imageNameArray = @[@"live_save",@"shareicon_wechat.png",@"wechatmoments.png",@"shareicon_qq.png",@"shareicon_qqzone.png",@"shareicon_weibo.png"];
    NSArray *nameArray = @[@"保存",@"微信好友",@"朋友圈",@"QQ好友",@"QQ空间",@"新浪微博"];
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(x, 0,(CGRectGetWidth(self.frame) - 2*GPFVImageToImageSpace)/4.0 , 100)];
    
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(GPFVImageToImageSpace, 15, GPFVImageWidth, GPFVImageWidth)];
    [imageView setImage:[UIImage imageNamed:imageNameArray[index]]];
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

    
//    if ([self.delegate respondsToSelector:@selector(tyliveShareView:selectShareIndex:)]) {
//        [self.delegate tyliveShareView:self selectShareIndex:view.tag];
//    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
