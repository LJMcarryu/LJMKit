//
//  JMFactory.h
//  SecreTalk_OC
//
//  Created by 刘佳明 on 2020/8/8.
//  Copyright © 2020 刘佳明. All rights reserved.
//  工厂类

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 自定义方法
@interface JMFactory : NSObject

/// 创建 label
/// @param text 文字
/// @param textColor 文字颜色
/// @param font 文字大小
/// @param textAlignment 文字位置
/// @param num 文字行数
+ (UILabel *)createLabelWithText:(NSString *)text
                       textColor:(UIColor *)textColor
                            font:(CGFloat)font
                   textAlignment:(NSTextAlignment)textAlignment
                   numberOfLines:(NSInteger)num;

/// 创建 button
/// @param title 文字
/// @param titleColor 文字颜色
/// @param font 文字大小
/// @param backgroundColor 背景颜色
+ (UIButton *)createButtonWithTitle:(NSString *)title
                         titleColor:(UIColor *)titleColor
                               font:(CGFloat)font
                    backgroundColor:(UIColor *)backgroundColor;
@end

NS_ASSUME_NONNULL_END
