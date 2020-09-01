//
//  XYTextField.m
//  shiku_im
//
//  Created by ios on 2020/7/3.
//  Copyright © 2020 Jimmy. All rights reserved.
//

#import "XYTextField.h"

@interface XYTextField ()

@property (nonatomic, strong) UILabel *placeholderLabel;

@end

@implementation XYTextField

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = UIColor.whiteColor;
        self.layer.cornerRadius = self.frame.size.height / 2;
        self.layer.masksToBounds = YES;
        // 向左偏移
        [self setValue:[NSNumber numberWithInt:kSide_Width] forKey:@"paddingLeft"];
        [self _initTextFieldViews];
    }
    return self;
}

- (void)_initTextFieldViews {
    self.placeholderLabel = UILabel.alloc.init;
    [self addSubview:self.placeholderLabel];
}

- (void)layoutSubviews {
    self.placeholderLabel.frame = self.bounds;
    self.placeholderLabel.text = self.placeholderString;
    self.placeholderLabel.textColor = UIColor.whiteColor;
    self.placeholderLabel.textAlignment = 1;
    self.placeholderLabel.font = kSystemFont(14);
    self.placeholderLabel.userInteractionEnabled = YES;

    UITapGestureRecognizer *tapGes = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapTextField)];
    [self.placeholderLabel addGestureRecognizer:tapGes];

    [self addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged | UIControlEventEditingDidEnd];
}

- (void)tapTextField {
    if (self.editEnabled) {
        [self becomeFirstResponder];
    } else {
        self.didClickBlock();
    }
}

- (void)textFieldDidChange:(UITextField *)textField {
    if (textField.text.length > 0) {
        self.placeholderLabel.hidden = YES;
    } else {
        self.placeholderLabel.hidden = NO;
    }
}

@end
