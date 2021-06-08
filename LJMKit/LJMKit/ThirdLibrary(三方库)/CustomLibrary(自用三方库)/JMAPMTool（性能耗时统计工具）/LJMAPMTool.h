//
//  LJMAPMTool.h
//  LJMKit
//
//  Created by admin on 2021/6/7.
//  Copyright © 2021 jimmy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 统计上传时机类型
typedef NS_ENUM(NSUInteger, LJMCountStyle) {
    /// 达到指定数量更新（默认）
    LJMCountStyleAchieveTheGoal,
    /// 固定时间更新
    LJMCountStyleFixLengthInterval,
    /// 实时更新
    LJMCountStyleInRealTime
};

typedef NSString *LJMAPMCollectStyleKey NS_STRING_ENUM;

extern LJMAPMCollectStyleKey const LJMAPMCollectStyleKeyHTTPDNS;
extern LJMAPMCollectStyleKey const LJMAPMCollectStyleKeyHTTPRequest;
extern LJMAPMCollectStyleKey const LJMAPMCollectStyleKeyDownloadFile;

extern LJMAPMCollectStyleKey const LJMAPMCollectStyleKeyAES;
extern LJMAPMCollectStyleKey const LJMAPMCollectStyleKeyRSA;

@interface LJMAPMTool : NSObject

+ (instancetype)sharedInstance;

#pragma mark - property
/// 统计上传时机类型
@property (nonatomic) LJMCountStyle countStyle;

#pragma mark - foundation
/// 耗时统计开始
+ (uint64_t)apm_foundationStart;
/// 耗时统计结束
+ (uint64_t)apm_foundationStopWithStart:(uint64_t)start;
/// 耗时统计结果保存或更新
+ (void)apm_foundationSaveValue:(id)value key:(LJMAPMCollectStyleKey)collectStyleKey;

@end

NS_ASSUME_NONNULL_END
