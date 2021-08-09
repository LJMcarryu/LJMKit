//
//  LJMAPMModel.h
//  LJMKit
//
//  Created by admin on 2021/6/28.
//  Copyright © 2021 jimmy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

#pragma mark -  统计类型

typedef NS_ENUM (NSUInteger, LJMModelStyle) {
	/// HTTP/HTTPS Request - DNS - Response
	LJMModelStyleNetwork,
	/// Video time consuming
	LJMModelStyleVideoConsume,
    /// Data time consuming
    LJMModelStyleDataConsume,
	/// status
	LJMModelStyleStatus
};

@interface LJMAPMModel : NSObject

/// 本次请求的 cid
@property (nonatomic, copy) NSString *cid;

#pragma mark - HTTP/HTTPS Request - DNS - Response

/// 开始请求的时间点 13位时间戳
@property (nonatomic) long long requestDate;

/// 触发请求到开始解析dns的耗时 单位ms
@property (nonatomic) int awaitTime;

/// DNS 解析耗时
@property (nonatomic) int dnsTime;

/// tcp 三次握手耗时 单位ms
@property (nonatomic) int tcpTime;

/// ssl 握手耗时
@property (nonatomic) int sslTime;

/// 发送请求头 发送请求body的耗时 单位ms
@property (nonatomic) int sendTime;

/// 首包时间
@property (nonatomic) int firstPacketTime;

/// 剩余包时间
@property (nonatomic) int remainPacketTime;

/// 请求结束的时间点 13位时间戳
@property (nonatomic) long long responseDate;

#pragma mark - other time consuming

///// Image 下载开始时间 13位时间戳
//@property (nonatomic) long long ImageStartDownloadDate;
//
///// Image 下载结束时间 13位时间戳
//@property (nonatomic) long long ImageStopDownloadDate;

/// Video 下载开始时间 13位时间戳
@property (nonatomic) long long VideoStartDownloadDate;

/// Video 下载结束时间 13位时间戳
@property (nonatomic) long long VideoStopDownloadDate;

/// Data 压缩开始时间 13位时间戳
@property (nonatomic) long long DataStartCompressDate;

/// Data 压缩结束时间 13位时间戳
@property (nonatomic) long long DataStopCompressDate;

/// 监测耗时操作的状态码
@property (nonatomic) int statusCode;

#pragma mark - status

/// 广告点击后续第一动作
@property (nonatomic) int adActionStatus;

/// 错误日志
@property (nonatomic) int adErrorCode;

#pragma mark - functions

- (NSDictionary *)toDictionaryWithType:(LJMModelStyle)style;

@end

NS_ASSUME_NONNULL_END
