//
//  GPBaseView.m
//  GPUImage_WHC_01
//
//  Created by hyh on 2017/7/25.
//  Copyright © 2017年 PicVision. All rights reserved.
//

#import "GPBaseView.h"

@implementation GPBaseView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        [self setup];
    }
    
    return self;
}

- (void)awakeFromNib
{
    // must call super method
    [super awakeFromNib];
    
    [self setup];
}

- (void)setup {
    
}

+ (instancetype)viewFromXib
{
    UINib *nibFile = [UINib nibWithNibName:NSStringFromClass([self class]) bundle:nil];
    NSArray *instances = [nibFile instantiateWithOwner:nil options:nil];
    
    for (id instance in instances) {
        if ([instance isMemberOfClass:[self class]]) {
            return instance;
        }
    }
    
    return nil;
}

@end
