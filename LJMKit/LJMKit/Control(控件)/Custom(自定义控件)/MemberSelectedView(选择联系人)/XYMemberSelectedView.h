//
//  XYMemberSelectedView.h
//  shiku_im
//
//  Created by ios on 2020/7/9.
//  Copyright © 2020 Jimmy. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol MemberSelectedViewDelegate <NSObject>

/// 点击collection cell取消选中
- (void)removeMemberFromSelectArray:(id)member indexPath:(NSIndexPath *)indexPath;

@end

@interface XYMemberSelectedView : UIView

@property (nonatomic, weak) id<MemberSelectedViewDelegate> delegate;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UITextField *textfield;

/// 当选中人数发生改变时 更改collection view UI
- (void)updateSubviewsLayout:(NSMutableArray *)selelctArray withScroll:(BOOL)canScroll;

@end

NS_ASSUME_NONNULL_END
