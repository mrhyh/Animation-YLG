//
//  FWBookShelfDecarationViewCollectionReusableView.m
//  FWPersonalApp
//
//  Created by hzkmn on 16/2/18.
//  Copyright © 2016年 ForrstWoo. All rights reserved.
//



#import "FWBookShelfDecarationView.h"
#import "FWDataManager.h"
#import "Web_API.h"

#define screenSize [UIScreen mainScreen].bounds.size

//width and height for bookshelf cell
#define kCellWidth 100
#define kCellHeight 150

NSInteger const kDecorationViewHeight = 216;

@implementation FWBookShelfDecarationView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, screenSize.width, kDecorationViewHeight)];
        img.image = [UIImage imageNamed:@"boolshelf.png"];
        [self addSubview:img];
    }
    
    return self;
}
@end
