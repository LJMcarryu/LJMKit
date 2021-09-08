//
//  AppDelegate+CustomService.m
//  LJMKit
//
//  Created by ios on 2020/8/24.
//  Copyright © 2020 jimmy. All rights reserved.
//

#import "AppDelegate+CustomService.h"
#import "LJMTabBarViewController.h"

@implementation AppDelegate (CustomService)

/// 配置自定义配置
/// @param launchOptions launchOptions
- (void)configCustomServiceWithApplication:(UIApplication *)application launchOptions:(NSDictionary *)launchOptions {
    // DDLog 配置
    [self  DDLogToFile];
    // 骨架图配置
    [self TABAnimated];
    // rootViewController
    [self setRootViewController];
    // 数据库配置
    [self setFMDB];
    // 网络配置
    [self setServer];
}

#pragma mark - 将nslog的输出信息写入到.log文件中
- (void)DDLogToFile {
    [DDLog addLogger:[DDOSLogger sharedInstance] withLevel:ddLogLevel];
//    DDFileLogger *fileLogger = [[DDFileLogger alloc] init];
//    fileLogger.rollingFrequency = 60 * 60; // 刷新频率为1小时
//    fileLogger.logFileManager.maximumNumberOfLogFiles = 7; // 最大文件数量为7个
//    [DDLog addLogger:fileLogger];
}

#pragma mark - TABAnimated
- (void)TABAnimated {
    [[TABAnimated sharedAnimated] initWithShimmerAnimated];
    [TABAnimated sharedAnimated].openLog = YES;
}

#pragma mark - rootViewController

- (void)setRootViewController {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = kBackgroud_Color_Main;
    LJMTabBarViewController *tabBarController = LJMTabBarViewController.alloc.init;
//    tabBarController.delegate = self;
    self.window.rootViewController = tabBarController;
    [self.window makeKeyAndVisible];
}

#pragma mark - FMDB

- (void)setFMDB {
    bg_setSqliteName(@"10001");
    NSString *dbPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    JMSLogInfo(@"数据库路径: %@/", dbPath);
}

#pragma mark - 网络设置

- (void)setServer {
    YTKNetworkConfig *config = [YTKNetworkConfig sharedConfig];
    config.baseUrl = @"http://v.juhe.cn";
    config.cdnUrl = @"";
}

@end
