//
//  LJMXCodeChineseLog.m
//  LJMKit
//
//  Created by Jimmy on 2020/11/13.
//  Copyright © 2020 jimmy. All rights reserved.
//

#import "LJMXCodeChineseLog.h"
#import <objc/runtime.h>

static inline void LJM_swizzleSelector(Class class, SEL originalSelector, SEL swizzledSelector) {
    Method originalMethod = class_getInstanceMethod(class, originalSelector);
    Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
    if (class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod))) {
        class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
    } else {
        method_exchangeImplementations(originalMethod, swizzledMethod);
    }
}

@implementation NSString (LJMXCodeChineseLog)

- (NSString *)stringByReplaceUnicode {
    NSMutableString *convertedString = [self mutableCopy];
    [convertedString replaceOccurrencesOfString:@"\\U"
                                     withString:@"\\u"
                                        options:0
                                          range:NSMakeRange(0, convertedString.length)];

    CFStringRef transform = CFSTR("Any-Hex/Java");
    CFStringTransform((__bridge CFMutableStringRef)convertedString, NULL, transform, YES);
    return convertedString;
}

@end

@implementation NSArray (LJMXCodeChineseLog)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        LJM_swizzleSelector(class, @selector(description), @selector(LJM_description));
        LJM_swizzleSelector(class, @selector(descriptionWithLocale:), @selector(LJM_descriptionWithLocale:));
        LJM_swizzleSelector(class, @selector(descriptionWithLocale:indent:), @selector(LJM_descriptionWithLocale:indent:));
    });
}

- (NSString *)LJM_description {
    return [[self LJM_description] stringByReplaceUnicode];
}

- (NSString *)LJM_descriptionWithLocale:(nullable id)locale {
    return [[self LJM_descriptionWithLocale:locale] stringByReplaceUnicode];
}

- (NSString *)LJM_descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    return [[self LJM_descriptionWithLocale:locale indent:level] stringByReplaceUnicode];
}

@end

@implementation NSDictionary (LJMXCodeChineseLog)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        LJM_swizzleSelector(class, @selector(description), @selector(LJM_description));
        LJM_swizzleSelector(class, @selector(descriptionWithLocale:), @selector(LJM_descriptionWithLocale:));
        LJM_swizzleSelector(class, @selector(descriptionWithLocale:indent:), @selector(LJM_descriptionWithLocale:indent:));
    });
}

- (NSString *)LJM_description {
    return [[self LJM_description] stringByReplaceUnicode];
}

- (NSString *)LJM_descriptionWithLocale:(nullable id)locale {
    return [[self LJM_descriptionWithLocale:locale] stringByReplaceUnicode];
}

- (NSString *)LJM_descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    return [[self LJM_descriptionWithLocale:locale indent:level] stringByReplaceUnicode];
}

@end

@implementation NSSet (LJMXCodeChineseLog)

+ (void)load {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        LJM_swizzleSelector(class, @selector(description), @selector(LJM_description));
        LJM_swizzleSelector(class, @selector(descriptionWithLocale:), @selector(LJM_descriptionWithLocale:));
        LJM_swizzleSelector(class, @selector(descriptionWithLocale:indent:), @selector(LJM_descriptionWithLocale:indent:));
    });
}

- (NSString *)LJM_description {
    return [[self LJM_description] stringByReplaceUnicode];
}

- (NSString *)LJM_descriptionWithLocale:(nullable id)locale {
    return [[self LJM_descriptionWithLocale:locale] stringByReplaceUnicode];
}

- (NSString *)LJM_descriptionWithLocale:(nullable id)locale indent:(NSUInteger)level {
    return [[self LJM_descriptionWithLocale:locale indent:level] stringByReplaceUnicode];
}

@end
