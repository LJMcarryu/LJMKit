//
//  JMSLog.h
//  LJMKit
//
//  Created by ios on 2020/8/24.
//  Copyright © 2020 jimmy. All rights reserved.
//

#import <CocoaLumberjack/CocoaLumberjack.h>

NS_ASSUME_NONNULL_BEGIN

#ifdef DEBUG
static const NSUInteger ddLogLevel = DDLogLevelAll;
#else
static const NSUInteger ddLogLevel = DDLogLevelInfo;
#endif

@interface JMSLog : NSObject
/// 啰嗦的基本信息
+ (void)verbose:(NSString *)logString;
/// 调试信息
+ (void)debug:(NSString *)logString;
/// 描述信息
+ (void)info:(NSString *)logString;
/// 警告信息
+ (void)warn:(NSString *)logString;
/// 错误信息
+ (void)error:(NSString *)logString;

+ (void)flush;

@end

#define JMSLogPrefix()                                                                                                  \
    ([NSString stringWithFormat:@"[%@:%d %s]: ",                                                                        \
      [[NSString stringWithUTF8String:__FILE__] lastPathComponent],                                                     \
      __LINE__,                                                                                                         \
      __PRETTY_FUNCTION__])

#define JMSLogVerbose(_messageFormat, ...)                                                                              \
    do {                                                                                                                \
        DDLogVerbose(@"💙 <V> %@\n%@\n.", JMSLogPrefix(), [NSString stringWithFormat:_messageFormat, ## __VA_ARGS__]);     \
    } while (0)

#define JMSLogDebug(_messageFormat, ...)                                                                                \
    do {                                                                                                                \
        DDLogDebug(@"💚 <D> %@\n%@\n.", JMSLogPrefix(), [NSString stringWithFormat:_messageFormat, ## __VA_ARGS__]);       \
    } while (0)

#define JMSLogInfo(_messageFormat, ...)                                                                                 \
    do {                                                                                                                \
        DDLogInfo(@"💛 <I> %@\n%@\n.", JMSLogPrefix(), [NSString stringWithFormat:_messageFormat, ## __VA_ARGS__]);        \
    } while (0)

#define JMSLogWarn(_messageFormat, ...)                                                                                 \
    do {                                                                                                                \
        DDLogWarn(@"🧡 <W> %@\n%@\n.", JMSLogPrefix(), [NSString stringWithFormat:_messageFormat, ## __VA_ARGS__]);        \
    } while (0)

#define JMSLogError(_messageFormat, ...)                                                                                \
    do {                                                                                                                \
        DDLogError(@"❤️ <E> %@\n%@\n.", JMSLogPrefix(), [NSString stringWithFormat:_messageFormat, ## __VA_ARGS__]);       \
    } while (0)

#define JMSLogFlush()                                                                                                   \
    do {                                                                                                                \
        [DDLog flushLog];                                                                                               \
    } while (0)

NS_ASSUME_NONNULL_END
