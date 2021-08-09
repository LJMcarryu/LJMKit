//
//  LJMMessageModel.h
//  LJMKit
//
//  Created by admin on 2021/7/19.
//  Copyright © 2021 jimmy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LJMMessageModel : NSObject

/// 语句
@property (nonatomic, copy) NSString *messageText;

/// 出处
@property (nonatomic, copy) NSString *source;

@end

NS_ASSUME_NONNULL_END
