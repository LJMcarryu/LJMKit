//
//  LJMAPMTool.h
//  LJMKit
//
//  Created by admin on 2021/6/7.
//  Copyright © 2021 jimmy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark -  统计上传时机类型

typedef NS_ENUM(NSUInteger, LJMCountStyle) {
    /// 实时更新（默认）
    LJMCountStyleInRealTime,
    /// 固定时间更新
    LJMCountStyleFixLengthInterval,
    /// 达到指定数量更新
    LJMCountStyleAchieveTheGoal

};

#pragma mark -  统计类型

typedef NSString *LJMAPMCollectStyleKey NS_STRING_ENUM;
/// Http DNS 耗时
extern LJMAPMCollectStyleKey const LJMAPMCollectStyleKeyHTTPDNS;
/// Http 请求响应耗时
extern LJMAPMCollectStyleKey const LJMAPMCollectStyleKeyHTTPRequest;
/// 图片下载耗时
extern LJMAPMCollectStyleKey const LJMAPMCollectStyleKeyDownloadImage;
/// 视频下载耗时
extern LJMAPMCollectStyleKey const LJMAPMCollectStyleKeyDownloadVideo;
/// RSA 加密耗时
extern LJMAPMCollectStyleKey const LJMAPMCollectStyleKeyRSA;

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
/// 耗时统计结束并上传统计数据给服务器
+ (uint64_t)apm_foundationStopWithStart:(uint64_t)start;

/// 上传统计数据给服务器
+ (void)apm_foundationUploadValue:(NSString *)value key:(LJMAPMCollectStyleKey)collectStyleKey;

@end

NS_ASSUME_NONNULL_END
