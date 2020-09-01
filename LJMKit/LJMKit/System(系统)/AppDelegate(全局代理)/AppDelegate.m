//
//  AppDelegate.m
//  LJMKit
//
//  Created by ios on 2020/8/24.
//  Copyright © 2020 jimmy. All rights reserved.
//

#import "AppDelegate.h"
#import "AppDelegate+CustomService.h"
#import "AppDelegate+ThirdService.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    /// 配置自定义配置
    [self configCustomServiceWithApplication:application launchOptions:launchOptions];
    /// 配置三方配置
    [self configThirdServiceWithApplication:application launchOptions:launchOptions];
    return YES;
}

@end
