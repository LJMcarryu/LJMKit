//
//  LJMAPMTool.m
//  LJMKit
//
//  Created by admin on 2021/6/7.
//  Copyright © 2021 jimmy. All rights reserved.
//

#import "LJMAPMTool.h"

#import <mach/mach_time.h>

/**
   Key-Value
 */
LJMAPMCollectStyleKey const LJMAPMCollectStyleKeyHTTPDNS = @"HTTPDNS";
LJMAPMCollectStyleKey const LJMAPMCollectStyleKeyHTTPRequest = @"HTTPRequest";
LJMAPMCollectStyleKey const LJMAPMCollectStyleKeyDownloadImage = @"downloadImage";
LJMAPMCollectStyleKey const LJMAPMCollectStyleKeyDownloadVideo = @"downloadVideo";
LJMAPMCollectStyleKey const LJMAPMCollectStyleKeyRSA = @"RSAEncrypt";

LJMAPMCollectStyleKey const LJMAPMCollectStyleKeyAdActionStatus = @"adActionStatus";
LJMAPMCollectStyleKey const LJMAPMCollectStyleKeyAdErrorCode = @"adErrorCode";

@implementation LJMAPMTool

static LJMAPMTool *instance = nil;

+ (instancetype)sharedInstance {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
      instance = [[[self class] alloc] init];
      instance.countStyle = LJMCountStyleInRealTime;
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

/// 耗时统计结束并上传统计数据给服务器
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

/// 上传统计数据给服务器
+ (void)apm_foundationUploadValue:(NSString *)value key:(LJMAPMCollectStyleKey)collectStyleKey {
    NSLog(@"上传数据给服务器 { %@ : %@ }", collectStyleKey, value);
}

@end
