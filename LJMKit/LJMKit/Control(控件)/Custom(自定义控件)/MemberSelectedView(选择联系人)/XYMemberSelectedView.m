//
//  XYMemberSelectedView.m
//  shiku_im
//
//  Created by ios on 2020/7/9.
//  Copyright © 2020 Jimmy. All rights reserved.
//

#import "XYMemberSelectedView.h"
#import "XYMemberSelectedCell.h"

@interface XYMemberSelectedView () <UICollectionViewDelegate, UICollectionViewDataSource>

@property (nonatomic, strong) NSMutableArray <id> *selectArray;

@end

@implementation XYMemberSelectedView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.collectionView];
        [self addSubview:self.textfield];
    }

    return self;
}

#pragma mark - collectionview delegate/datasource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return _selectArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    XYMemberSelectedCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([XYMemberSelectedCell class]) forIndexPath:indexPath];
//    id userModel = _selectArray[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    id userModel = _selectArray[indexPath.item];
    [_selectArray removeObject:userModel];

    if ([_delegate respondsToSelector:@selector(removeMemberFromSelectArray:indexPath:)]) {
        [_delegate removeMemberFromSelectArray:userModel indexPath:indexPath];
    }
    [self updateSubviewsLayout:_selectArray withScroll:NO];
}

#pragma mark - method
- (void)updateSubviewsLayout:(NSMutableArray *)selelctArray withScroll:(BOOL)canScroll {
    self.selectArray = selelctArray;

    CGFloat margin = 8;
    NSInteger count = _selectArray.count;
    CGFloat itemWidth = 40;
    CGFloat width = (margin + itemWidth) * count;
    CGFloat x = (count == 0 ? 0 : 10);
    BOOL isLessThan = (width <= 282 / 375.0 * [UIScreen mainScreen].bounds.size.width);
    CGFloat finalWidth = isLessThan ? width : 282 / 375.0 * [UIScreen mainScreen].bounds.size.width;
    self.collectionView.frame = CGRectMake(x, 0, finalWidth, self.bounds.size.height);
    self.textfield.frame = CGRectMake(CGRectGetMaxX(self.collectionView.frame), 16, [UIScreen mainScreen].bounds.size.width - CGRectGetMaxX(self.collectionView.frame), 20);
    self.textfield.leftViewMode = count < 1 ? UITextFieldViewModeAlways : UITextFieldViewModeNever;
    [self.collectionView reloadData];

    if (!isLessThan && canScroll) {
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:_selectArray.count - 1 inSection:0] atScrollPosition:(UICollectionViewScrollPositionRight) animated:YES];
    }

    [self layoutIfNeeded];
}

#pragma mark - lazy init
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.itemSize = CGSizeMake(40, 40);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumLineSpacing = 8;
        layout.minimumInteritemSpacing = 8;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, 0, self.bounds.size.height) collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.backgroundColor = [UIColor clearColor];
        [_collectionView registerClass:XYMemberSelectedCell.class forCellWithReuseIdentifier:NSStringFromClass([XYMemberSelectedCell class])];
    }

    return _collectionView;
}

- (UITextField *)textfield {
    if (!_textfield) {
        _textfield = [[UITextField alloc] initWithFrame:CGRectMake(CGRectGetMaxX(self.collectionView.frame), 16, [UIScreen mainScreen].bounds.size.width - self.collectionView.bounds.size.width, 20)];
        _textfield.placeholder = @"搜索";
//        _textfield.backgroundColor = kWHITE_BLACK;
//        _textfield.tintColor = kBLUE_COLOR;
//        _textfield.textColor = kBLACK_WHITE;
        _textfield.font = [UIFont systemFontOfSize:14];
        _textfield.borderStyle = UITextBorderStyleNone;
        _textfield.returnKeyType = UIReturnKeyDone;
        UIButton *btn = [UIButton buttonWithType:(UIButtonTypeCustom)];
        btn.frame = CGRectMake(0, 0, 40, 20);
        [btn setImage:[UIImage imageNamed:@"chat_search"] forState:(UIControlStateNormal)];
        btn.enabled = NO;
        _textfield.leftView = btn;
        _textfield.leftViewMode = UITextFieldViewModeAlways;
    }

    return _textfield;
}

@end
