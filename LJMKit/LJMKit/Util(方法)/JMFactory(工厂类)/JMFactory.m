//
//  JMFactory.m
//  SecreTalk_OC
//
//  Created by 刘佳明 on 2020/8/8.
//  Copyright © 2020 刘佳明. All rights reserved.
//

#import "JMFactory.h"

@implementation JMFactory

+ (UILabel *)createLabelWithText:(NSString *)text
                       textColor:(UIColor *)textColor
                            font:(CGFloat)font
                   textAlignment:(NSTextAlignment)textAlignment
                   numberOfLines:(NSInteger)num {
    UILabel *label = UILabel.alloc.init;
    label.text = text;
    label.textColor = textColor;
    label.font = [UIFont systemFontOfSize:font];
    label.textAlignment = textAlignment;
    label.numberOfLines = num;

    return label;
}

+ (UIButton *)createButtonWithTitle:(NSString *)title
                         titleColor:(UIColor *)titleColor
                               font:(CGFloat)font
                    backgroundColor:(UIColor *)backgroundColor {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:title forState:UIControlStateNormal];
    [button setTitleColor:titleColor forState:UIControlStateNormal];
    button.titleLabel.font = [UIFont systemFontOfSize:font];
    [button setBackgroundColor:backgroundColor];

    return button;
}

@end
