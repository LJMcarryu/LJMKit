//
//  LJMSkidSideCell.h
//  CodeArt
//
//  Created by ios on 2020/6/29.
//  Copyright © 2020 Jimmy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJMSkidSideContainerView.h"

NS_ASSUME_NONNULL_BEGIN

/**
   <#     提供多个侧滑扩展，以及二次确认按钮的cell       #>
*/
typedef NS_ENUM (NSInteger, LJMSkidSideCellActionStyle) {
    LJMSkidSideCellActionStyleDefault     = 0,
    LJMSkidSideCellActionStyleDestructive = LJMSkidSideCellActionStyleDefault, // 删除 红底
    LJMSkidSideCellActionStyleNormal // 正常 灰底
};

/**
   创建扩展按钮用的Action 需要在cell代理中返回
*/
@interface LJMSkidSideCellAction : NSObject

+ (instancetype)rowActionWithStyle:(LJMSkidSideCellActionStyle)style title:(nullable NSString *)title handler:(void (^)(LJMSkidSideCellAction *action, NSIndexPath *indexPath))handler;

@property (nonatomic, readonly) LJMSkidSideCellActionStyle style;
@property (nonatomic, copy, nullable) NSString *title; // 文字内容
@property (nonatomic, strong, nullable) UIImage *image; // 按钮图片 默认无图
@property (nonatomic) CGFloat fontSize; // 字体大小 默认17
@property (nonatomic, strong, nullable) UIColor *titleColor; // 文字颜色 默认白色
@property (nonatomic, copy, nullable) UIColor *backgroundColor; // 背景颜色 默认透明
@property (nonatomic) CGFloat margin; // 内容左右间距 默认15

@end

@class LJMSkidSideCell;
@protocol LJMSkidSideCellDelegate <NSObject>
@optional;

/**
 *  选中了侧滑按钮
 *
 *  @param skidSideCell 当前响应的cell
 *  @param indexPath    cell在tableView中的位置
 *  @param index        选中的是第几个action
 *  return 如果你想展示另一个View，那么返回他。如果返回nil，则会直接收起侧滑菜单
 *  需要注意如果你返回了一个View，那么整个侧滑容器将会对其进行适配(宽度)
 */
- (UIView *)skidSideCell:(LJMSkidSideCell *)skidSideCell rowAtIndexPath:(NSIndexPath *)indexPath didSelectedAtIndex:(NSInteger)index;

/**
 *  告知当前位置的cell是否需要侧滑按钮
 *
 *  @param skidSideCell 当前响应的cell
 *  @param indexPath    cell在tableView中的位置
 *
 *  @return YES 表示当前cell可以侧滑, NO 不可以
 */
- (BOOL)skidSideCell:(LJMSkidSideCell *)skidSideCell canSkidSideRowAtIndexPath:(NSIndexPath *)indexPath;

/**
 *  返回侧滑事件
 *
 *  @param skidSideCell 当前响应的cell
 *  @param indexPath    cell在tableView中的位置
 *
 *  @return 数组为空, 则没有侧滑事件
 */
- (nullable NSArray<LJMSkidSideCellAction *> *)skidSideCell:(LJMSkidSideCell *)skidSideCell editActionsForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@interface LJMSkidSideCell : UITableViewCell

/**
    代理
 */
@property (nonatomic, weak) id<LJMSkidSideCellDelegate> skidSideCellDelegate;

/**
 *  按钮容器
 */
@property (nonatomic, strong) LJMSkidSideContainerView *btnContainView;

/**
 *  隐藏所有侧滑按钮
 */
- (void)hiddenAllSkidSide;

/**
 隐藏当前cell的侧滑按钮
 */
- (void)hiddenSkidSide;

/**
 展示当前cell的侧滑按钮
 */
- (void)showSkidSide;

@end

@interface UITableView (LJMSkidSideCell)

/**
  隐藏所有cell的侧滑按钮
 */
- (void)hiddenAllSkidSide;
- (void)hiddenOtherSkidSide:(LJMSkidSideCell *)cell;

@end

NS_ASSUME_NONNULL_END
