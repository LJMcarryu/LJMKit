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
    DDLogVerbose(@"💙 %@", logString);
}

+ (void)debug:(NSString *)logString {
    DDLogDebug(@"💚 %@", logString);
}

+ (void)info:(NSString *)logString {
    DDLogInfo(@"💛 %@", logString);
}

+ (void)warn:(NSString *)logString {
    DDLogWarn(@"🧡 %@", logString);
}

+ (void)error:(NSString *)logString {
    DDLogError(@"❤️ %@", logString);
}

+ (void)flush {
    JMSLogFlush();
}

@end
