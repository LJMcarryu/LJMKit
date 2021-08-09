//
//  LJMSafeDictionary.h
//  LJMKit
//
//  Created by admin on 2021/7/28.
//  Copyright © 2021 jimmy. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LJMSafeDictionary : NSObject

- (instancetype)initWithCapacity:(NSUInteger)capacity;

- (void)setObject:(id)anObject forKey:(id)aKey;

- (void)setValue:(nullable id)anObject forKey:(id)aKey;

- (nullable id)objectForKey:(id)aKey;

- (void)removeObjectForKey:(id)aKey;


@end

NS_ASSUME_NONNULL_END
