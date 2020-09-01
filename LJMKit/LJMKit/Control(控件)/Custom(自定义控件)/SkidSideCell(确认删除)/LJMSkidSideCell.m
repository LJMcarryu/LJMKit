//
//  LJMSkidSideCell.m
//  CodeArt
//
//  Created by ios on 2020/6/29.
//  Copyright © 2020 Jimmy. All rights reserved.
//

#import "LJMSkidSideCell.h"
#import "LJMSkidSideCellProxy.h"
#import "LJMSkidSideContainerView.h"

#import <objc/runtime.h>

CGFloat LJM_getX(UIView *v)
{
    return v.frame.origin.x;
}

CGFloat LJM_getW(UIView *v)
{
    return v.frame.size.width;
}

void LJM_setX(UIView *v, CGFloat x)
{
    CGRect frame = v.frame;
    frame.origin.x = x;
    v.frame = frame;
}

void LJM_setW(UIView *v, CGFloat w)
{
    CGRect frame = v.frame;
    frame.size.width = w;
    v.frame = frame;
}

//            <#     一些私有属性的扩展      #>
@interface UITableView ()
@property (nonatomic) LJMSkidSideCellProxy *skidSideCellProxy;
@property (nonatomic) BOOL skidSide;
@end

@interface LJMSkidSideContainerView ()
@property (nonatomic, weak) id targetCell;
@end

@interface LJMSkidSideCellAction ()
@property (nonatomic, copy) void (^ handler)(LJMSkidSideCellAction *action, NSIndexPath *indexPath);
@property (nonatomic, assign) LJMSkidSideCellActionStyle style;

@end

@implementation LJMSkidSideCellAction

+ (instancetype)rowActionWithStyle:(LJMSkidSideCellActionStyle)style title:(NSString *)title handler:(void (^)(LJMSkidSideCellAction *action, NSIndexPath *indexPath))handler {
    LJMSkidSideCellAction *action = [LJMSkidSideCellAction new];
    action.title = title;
    action.handler = handler;
    action.style = style;
    action.fontSize = 17;
    action.titleColor = [UIColor whiteColor];
    switch (style) {
        case LJMSkidSideCellActionStyleDefault: {
            action.backgroundColor = [UIColor redColor];
        }
        break;
        case LJMSkidSideCellActionStyleNormal: {
            action.backgroundColor = [UIColor colorWithRed:200 / 255.0 green:199 / 255.0 blue:205 / 255.0 alpha:1];
        }
        break;

        default:
            break;
    }

    return action;
}

- (CGFloat)margin {
    return _margin == 0 ? 15 : _margin;
}

@end

typedef NS_ENUM (NSInteger, LJMSkidSideCellState) {
    LJMSkidSideCellStateNormal,
    LJMSkidSideCellStateAnimating,
    LJMSkidSideCellStateOpen
};

@interface LJMSkidSideCell () <UIGestureRecognizerDelegate>

@property (nonatomic) BOOL skidSide; // 当前cell的侧滑是否被展示中
@property (nonatomic) LJMSkidSideCellState state; // 当前cell的状态
@property (nonatomic) UIView *nextShowView; // 点击侧滑按钮后，若有需要持有用户返回的新View
@property (nonatomic) NSArray <LJMSkidSideCellAction *> *actions;

@end

@implementation LJMSkidSideCell

#pragma mark - Life Cycle
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupSkidSideCell];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self setupSkidSideCell];
    }
    return self;
}

- (void)dealloc {
    [self.contentView removeObserver:self forKeyPath:@"frame"];
}

- (void)setupSkidSideCell {
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(contentViewPan:)];
    panGesture.delegate = self;
    [self.contentView addGestureRecognizer:panGesture];
    self.contentView.backgroundColor = [UIColor whiteColor];

    [self.contentView addObserver:self forKeyPath:@"frame" options:NSKeyValueObservingOptionNew context:nil];
}

/***
 关于Bug1 的说明
 bug位置在下方#waring Bug1

 这里，存在一个我没能解决的bug。如果不通过监听self.contentView.frame的方式让btnContainView进行跟随。
 而是在手势中，与self.contentView.frame同步进行修改，会导致系统
 [UITableViewCellLayoutManager layoutSubviewsOfCell:]
 将self.contentView的x修改为0。你可以在kvo中当x被修改为0尝试打印堆栈

 如果有您有了新的进展，还望不吝赐教
 */

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey, id> *)change context:(void *)context  {
    if ([keyPath isEqualToString:@"frame"]) {
        if (self.btnContainView) {
            LJM_setX(self.btnContainView, self.contentView.frame.size.width + self.contentView.frame.origin.x);
        }
    }
}

- (void)layoutSubviews {
    CGFloat x = 0;
    if (_skidSide) x = self.contentView.frame.origin.x;

    [super layoutSubviews];

    // 侧滑状态旋转屏幕时, 保持侧滑
    if (_skidSide) LJM_setX(self.contentView, x);
    LJM_setW(self.contentView, LJM_getW(self));
}

- (void)prepareForReuse {
    [super prepareForReuse];
    if (_skidSide) [self hiddenSkidSideNoAnimation];
}

#pragma mark - UIGestureRecognizerDelegate
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        if ([gestureRecognizer.view.superview isKindOfClass:[LJMSkidSideCell class]]) {
            LJMSkidSideCell *cell = (LJMSkidSideCell *)gestureRecognizer.view.superview;
            //如果当前的cell，不是已经展示的cell
            if (!cell.skidSide) {
                [self hiddenAllSkidSide];
            } else {
                // 否则是二次滑动
                // 这里二次滑动 在非确认删除 需要重新赋予子视图 不返回 YES
                if (!_nextShowView) {
                    return YES;
                }
            }
        }

        UIPanGestureRecognizer *gesture = (UIPanGestureRecognizer *)gestureRecognizer;
        CGPoint translation = [gesture translationInView:gesture.view];

        // 如果手势相对于水平方向的角度大于45°, 则不触发侧滑
        BOOL shouldBegin = fabs(translation.y) <= fabs(translation.x);
        if (!shouldBegin) return NO;

        // 询问代理是否需要侧滑
        if ([_skidSideCellDelegate respondsToSelector:@selector(skidSideCell:canSkidSideRowAtIndexPath:)]) {
            shouldBegin = [_skidSideCellDelegate skidSideCell:self canSkidSideRowAtIndexPath:self.indexPath] || _skidSide;
        }

        if (shouldBegin) {
            // 向代理获取侧滑展示内容数组
            if ([_skidSideCellDelegate respondsToSelector:@selector(skidSideCell:editActionsForRowAtIndexPath:)]) {
                NSArray <LJMSkidSideCellAction *> *actions = [_skidSideCellDelegate skidSideCell:self editActionsForRowAtIndexPath:self.indexPath];
                if (!actions || actions.count == 0) return NO;
                [self setActions:actions];
            } else {
                return NO;
            }
        }
        return shouldBegin;
    }
    return NO;
}

#pragma mark - Response Events

- (void)contentViewPan:(UIPanGestureRecognizer *)pan {
    CGPoint point = [pan translationInView:pan.view];
    UIGestureRecognizerState state = pan.state;
    [pan setTranslation:CGPointZero inView:pan.view];

    if (_nextShowView) {
        [_nextShowView removeFromSuperview];
        _nextShowView = nil;
        //这里防止有手贱党，在0.2s动画执行完之前又开始滑动
        [_btnContainView.subButtons setValue:@(NO) forKeyPath:@"hidden"];
    }

    if (state == UIGestureRecognizerStateChanged) {
        CGRect frame = self.contentView.frame;
        CGRect cframe = self.btnContainView.frame;

        if (frame.origin.x + point.x <= -(self.btnContainView.totalWidth)) {
            //超过最大距离，加阻尼
            CGFloat hindrance = (point.x / 5);
            if (frame.origin.x + hindrance <= -(self.btnContainView.totalWidth)) {
                frame.origin.x += hindrance;
                cframe.size.width += -hindrance;
                cframe.origin.x += hindrance;
            } else {
                //这里修复了一个当滑动过快时，导致最初减速时闪动的bug
                frame.origin.x = -self.btnContainView.totalWidth;
                cframe.origin.x = self.contentView.frame.size.width - self.btnContainView.totalWidth;
            }
        } else {
            //未到最大距离，正常拖拽
            frame.origin.x += point.x;
            cframe.origin.x += point.x;
        }

        //不允许右滑--原版这里右滑的话有一个回弹小动画，但我感觉浪费用户时间，并且微信也没有。
        if (frame.origin.x > 0) {
            frame.origin.x = 0;
        }
        self.contentView.frame = frame;

        //TODO: Bug1: 详见上方Bug1的说明
//        self.btnContainView.frame = cframe;
        [self.btnContainView scaleToWidth:-frame.origin.x];
    } else if (state == UIGestureRecognizerStateEnded) {
        CGPoint velocity = [pan velocityInView:pan.view];
        if (self.contentView.frame.origin.x == 0) {
            self.state = LJMSkidSideCellStateNormal;
            return;
        } else if (self.contentView.frame.origin.x > 5) {
            [self hiddenWithBounceAnimation];
        } else if (fabs(self.contentView.frame.origin.x) >= 40 && velocity.x <= 0) {
            [self showSkidSide];
        } else {
            [self hiddenSkidSide];
        }
    } else if (state == UIGestureRecognizerStateCancelled) {
        [self hiddenAllSkidSide];
    }
}

- (void)actionBtnDidClicked:(UIButton *)btn {
    if (_nextShowView) {
        [_nextShowView removeFromSuperview];
        _nextShowView = nil;
    }

    if ([self.skidSideCellDelegate respondsToSelector:@selector(skidSideCell:rowAtIndexPath:didSelectedAtIndex:)]) {
        _nextShowView = [self.skidSideCellDelegate skidSideCell:self rowAtIndexPath:self.indexPath didSelectedAtIndex:btn.tag];

        /**
            如果有需要继续展示的View--一般是确认删除?
            这里会将其覆盖到侧滑容器上，并且重新以新的View作为基础进行布局
         */
        if (_nextShowView) {
            [_btnContainView addSubview:_nextShowView];
            CGRect frame = CGRectMake(0, 0, _nextShowView.frame.size.width, self.contentView.frame.size.height);

            _nextShowView.frame = CGRectMake(self.btnContainView.originSubViews.lastObject.frame.origin.x, 0, _nextShowView.frame.size.width, self.contentView.frame.size.height);
            _nextShowView.hidden = YES;

            [UIView animateWithDuration:0.7 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseIn | UIViewAnimationOptionAllowUserInteraction animations:^{
                self->_nextShowView.frame = frame;
                self->_btnContainView.frame = frame;
                self->_nextShowView.hidden = NO;
                [self->_btnContainView.subButtons setValue:@(YES) forKeyPath:@"hidden"];
                LJM_setX(self.contentView, -LJM_getW(self->_nextShowView));
                [self.btnContainView scaleToWidth:self->_nextShowView.frame.size.width];
            } completion:^(BOOL finished) {
                [self->_btnContainView.subButtons setValue:@(NO) forKeyPath:@"hidden"];
            }];
        }
    }

    if (btn.tag < _actions.count) {
        LJMSkidSideCellAction *action = _actions[btn.tag];
        if (action.handler) action.handler(action, self.indexPath);
    }
    [self hiddenOtherSkidSide];
}

#pragma mark - Methods
- (void)hiddenWithBounceAnimation {
    self.state = LJMSkidSideCellStateAnimating;
    [UIView animateWithDuration:0.25 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        LJM_setX(self.contentView, -10);
    } completion:^(BOOL finished) {
        [self hiddenSkidSide];
    }];
}

- (void)hiddenOtherSkidSide {
    [self.tableView hiddenOtherSkidSide:self];
}

- (void)hiddenAllSkidSide {
    [self.tableView hiddenAllSkidSide];
}

- (void)hiddenSkidSide {
    if (self.contentView.frame.origin.x == 0) return;
    self.skidSide = NO;
    self.state = LJMSkidSideCellStateAnimating;

    [UIView animateWithDuration:0.2 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        LJM_setX(self.contentView, 0);
    } completion:^(BOOL finished) {
        [self->_btnContainView removeFromSuperview];
        self->_btnContainView = nil;
        self.state = LJMSkidSideCellStateNormal;
    }];
}

- (void)hiddenSkidSideNoAnimation {
    if (self.contentView.frame.origin.x == 0) return;
    self.skidSide = NO;
    self.state = LJMSkidSideCellStateAnimating;
    LJM_setX(self.contentView, 0);
    [_btnContainView removeFromSuperview];
    _btnContainView = nil;
    self.state = LJMSkidSideCellStateNormal;
}

- (void)showSkidSide {
    //尝试添加拦截器
    [self tryBindProxy];

    //修改cell以及tableView为侧滑按钮展示状态
    self.skidSide = YES;
    self.tableView.skidSide = YES;
    self.state = LJMSkidSideCellStateAnimating;

    [UIView animateWithDuration:0.7 delay:0 usingSpringWithDamping:0.7 initialSpringVelocity:1 options:UIViewAnimationOptionCurveEaseInOut | UIViewAnimationOptionAllowUserInteraction animations:^{
        LJM_setX(self.contentView, -self.btnContainView.totalWidth);
        [self.btnContainView restoration];
    } completion:^(BOOL finished) {
        self.state = LJMSkidSideCellStateOpen;
    }];
}

//尝试绑定proxy进行滚动的代理拦截
- (void)tryBindProxy {
    UITableView *tableView = [self tableView];
    if ([tableView isKindOfClass:[UITableView class]]) {
        if (![tableView.delegate isKindOfClass:[LJMSkidSideCellProxy class]]) {
            //保证一个tableView只会设置一次proxy
            LJMSkidSideCellProxy *proxy = [LJMSkidSideCellProxy alloc];
            proxy.target = tableView; //这里。proxy的target是weak属性，并不会造成循环引用
        }
    }
}

#pragma mark - Setter

- (void)setState:(LJMSkidSideCellState)state {
    _state = state;

    switch (state) {
        case LJMSkidSideCellStateNormal: {
            //这里可以防止循环引用VC，前提cell已经恢复默认状态。
            _actions = nil;
        }
        break;

        default:
            break;
    }
}

- (void)setActions:(NSArray <LJMSkidSideCellAction *> *)actions {
    _actions = actions;

    if (_btnContainView) {
        [_btnContainView removeFromSuperview];
        _btnContainView = nil;
    }

    _btnContainView = [[LJMSkidSideContainerView alloc]initWithActions:actions];
    _btnContainView.frame = CGRectMake(self.contentView.frame.size.width, 0, _btnContainView.frame.size.width, self.contentView.frame.size.height);
    _btnContainView.targetCell = self;
    [self insertSubview:_btnContainView belowSubview:self.contentView];
}

#pragma mark - Getter
- (UITableView *)tableView {
    id view = self.superview;
    while (view && [view isKindOfClass:[UITableView class]] == NO)
        view = [view superview];
    if ([view isKindOfClass:[UITableView class]]) {
        return view;
    } else {
        return nil;
    }
}

- (NSIndexPath *)indexPath {
    return [self.tableView indexPathForCell:self];
}

@end

@implementation UITableView (LJMSkidSideCell)
#pragma mark - 隐藏扩展按钮

- (void)hiddenOtherSkidSide:(LJMSkidSideCell *)cell {
    self.skidSide = NO;
    for (LJMSkidSideCell *c in self.visibleCells) {
        if (c == cell) {
            self.skidSide = YES;
        } else if ([c isKindOfClass:LJMSkidSideCell.class] && c.skidSide) {
            [c hiddenSkidSide];
        }
    }
}

- (void)hiddenAllSkidSide {
    self.skidSide = NO;
    for (LJMSkidSideCell *cell in self.visibleCells) {
        if ([cell isKindOfClass:LJMSkidSideCell.class] && cell.skidSide) {
            [cell hiddenSkidSide];
        }
    }
}

- (void)setSkidSideCellProxy:(LJMSkidSideCellProxy *)skidSideCellProxy {
    objc_setAssociatedObject(self, @selector(skidSideCellProxy), skidSideCellProxy, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (LJMSkidSideCellProxy *)skidSideCellProxy {
    return objc_getAssociatedObject(self, _cmd);
}

- (void)setSkidSide:(BOOL)skidSide {
    objc_setAssociatedObject(self, @selector(skidSide), [NSNumber numberWithBool:skidSide], OBJC_ASSOCIATION_ASSIGN);
}

- (BOOL)skidSide {
    return [objc_getAssociatedObject(self, _cmd) boolValue];
}

@end
