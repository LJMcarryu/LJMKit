//
//  LJMSafeDictionary.m
//  LJMKit
//
//  Created by admin on 2021/7/28.
//  Copyright © 2021 jimmy. All rights reserved.
//

#import "LJMSafeDictionary.h"

@implementation LJMSafeDictionary {
	NSMutableDictionary *_dic;
	dispatch_queue_t _readWriteQuene;
}

#pragma mark - init

- (instancetype)initWithCapacity:(NSUInteger)capacity {
	self = super.init;
	if (!self) return nil;
	_dic = [[NSMutableDictionary alloc] initWithCapacity:capacity];
	if (!_dic) return nil;
	NSString* uuid = [NSString stringWithFormat:@"com.ifly.ad.dictionary_%p", self];
	_readWriteQuene = dispatch_queue_create([uuid UTF8String], NULL);
	return self;

}

#pragma mark - method

- (void)setObject:(id)anObject forKey:(id <NSCopying> )aKey {
	__weak __typeof(self) ws = self;
	dispatch_barrier_async(_readWriteQuene, ^{
		__strong __typeof(ws) strongSelf = ws;
		[strongSelf->_dic setObject:anObject forKey:aKey];
	});
}

- (void)setValue:(id)anObject forKey:(id)aKey {
	__weak __typeof(self) ws = self;
	dispatch_barrier_async(_readWriteQuene, ^{
		__strong __typeof(ws) strongSelf = ws;
		[strongSelf->_dic setValue:anObject forKey:aKey];
	});
}

- (id)objectForKey:(id)aKey {
	__block id item = nil;
	dispatch_sync(_readWriteQuene, ^{
		item = [_dic objectForKey:aKey];
	});
	return item;
}

- (void)removeObjectForKey:(id)aKey {
	__weak __typeof(self) ws = self;
	dispatch_barrier_async(_readWriteQuene, ^{
		__strong __typeof(ws) strongSelf = ws;
		[strongSelf->_dic removeObjectForKey:aKey];
	});
}



@end
