//
//  LJMAPMModel.h
//  LJMKit
//
//  Created by admin on 2021/6/8.
//  Copyright © 2021 jimmy. All rights reserved.
//

#import <Foundation/Foundation.h>
// 导入协议
#import "JKSqliteProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface LJMAPMModel : NSObject

@property (nonatomic) int apmID;
/// HTTPDNS 耗时
@property (nonatomic, strong) NSMutableArray *HTTPDNSArray;
/// HTTP Request & Response 耗时
@property (nonatomic, strong) NSMutableArray *HTTPRequestArray;
/// Image & Video download 耗时
@property (nonatomic, strong) NSMutableArray *downloadFileArray;
/// AES 加密耗时
@property (nonatomic, strong) NSMutableArray *AESEncryptArray;
/// RSA 加密耗时
@property (nonatomic, strong) NSMutableArray *RSAEncryptArray;

/// 广告请求计数
@property (nonatomic, copy) NSString *requestCount;
/// 广告响应计数
@property (nonatomic, copy) NSString *responseCount;
/// 广告填充计数
@property (nonatomic, copy) NSString *stuffCount;
/// 广告曝光计数
@property (nonatomic, copy) NSString *exposeCount;
/// 广告点击计数
@property (nonatomic, copy) NSString *clickCount;

/// 广告点击后续动作
@property (nonatomic, strong) NSMutableArray *actionStatusArray;
/// 广告错误日志
@property (nonatomic, strong) NSMutableArray *errorCodeArray;

@end

NS_ASSUME_NONNULL_END
