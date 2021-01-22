//
//  JMServer.h
//  LJMKit
//
//  Created by Jimmy on 2020/11/18.
//  Copyright © 2020 jimmy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JMServer : YTKRequest

@end

@interface JMNewsApi : JMServer

- (id)initWithType:(NSString *)type key:(NSString *)key;

@end

NS_ASSUME_NONNULL_END
