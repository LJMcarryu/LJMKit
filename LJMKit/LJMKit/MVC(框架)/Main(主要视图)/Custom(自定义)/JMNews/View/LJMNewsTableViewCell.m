//
//  LJMNewsTableViewCell.m
//  LJMKit
//
//  Created by 刘佳明 on 2020/8/31.
//  Copyright © 2020 jimmy. All rights reserved.
//

#import "LJMNewsTableViewCell.h"

@implementation LJMNewsTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.backgroundColor = kBackgroud_Color_Cell;
        self.contentView.backgroundColor = kBackgroud_Color_Cell;
        [self initSubViews];
    }
    return self;
}

#pragma mark - initSubViews

- (void)initSubViews {
    self.picImgView = UIImageView.alloc.init;
    [self.contentView addSubview:self.picImgView];
    self.titleLabel = [JMFactory createLabelWithText:@"xxx" textColor:kMain_Title_Color font:kMainTitleFont textAlignment:0 numberOfLines:1];
    [self.contentView addSubview:self.titleLabel];
    self.authorLabel = [JMFactory createLabelWithText:@"xxx" textColor:kMain_Title_Color font:kSubTitleFont textAlignment:0 numberOfLines:1];
    [self.contentView addSubview:self.authorLabel];
    self.dateLabel = [JMFactory createLabelWithText:@"xxx" textColor:kSub_Title_Color font:12.0f textAlignment:0 numberOfLines:1];
    [self.contentView addSubview:self.dateLabel];

    self.picImgView.contentMode = UIViewContentModeScaleAspectFill;
    self.picImgView.layer.masksToBounds = YES;
}

- (void)layoutSubviews {
    [self.picImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
        make.top.bottom.inset(kSpace_Width);
        make.left.inset(kSide_Width);
        make.width.mas_equalTo(self.picImgView.mas_height).multipliedBy(1.78);
    }];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.picImgView.mas_top);
        make.left.mas_equalTo(self.picImgView.mas_right).mas_offset(kSpace_Width);
        make.right.mas_equalTo(self.contentView.mas_right).inset(kSpace_Width);
        make.height.mas_equalTo(20);
    }];
    [self.authorLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.titleLabel.mas_bottom);
        make.left.mas_equalTo(self.picImgView.mas_right).mas_offset(kSpace_Width);
        make.right.mas_equalTo(self.contentView.mas_right).inset(kSpace_Width);
        make.height.mas_equalTo(15);
    }];
    [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.authorLabel.mas_bottom);
        make.left.mas_equalTo(self.picImgView.mas_right).mas_offset(kSpace_Width);
        make.right.mas_equalTo(self.contentView.mas_right).inset(kSpace_Width);
        make.height.mas_equalTo(15);
    }];
}

- (void)setModel:(LJMNewsModel *)model {
    _model = model;
    [self.picImgView sd_setImageWithURL:[NSURL URLWithString:model.thumbnail_pic_s]];
    self.titleLabel.text = model.title;
    self.authorLabel.text = model.author_name;
    self.dateLabel.text = model.date;
}

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
