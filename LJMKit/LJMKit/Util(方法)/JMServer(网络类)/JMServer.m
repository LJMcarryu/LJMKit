//
//  JMServer.m
//  LJMKit
//
//  Created by Jimmy on 2020/11/18.
//  Copyright © 2020 jimmy. All rights reserved.
//

#import "JMServer.h"

@implementation JMServer

- (NSDictionary<NSString *, NSString *> *)requestHeaderFieldValueDictionary {
	return @{ @"platform": @"iPhone" };
}

@end

@implementation JMNewsApi
{
	NSString *_type;
	NSString *_key;
}

- (id)initWithType:(NSString *)type key:(NSString *)key {
	self = [super init];
	if (self) {
		_type = type;
		_key = key;
	}
	return self;
}

- (NSString *)requestUrl {
	return @"/toutiao/index";
}

- (YTKRequestMethod)requestMethod {
	return YTKRequestMethodGET;
}

- (id)requestArgument {
	return @{
		@"type": _type,
		@"key": _key
	};
	
}

@end
