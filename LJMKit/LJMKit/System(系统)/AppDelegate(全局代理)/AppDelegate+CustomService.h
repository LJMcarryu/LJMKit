//
//  AppDelegate+CustomService.h
//  LJMKit
//
//  Created by ios on 2020/8/24.
//  Copyright © 2020 jimmy. All rights reserved.
//

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (CustomService)

/// 配置自定义配置
/// @param launchOptions launchOptions
- (void)configCustomServiceWithApplication:(UIApplication *)application launchOptions:(NSDictionary *)launchOptions;

@end

NS_ASSUME_NONNULL_END
