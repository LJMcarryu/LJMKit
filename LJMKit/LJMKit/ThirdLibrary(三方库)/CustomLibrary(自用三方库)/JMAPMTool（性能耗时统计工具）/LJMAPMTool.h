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

/// 统计类型
typedef NSString *LJMAPMCollectStyleKey NS_STRING_ENUM;
/// Http DNS 耗时
extern LJMAPMCollectStyleKey const LJMAPMCollectStyleKeyHTTPDNS;
/// Http 请求响应耗时
extern LJMAPMCollectStyleKey const LJMAPMCollectStyleKeyHTTPRequest;
/// 文件类下载耗时
extern LJMAPMCollectStyleKey const LJMAPMCollectStyleKeyDownloadFile;
/// AES 加密耗时
extern LJMAPMCollectStyleKey const LJMAPMCollectStyleKeyAES;
/// RSA 加密耗时
extern LJMAPMCollectStyleKey const LJMAPMCollectStyleKeyRSA;

/// 广告请求计数
extern LJMAPMCollectStyleKey const LJMAPMCollectStyleKeyAdRequestCount;
/// 广告响应计数
extern LJMAPMCollectStyleKey const LJMAPMCollectStyleKeyAdResponseCount;
/// 广告填充计数
extern LJMAPMCollectStyleKey const LJMAPMCollectStyleKeyAdStuffCount;
/// 广告曝光计数
extern LJMAPMCollectStyleKey const LJMAPMCollectStyleKeyAdExposeCount;
/// 广告点击计数
extern LJMAPMCollectStyleKey const LJMAPMCollectStyleKeyAdClickCount;
/// 广告点击后续动作
extern LJMAPMCollectStyleKey const LJMAPMCollectStyleKeyAdActionStatus;
/// 错误日志
extern LJMAPMCollectStyleKey const LJMAPMCollectStyleKeyAdErrorCode;

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
