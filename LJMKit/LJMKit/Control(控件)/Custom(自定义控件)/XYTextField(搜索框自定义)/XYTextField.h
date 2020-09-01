//
//  XYTextField.h
//  shiku_im
//
//  Created by ios on 2020/7/3.
//  Copyright © 2020 Jimmy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

typedef void (^DidClickBlock)(void);

@interface XYTextField : UITextField

/// 居中的文字信息
@property (nonatomic, copy) NSString *placeholderString;
/// 是否可以输入 NO: 点击跳转页面 YES: placeholderString 消失 进入搜索
@property (nonatomic) BOOL editEnabled;
/// editEnabled == NO 回调跳转新页面
@property (nonatomic, copy) DidClickBlock didClickBlock;

@end

NS_ASSUME_NONNULL_END
