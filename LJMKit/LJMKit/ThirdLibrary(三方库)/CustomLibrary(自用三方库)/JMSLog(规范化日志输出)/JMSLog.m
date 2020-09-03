//
//  JMSLog.m
//  LJMKit
//
//  Created by ios on 2020/8/24.
//  Copyright © 2020 jimmy. All rights reserved.
//

#import "JMSLog.h"

@implementation JMSLog

+ (void)verbose:(NSString *)logString {
    DDLogVerbose(@"💙 Verbose %@", logString);
}

+ (void)debug:(NSString *)logString {
    DDLogDebug(@"💚 Debug %@", logString);
}

+ (void)info:(NSString *)logString {
    DDLogInfo(@"💛 Info %@", logString);
}

+ (void)warn:(NSString *)logString {
    DDLogWarn(@"🧡 Warn %@", logString);
}

+ (void)error:(NSString *)logString {
    DDLogError(@"❤️ Error %@", logString);
}

+ (void)flush {
    JMSLogFlush();
}

@end
