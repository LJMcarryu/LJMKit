//
//  LJMAPMTool.m
//  LJMKit
//
//  Created by admin on 2021/6/7.
//  Copyright © 2021 jimmy. All rights reserved.
//

#import "LJMAPMTool.h"

#import <mach/mach_time.h>

@implementation LJMAPMTool

+ (uint64_t)apm_foundationStart {
	return mach_absolute_time();
}

+ (uint64_t)apm_foundationStopWithStart:(uint64_t)start {
	uint64_t end = mach_absolute_time();
	uint64_t elapsed = end - start;
	mach_timebase_info_data_t info;
	if (mach_timebase_info(&info) != KERN_SUCCESS) {
		printf("mach_timebase_info failed\n");
	}
	uint64_t nanosecs = elapsed * info.numer / info.denom;
	uint64_t millisecs = nanosecs / 1000000;
	NSLog(@"cost time = %lld ms", millisecs);
	return millisecs;
}

+ (void)apm_foundationSave {
}

@end
