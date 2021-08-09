

//
//  LJMAPMModel.m
//  LJMKit
//
//  Created by admin on 2021/6/28.
//  Copyright © 2021 jimmy. All rights reserved.
//

#import "LJMAPMModel.h"

#define kIsNULLString(string) ((![string isKindOfClass:[NSString class]]) || [string isEqual:[NSNull null]] || [string isEqualToString:@"(null)"] || [string isEqualToString:@"<null>"] || [[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length] == 0)

#define kStringOrEmpty(string) kIsNULLString(string) == YES ? @"" : string

@implementation LJMAPMModel

- (id)init {
	self = [super init];
	if (self) {
		NSTimeInterval time = [[NSDate date] timeIntervalSince1970] * 1000;
		NSString *ts = [NSString stringWithFormat:@"%0.0f", time];
		_cid = [NSString stringWithFormat:@"%@-%@", [[NSUUID UUID] UUIDString], ts];
	}
	return self;
}

- (NSDictionary *)toDictionaryWithType:(LJMModelStyle)style {
	NSMutableDictionary *dic = [NSMutableDictionary new];

	if (!kIsNULLString(self.cid)) {
		dic[@"cid"] = self.cid;
	}

	if (self.statusCode > 0) {
		dic[@"statusCode"] = @(self.statusCode);
	}

	if (style == LJMModelStyleNetwork) {
		if (self.requestDate > 0) {
			dic[@"requestDate"] = @(self.requestDate);
		}
		if (self.awaitTime > 0) {
			dic[@"awaitTime"] = @(self.awaitTime);
		}
		if (self.dnsTime > 0) {
			dic[@"dnsTime"] = @(self.dnsTime);
		}
		if (self.tcpTime > 0) {
			dic[@"tcpTime"] = @(self.tcpTime);
		}
		if (self.sslTime > 0) {
			dic[@"sslTime"] = @(self.sslTime);
		}
		if (self.sendTime > 0) {
			dic[@"sendTime"] = @(self.sendTime);
		}
		if (self.firstPacketTime > 0) {
			dic[@"firstPacketTime"] = @(self.firstPacketTime);
		}
		if (self.remainPacketTime > 0) {
			dic[@"remainPacketTime"] = @(self.remainPacketTime);
		}
		if (self.responseDate > 0) {
			dic[@"responseDate"] = @(self.responseDate);
		}
	} else if (style == LJMModelStyleVideoConsume) {
		if (self.VideoStartDownloadDate > 0) {
			dic[@"VideoStartDownloadDate"] = @(self.VideoStartDownloadDate);
		}
		if (self.VideoStopDownloadDate > 0) {
			dic[@"VideoStopDownloadDate"] = @(self.VideoStopDownloadDate);
		}
	} else if (style == LJMModelStyleDataConsume) {
		if (self.DataStartCompressDate > 0) {
			dic[@"DataStartCompressDate"] = @(self.DataStartCompressDate);
		}
		if (self.DataStopCompressDate > 0) {
			dic[@"DataStopCompressDate"] = @(self.DataStopCompressDate);
		}
	} else if (style == LJMModelStyleStatus) {
		if (self.adActionStatus > 0) {
			dic[@"adActionStatus"] = @(self.adActionStatus);
		}
		if (self.adErrorCode > 0) {
			dic[@"adErrorCode"] = @(self.adErrorCode);
		}
	}

	return [dic copy];
}

@end
