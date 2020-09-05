//
//  LJMNewsModel.h
//  LJMKit
//
//  Created by ios on 2020/8/31.
//  Copyright © 2020 jimmy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BGFMDB/BGFMDB.h>

NS_ASSUME_NONNULL_BEGIN

@interface LJMNewsModel : NSObject

/// uniquekey
@property (nonatomic, strong) NSString *uniquekey;
/// title
@property (nonatomic, strong) NSString *title;
/// date
@property (nonatomic, strong) NSString *date;
/// category
@property (nonatomic, strong) NSString *category;
/// author_name
@property (nonatomic, strong) NSString *author_name;
/// url
@property (nonatomic, strong) NSString *url;
/// thumbnail_pic_s
@property (nonatomic, strong) NSString *thumbnail_pic_s;
///// thumbnail_pic_s02
//@property (nonatomic, strong) NSString *thumbnail_pic_s02;
///// thumbnail_pic_s03
//@property (nonatomic, strong) NSString *thumbnail_pic_s03;

@end

NS_ASSUME_NONNULL_END
