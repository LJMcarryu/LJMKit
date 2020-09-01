//
//  AppDelegate+ThirdService.h
//  LJMKit
//
//  Created by ios on 2020/9/1.
//  Copyright © 2020 jimmy. All rights reserved.
//

#import "AppDelegate.h"

NS_ASSUME_NONNULL_BEGIN

@interface AppDelegate (ThirdService)

/// 配置三方配置
/// @param launchOptions launchOptions
- (void)configThirdServiceWithApplication:(UIApplication *)application launchOptions:(NSDictionary *)launchOptions;

@end

NS_ASSUME_NONNULL_END
