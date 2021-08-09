//
//  LJMAPMTool.h
//  LJMKit
//
//  Created by admin on 2021/6/7.
//  Copyright © 2021 jimmy. All rights reserved.
//

#import <Foundation/Foundation.h>

@class LJMSafeDictionary;

NS_ASSUME_NONNULL_BEGIN

#pragma mark -  统计上传时机类型

typedef NS_ENUM (NSUInteger, LJMCountStyle) {
	/// 实时更新（默认）
	LJMCountStyleInRealTime = 0,
	/// 固定时间更新
	LJMCountStyleFixLengthInterval,
	/// 达到指定数量更新
	LJMCountStyleAchieveTheGoal
};

@interface LJMAPMTool : NSObject

+ (instancetype)sharedInstance;

#pragma mark - property

/// 是否开启性能统计
@property (nonatomic) int isOpenCount;
/// 统计上传时机类型
@property (nonatomic) LJMCountStyle countStyle;
/// 性能统计参考值
@property (nonatomic) int countValue;

/// safeCountDic
@property (nonatomic, strong) LJMSafeDictionary *safeCountDic;

#pragma mark - foundation

/// 耗时统计记录当前时间 13位时间戳
+ (long long)apm_foundationCurrentTimeStamp;

/// 上传统计数据给服务器
+ (void)apm_foundationUploadValuesWithDictionary:(NSDictionary *)dic;

@end

NS_ASSUME_NONNULL_END
