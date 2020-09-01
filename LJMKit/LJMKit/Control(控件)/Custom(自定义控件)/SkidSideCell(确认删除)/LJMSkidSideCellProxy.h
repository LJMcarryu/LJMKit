//
//  LJMSkidSideCellProxy.h
//  CodeArt
//
//  Created by ios on 2020/6/29.
//  Copyright © 2020 Jimmy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

/**
   代理类 负责拦截 tableView 与其代理者的事件 关键作用是在有动作时收起扩展按钮
*/
@interface LJMSkidSideCellProxy : NSProxy <UITableViewDelegate, UIScrollViewDelegate, NSObject>

@property (nonatomic, weak) UITableView *target;

@end

NS_ASSUME_NONNULL_END
