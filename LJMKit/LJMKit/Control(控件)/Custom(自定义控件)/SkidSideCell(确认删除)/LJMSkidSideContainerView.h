//
//  LJMSkidSideContainerView.h
//  CodeArt
//
//  Created by ios on 2020/6/29.
//  Copyright © 2020 Jimmy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LJMSkidSideCellAction;

NS_ASSUME_NONNULL_BEGIN

/**
    侧滑容器View
 */
@interface LJMSkidSideContainerView : UIView

/**
    总宽度
    不要修改这个东西，会引发布局错误
 */
@property (nonatomic, readonly) CGFloat totalWidth;

/**
    内部button数组。
    作用来讲，目前这里你可以比较方便的拿到甚至每个视图的信息。但如果要修改他们的frame，我没有做进一步变化的适配
 */
@property (nonatomic, readonly) NSArray<UIButton *> *subButtons;
@property (nonatomic, readonly) NSArray<UIView *> *originSubViews;
/**
     创建操作用View

     @param actions actions数组
     @return 操作用View
 */
- (instancetype)initWithActions:(NSArray<LJMSkidSideCellAction *> *)actions;

/**
    将View变回原有的长度
 */
- (void)restoration; //复原

/**
 将View以拉伸的方式形变到某个长度

 @param width 最终长度
 */
- (void)scaleToWidth:(CGFloat)width;

@end

NS_ASSUME_NONNULL_END
