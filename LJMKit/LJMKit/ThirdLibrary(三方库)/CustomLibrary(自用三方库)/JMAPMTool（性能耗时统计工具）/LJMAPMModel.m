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
        self.HTTPDNSArray = @[].mutableCopy;
        self.HTTPRequestArray = @[].mutableCopy;
        self.downloadFileArray = @[].mutableCopy;
        self.AESEncryptArray = @[].mutableCopy;
        self.RSAEncryptArray = @[].mutableCopy;
        
        self.requestCount = @"0";
        self.responseCount = @"0";
        self.stuffCount = @"0";
        self.exposeCount = @"0";
        self.clickCount = @"0";
        
        self.actionStatusArray = @[].mutableCopy;
        self.errorCodeArray = @[].mutableCopy;
    }
    return self;
}

+ (NSString *)primaryKey {
    return @"apmID";
}

@end
