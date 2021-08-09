//
//  LJMAPMTool.m
//  LJMKit
//
//  Created by admin on 2021/6/7.
//  Copyright © 2021 jimmy. All rights reserved.
//

#import "LJMAPMTool.h"

#import "LJMSafeDictionary.h"

@implementation LJMAPMTool

static LJMAPMTool *instance = nil;

+ (instancetype)sharedInstance {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		instance = [[[self class] alloc] init];
		instance.isOpenCount = 0;
		instance.countStyle = LJMCountStyleInRealTime;
		instance.countValue = 0;
		instance.safeCountDic = [[LJMSafeDictionary alloc] initWithCapacity:3];
	});
	return instance;
}

+ (instancetype)allocWithZone:(struct _NSZone *)zone {
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		instance = [super allocWithZone:zone];
	});
	return instance;
}

/// 耗时统计记录当前时间 13位时间戳
+ (long long)apm_foundationCurrentTimeStamp {
	NSString *timeStamp = [NSString stringWithFormat:@"%.0f", [[NSDate date] timeIntervalSince1970] * 1000];
	return [timeStamp longLongValue];
}

/// 上传统计数据给服务器
+ (void)apm_foundationUploadValuesWithDictionary:(NSDictionary *)dic {
	NSLog(@"上传数据给服务器 %@", dic);
	// get
	{
		NSURL *url = [NSURL URLWithString:@"http://10.1.112.28:8080/sdk/report"];
		NSURLRequest *request = [NSURLRequest requestWithURL:url];
		NSURLSession *session = [NSURLSession sharedSession];
		NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
		                                  completionHandler:^(NSData *_Nullable data, NSURLResponse *_Nullable response, NSError *_Nullable error) {
		                                          // 对从服务器获取到的数据 data 进行相应的处理
		                                          NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableLeaves) error:nil];
		                                          NSLog(@"获取数据 %@", dict);
						  }];
		[dataTask resume];
	}
	// post
	{
		NSURL *url = [NSURL URLWithString:@""];
		NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
		request.HTTPMethod = @"POST";
		NSURLSession *session = [NSURLSession sharedSession];

		NSURLSessionDataTask *dataTask = [session dataTaskWithRequest:request
		                                  completionHandler:^(NSData *_Nullable data, NSURLResponse *_Nullable response, NSError *_Nullable error) {
		                                          // 对从服务器获取到的数据 data 进行相应的处理
		                                          NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:(NSJSONReadingMutableLeaves) error:nil];
		                                          NSLog(@"获取数据 %@", dict);
						  }];
		[dataTask resume];
	}
}

@end
