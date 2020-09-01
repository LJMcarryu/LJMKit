//
//  LJMSkidSideCellProxy.m
//  CodeArt
//
//  Created by ios on 2020/6/29.
//  Copyright © 2020 Jimmy. All rights reserved.
//

#import "LJMSkidSideCellProxy.h"
#import "LJMSkidSideCell.h"

@interface UITableView ()

@property (nonatomic) BOOL skidSide;
@property (nonatomic) LJMSkidSideCellProxy *skidSideCellProxy;

@end

@interface LJMSkidSideCell () <UIGestureRecognizerDelegate>

@property (nonatomic) BOOL skidSide;

@end

@interface LJMSkidSideCellProxy ()

@property (nonatomic, weak) id<UIScrollViewDelegate, UITableViewDelegate> tableDelegate;
@property (nonatomic, weak) id<UITableViewDataSource> tableDataSource;

@end

@implementation LJMSkidSideCellProxy

- (BOOL)respondsToSelector:(SEL)aSelector {
    if (aSelector == @selector(scrollViewWillBeginDragging:) || aSelector == @selector(tableView:didSelectRowAtIndexPath:)) {
        return YES;
    }
    BOOL res = [self.tableDelegate respondsToSelector:aSelector] || [self.tableDataSource respondsToSelector:aSelector];
    return res;
}

- (BOOL)isKindOfClass:(Class)aClass {
    if ([NSStringFromClass(aClass) isEqualToString:@"LJMSkidSideCellProxy"]) {
        return YES;
    } else {
        return NO;
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView {
    if (self.target.skidSide) {
        [self.target hiddenAllSkidSide];
    }

    if ([self.tableDelegate respondsToSelector:@selector(scrollViewWillBeginDragging:)]) {
        [self.tableDelegate scrollViewWillBeginDragging:scrollView];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (self.target.skidSide) {
        // 点击直接 响应 didSelectRowAtIndexPath 方法 也可以直接 return
        [self.target hiddenAllSkidSide];
    }

    if ([self.tableDelegate respondsToSelector:@selector(tableView:didSelectRowAtIndexPath:)]) {
        [self.tableDelegate tableView:tableView didSelectRowAtIndexPath:indexPath];
    }
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    id res;
    if ([self.tableDelegate respondsToSelector:aSelector]) {
        res = self.tableDelegate;
    } else if ([self.tableDataSource respondsToSelector:aSelector]) {
        res = self.tableDataSource;
    }
    return res;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return nil;
}

- (void)setTarget:(UITableView *)target {
    _target = target;
    target.skidSideCellProxy = self; //这里需要让tableView强引用proxy防止释放
    self.tableDelegate = target.delegate; //保存tableView原本的delegate，进行转发
    self.tableDataSource = target.dataSource;//保存tableView原本的dataSource，进行转发
    target.delegate = self; //修改tableView.delegate拦截事件
}

@end
