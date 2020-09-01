//
//  XYVerifyCodeView.h
//  shiku_im
//
//  Created by ios on 2020/7/2.
//  Copyright © 2020 Jimmy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^VerifyCodeBlack)(NSString *code);

@interface XYVerifyCodeView : UIView

@property (nonatomic, copy) VerifyCodeBlack verifyCodeBlack;

- (instancetype)initWithCount:(NSInteger)count margin:(CGFloat)margin;

- (void)cleanCode;

@end

NS_ASSUME_NONNULL_END
