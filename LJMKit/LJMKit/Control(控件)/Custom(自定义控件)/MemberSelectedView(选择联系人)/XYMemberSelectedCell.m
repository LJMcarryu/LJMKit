//
//  XYMemberSelectedCell.m
//  shiku_im
//
//  Created by ios on 2020/7/9.
//  Copyright © 2020 Jimmy. All rights reserved.
//

#import "XYMemberSelectedCell.h"

@implementation XYMemberSelectedCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.memberHeadImage = [[UIImageView alloc] initWithFrame:self.bounds];
        self.memberHeadImage.layer.cornerRadius = 20;
        self.memberHeadImage.layer.masksToBounds = YES;
        self.memberHeadImage.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self.memberHeadImage];
    }
    return self;
}

@end
