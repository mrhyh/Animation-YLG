//
//  Header.h
//  GPUImage_WHC_01
//
//  Created by hyh on 2017/7/25.
//  Copyright © 2017年 PicVision. All rights reserved.
//

#ifndef Header_h
#define Header_h


#endif /* Header_h */

//尺寸常量
#define kScreenWidth        ([UIScreen mainScreen].bounds.size.width)
#define kScreenHeight       ([UIScreen mainScreen].bounds.size.height)
#define kSeparateLineHeight (1.f/[UIScreen mainScreen].scale)

#define kDeviceSysVersion ([[UIDevice currentDevice].systemVersion floatValue])

#define isiPhone5  ([UIScreen mainScreen].bounds.size.width == 320)

#define kIsLandscape    (UIInterfaceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation))

static const float kNavHeight=44.0;
static const float kTabHeight=49.0;
static const float kStatusHeight=20.0;
static const int KTextnumber = 140;
static const int KLeftbarWidth = 60;//论坛入口侧边栏宽度

//宏定义
#define _Use_BaiduMobStat_
#define NotificationCenter [NSNotificationCenter defaultCenter]

typedef void (^BlockVoid)(void);

#define kShowSetRedDotKey   @"showSetTip"
#define kShowRecentVisitRedDotKey  @"showRecentVisitTip"
#define kShowOfflineDownloadDotKey @"kShowOfflineDownloadDotKey"


#define WIDTH_IPHONE_4 480
#define iPhone5  ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)
#define iPhone4S ([[UIScreen mainScreen] bounds].size.height == WIDTH_IPHONE_4)

#define iPhonePlus ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(1242,2208), [[UIScreen mainScreen] currentMode].size) : NO)

#define FrameFloat(w)    (iPhone4S?w* 0.64:(iPhone5 ? w* 0.85: (iPhonePlus ? w*1.1:w)))
#define FrameSizeMake(w,h)  CGSizeMake(FrameFloat(w),FrameFloat(h))

/*!
 *  将前一个参数转为__weak类型的指针，第二个参数就是__weak型的
 */
#define TYWeakify(src, tgt) __weak __typeof(src) tgt = src

#define RGBAColor(r, g, b, a) [UIColor colorWithRed:((r)/255.0f) green:((g)/255.0f) blue:((b)/255.0f) alpha:(a)]
#define RGBColor(r, g, b) RGBAColor((r), (g), (b), 1.0f)

//通知常量
static NSString* const KNotificationUserLogin=@"KNotificationUserLogin"; //用户登录成功的通知
