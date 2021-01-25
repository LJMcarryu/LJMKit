//
//  XYMessageHUD.m
//  shiku_im
//
//  Created by ios on 2020/7/2.
//  Copyright © 2020 Jimmy. All rights reserved.
//

#import "XYMessageHUD.h"
#import "SVProgressHUD.h"

@implementation XYMessageHUD

/// 活动提示器 默认30秒 允许用户交互
+ (void)showHUD {
    [self setSVProgressHUD];
    [SVProgressHUD show];
    [SVProgressHUD dismissWithDelay:30];
}

/// 活动提示器 默认30秒 不允许用户交互
+ (void)showUnableHUD {
    [self setSVProgressHUD];
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear]; // 不允许用户交互
    [SVProgressHUD dismissWithDelay:30];
}

/// 活动提示器 默认30秒 允许用户交互(可选展示层)
+ (void)showHUDAtView:(UIView *)view {
    [self setSVProgressHUD];
    [SVProgressHUD setContainerView:view];
    [SVProgressHUD show];
    [SVProgressHUD dismissWithDelay:30];
}

/// 活动提示器 默认30秒 不允许用户交互(可选展示层)
+ (void)showUnableHUDAtView:(UIView *)view {
    [self setSVProgressHUD];
    [SVProgressHUD setContainerView:view];
    [SVProgressHUD show];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear];
    [SVProgressHUD dismissWithDelay:30];
}

/// 加载中...  默认30秒 允许用户交互
+ (void)showHUDWithDefaultStatus {
    [self setSVProgressHUD];
    [SVProgressHUD showWithStatus:@"加载中..."];
    [SVProgressHUD dismissWithDelay:30];
}

/// 加载中...  默认30秒 不允许用户交互
+ (void)showUnableHUDWithDefaultStatus {
    [self setSVProgressHUD];
    [SVProgressHUD showWithStatus:@"加载中..."];
    [SVProgressHUD setDefaultMaskType:SVProgressHUDMaskTypeClear]; // 不允许用户交互
    [SVProgressHUD dismissWithDelay:30];
}

/// 文字提醒 默认 2 秒
+ (void)showMessageWithStatus:(NSString *)message {
    [self setSVProgressHUD];
    [SVProgressHUD showImage:[UIImage imageNamed:@"notNull"] status:message];
    [SVProgressHUD dismissWithDelay:2];
}

/// 文字提醒 自定义显示时间
+ (void)showMessageWithStatus:(NSString *)message delay:(NSTimeInterval)time {
    [self setSVProgressHUD];
    [SVProgressHUD showImage:[UIImage imageNamed:@"notNull"] status:message];
    [SVProgressHUD dismissWithDelay:time];
}

/// 消失
+ (void)dismiss {
    [SVProgressHUD dismiss];
}

#pragma mark - 私有方法
// 配置 SVProgressHUD
+ (void)setSVProgressHUD {
    // 这一句是为了适配 有些是需要显示在 ContainerView 上
    [SVProgressHUD setContainerView:nil];
    [SVProgressHUD setBackgroundColor:[self colorInDifferentMode]];
    [SVProgressHUD setForegroundColor:kBackgroud_Color_Main];
    [SVProgressHUD setCornerRadius:22];
}

+ (UIColor *)colorInDifferentMode {
    if (@available(iOS 13.0, *)) {
        UIColor *color = [UIColor colorWithDynamicProvider:^UIColor *_Nonnull (UITraitCollection *_Nonnull traitCollection) {
            if ([traitCollection userInterfaceStyle] == UIUserInterfaceStyleLight) {
                return [UIColor colorWithRed:119 / 255 green:119 / 255 blue:119 / 255 alpha:0.7];
            }
            // TODO: fit 暗黑模式下 背景颜色
            return [UIColor colorWithRed:255 / 255 green:255 / 255 blue:255 / 255 alpha:0.7];
        }];
        return color;
    } else {
        return [UIColor colorWithRed:119 / 255 green:119 / 255 blue:119 / 255 alpha:0.7];
    }
}

@end
