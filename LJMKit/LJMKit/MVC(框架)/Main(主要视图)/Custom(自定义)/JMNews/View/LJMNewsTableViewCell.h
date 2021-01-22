//
//  LJMNewsTableViewCell.h
//  LJMKit
//
//  Created by 刘佳明 on 2020/8/31.
//  Copyright © 2020 jimmy. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LJMNewsModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface LJMNewsTableViewCell : UITableViewCell

/// cell model
@property (nonatomic, strong) LJMNewsModel *model;

/// picImgView
@property (nonatomic, strong) UIImageView *picImgView;

/// titleLabel
@property (nonatomic, strong) UILabel *titleLabel;

/// authorLabel
@property (nonatomic, strong) UILabel *authorLabel;

/// dateLabel
@property (nonatomic, strong) UILabel *dateLabel;

@end

NS_ASSUME_NONNULL_END
