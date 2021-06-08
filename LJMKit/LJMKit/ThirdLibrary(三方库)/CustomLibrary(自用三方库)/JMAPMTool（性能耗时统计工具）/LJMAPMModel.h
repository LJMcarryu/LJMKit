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

@property (nonatomic, copy) NSString *HTTPDNS;

@property (nonatomic, copy) NSString *HTTPRequest;

@end

NS_ASSUME_NONNULL_END
