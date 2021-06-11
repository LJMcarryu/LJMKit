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
/**
 Key-Value 跟 APMModel 一一对应
 */
LJMAPMCollectStyleKey const LJMAPMCollectStyleKeyHTTPDNS = @"HTTPDNSArray";
LJMAPMCollectStyleKey const LJMAPMCollectStyleKeyHTTPRequest = @"HTTPRequestArray";
LJMAPMCollectStyleKey const LJMAPMCollectStyleKeyDownloadFile = @"downloadFileArray";
LJMAPMCollectStyleKey const LJMAPMCollectStyleKeyAES = @"AESEncryptArray";
LJMAPMCollectStyleKey const LJMAPMCollectStyleKeyRSA = @"RSAEncryptArray";

LJMAPMCollectStyleKey const LJMAPMCollectStyleKeyAdRequestCount = @"requestCount";
LJMAPMCollectStyleKey const LJMAPMCollectStyleKeyAdResponseCount = @"responseCount";
LJMAPMCollectStyleKey const LJMAPMCollectStyleKeyAdStuffCount = @"stuffCount";
LJMAPMCollectStyleKey const LJMAPMCollectStyleKeyAdExposeCount = @"exposeCount";
LJMAPMCollectStyleKey const LJMAPMCollectStyleKeyAdClickCount = @"clickCount";
LJMAPMCollectStyleKey const LJMAPMCollectStyleKeyAdActionStatus = @"actionStatusArray";
LJMAPMCollectStyleKey const LJMAPMCollectStyleKeyAdErrorCode = @"errorCodeArray";

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

/// 耗时统计开始
+ (uint64_t)apm_foundationStart {
    return mach_absolute_time();
}

/// 耗时统计结束
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

/// 耗时统计结果保存或更新
+ (void)apm_foundationSaveValue:(id)value key:(LJMAPMCollectStyleKey)collectStyleKey {
    LJMAPMModel *model = [[LJMAPMModel alloc] init];
    /*
     NSTimeInterval time=[[NSDate date] timeIntervalSince1970]*1000;
     NSString *numStr = [NSString stringWithFormat:@"%0.0f",time];
     long long ts = [numStr longLongValue];
     */
    model.apmID = 1;
//    [model setValue:value forKey:collectStyleKey];
//    NSLog(@"%@", model.HTTPDNS);

    BOOL result = [JKSqliteModelTool saveOrUpdateModel:model uid:@"1"];
    if (result) {
        // 保存成功
    } else {
        // 保存失败
    }
}

@end
