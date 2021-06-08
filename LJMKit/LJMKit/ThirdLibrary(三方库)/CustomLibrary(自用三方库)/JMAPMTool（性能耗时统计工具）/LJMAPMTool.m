//
//  LJMAPMTool.m
//  LJMKit
//
//  Created by admin on 2021/6/7.
//  Copyright © 2021 jimmy. All rights reserved.
//

#import "LJMAPMTool.h"

#import <mach/mach_time.h>

#import "LJMAPMModel.h"
#import "JKSqliteKit.h"

LJMAPMCollectStyleKey const LJMAPMCollectStyleKeyHTTPDNS = @"HTTPDNS";
LJMAPMCollectStyleKey const LJMAPMCollectStyleKeyHTTPRequest = @"LJMAPMCollectStyleKeyHTTPRequest";
LJMAPMCollectStyleKey const LJMAPMCollectStyleKeyDownloadFile = @"LJMAPMCollectStyleKeyDownloadFile";

LJMAPMCollectStyleKey const LJMAPMCollectStyleKeyAES = @"LJMAPMCollectStyleKeyAES";
LJMAPMCollectStyleKey const LJMAPMCollectStyleKeyRSA = @"LJMAPMCollectStyleKeyRSA";

@implementation LJMAPMTool

static LJMAPMTool *instance = nil;

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
      instance = [[[self class] alloc] init];
      instance.countStyle = LJMCountStyleAchieveTheGoal;
    });
    return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
      instance = [super allocWithZone:zone];
    });
    return instance;
}

+ (uint64_t)apm_foundationStart {
    return mach_absolute_time();
}

+ (uint64_t)apm_foundationStopWithStart:(uint64_t)start {
    uint64_t end = mach_absolute_time();
    uint64_t elapsed = end - start;
    mach_timebase_info_data_t info;
    if (mach_timebase_info(&info) != KERN_SUCCESS) {
        NSLog(@"mach_timebase_info failed\n");
    }
    uint64_t nanosecs = elapsed * info.numer / info.denom;
    uint64_t millisecs = nanosecs / 1000000;
    NSLog(@"cost time = %lld ms", millisecs);
    return millisecs;
}

+ (void)apm_foundationSaveValue:(id)value key:(LJMAPMCollectStyleKey)collectStyleKey {
    LJMAPMModel *model = [[LJMAPMModel alloc] init];
    model.apmID = 1;
    [model setValue:value forKey:LJMAPMCollectStyleKeyHTTPDNS];
    NSLog(@"%@", model.HTTPDNS);

    BOOL result = [JKSqliteModelTool saveOrUpdateModel:model uid:@"1"];
    if (result) {
        // 保存成功
    } else {
        // 保存失败
    }
}

@end
