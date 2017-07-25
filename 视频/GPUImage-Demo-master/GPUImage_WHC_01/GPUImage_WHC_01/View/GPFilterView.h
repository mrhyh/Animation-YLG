//
//  GPFilterView.h
//  GPUImage_WHC_01
//
//  Created by hyh on 2017/7/25.
//  Copyright © 2017年 PicVision. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Header.h"
#import "GPBaseView.h"

@protocol GPFilterViewDelegate <NSObject>

- (void)filterViewImageClickWithIndex:(NSInteger)selectIndex;

@end

@interface GPFilterView : GPBaseView

@property (nonatomic, weak)   id <GPFilterViewDelegate> delegate;

@property (nonatomic, strong) NSArray *filterArr;
@end
