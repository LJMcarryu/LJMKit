//
//  LJMAPMTool.h
//  LJMKit
//
//  Created by admin on 2021/6/7.
//  Copyright © 2021 jimmy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LJMAPMTool : NSObject

+ (uint64_t)apm_foundationStart;

+ (uint64_t)apm_foundationStopWithStart:(uint64_t)start;

+ (void)apm_foundationSave;

@end

NS_ASSUME_NONNULL_END
