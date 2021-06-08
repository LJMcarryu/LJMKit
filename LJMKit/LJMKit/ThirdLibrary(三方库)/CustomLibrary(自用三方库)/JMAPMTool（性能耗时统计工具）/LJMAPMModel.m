//
//  LJMAPMModel.m
//  LJMKit
//
//  Created by admin on 2021/6/8.
//  Copyright © 2021 jimmy. All rights reserved.
//

#import "LJMAPMModel.h"

@implementation LJMAPMModel

- (instancetype)init {
    self = [super init];
    if (self) {
        self.apmID = 1;
        self.HTTPDNS = @"";
        self.HTTPRequest = @"";
    }
    return self;
}

+ (NSString *)primaryKey {
    return @"apmID";
}

@end
