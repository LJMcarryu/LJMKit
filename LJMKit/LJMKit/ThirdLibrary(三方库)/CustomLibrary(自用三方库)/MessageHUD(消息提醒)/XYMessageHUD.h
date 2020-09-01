//
//  XYMessageHUD.h
//  shiku_im
//
//  Created by ios on 2020/7/2.
//  Copyright © 2020 Jimmy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface XYMessageHUD : NSObject

/// 活动提示器 默认30秒 允许用户交互
+ (void)showHUD;
/// 活动提示器 默认30秒 不允许用户交互
+ (void)showUnableHUD;

/// 加载中...  默认30秒 允许用户交互
+ (void)showHUDWithDefaultStatus;

/// 加载中...  默认30秒 不允许用户交互
+ (void)showUnableHUDWithDefaultStatus;

/// 文字提醒 默认 2 秒
+ (void)showMessageWithStatus:(NSString *)message;
/// 文字提醒 自定义显示时间
+ (void)showMessageWithStatus:(NSString *)message delay:(NSTimeInterval)time;

/// 活动提示器 默认30秒 允许用户交互(可选展示层)
+ (void)showHUDAtView:(UIView *)view;

/// 活动提示器 默认30秒 不允许用户交互(可选展示层)
+ (void)showUnableHUDAtView:(UIView *)view;

/// 消失
+ (void)dismiss;

@end

NS_ASSUME_NONNULL_END
