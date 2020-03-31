//
//  ZJCategoryView.m
//  ZJBaseKitProject
//
//  Created by 张君君 on 2019/10/28.
//  Copyright © 2019年 com.zhangjunjun.com. All rights reserved.
//

#import "ZJCategoryView.h"
#import <Masonry.h>
#import "ZJConstHeader.h"

@interface ZJCategoryViewCell ()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation ZJCategoryViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.clipsToBounds = YES;
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.top.bottom.right.mas_equalTo(0);
        }];
    }
    return self;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end


@interface ZJCategoryView ()
<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView *collectionView;
/**跟随着item 联动的底部线条*/
@property (nonatomic, strong) UIView *vernier;
/**顶部分割线*/
@property (nonatomic, strong) UIView *topBorder;
/**底部分割线*/
@property (nonatomic, strong) UIView *bottomBorder;
@property (nonatomic) NSInteger selectedIndex;
@property (nonatomic) BOOL selectedCellExist;
@property (nonatomic) CGFloat fontPointSizeScale;
@property (nonatomic) BOOL isFixedVernierWidth;
@property (nonatomic, strong) MASConstraint *vernierLeftConstraint;
@property (nonatomic, strong) MASConstraint *vernierWidthConstraint;

@property (nonatomic, strong) NSMutableDictionary <NSString*,NSNumber *> * sizeDic;

@end

@implementation ZJCategoryView

static NSString * const kBigPrefix    = @"BigAppearance";
static NSString * const kNormalPrefix = @"NormalAppearance";

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor  = [UIColor whiteColor];
        _categoryViewDefaultHeight = kDefaultCategoryViewH;
        _categoryViewRightGap = 100.f;
        _selectedIndex = 0;
        _height = _categoryViewDefaultHeight;
        _vernierHeight = 1.8;
        _itemSpacing   = 15;
        _leftAndRightMargin = 10;
        _titleNomalFont     = ZJFont(13);
        _titleSelectedFont  = ZJBFont(22);
        _titleNormalColor   = [UIColor grayColor];
        _titleSelectedColor = [UIColor blackColor];
        self.vernier.backgroundColor = self.titleSelectedColor;
        self.animateDuration = 0.2;
        _sizeDic = [[NSMutableDictionary alloc] initWithCapacity:0];
        [self setupSubViews];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    if (self.originalIndex > 0) {
        self.selectedIndex = self.originalIndex;
    } else {
        _selectedIndex = 0;
        [self updateVernierLocation];
    }
}

#pragma mark - Public Method
- (void)scrollToTargetIndex:(NSUInteger)targetIndex
                sourceIndex:(NSUInteger)sourceIndex
                    percent:(CGFloat)percent {
    //    CGRect sourceVernierFrame = [self vernierFrameWithIndex:sourceIndex];
    //    CGRect targetVernierFrame = [self vernierFrameWithIndex:targetIndex];
    //
    //    CGFloat tempVernierX    = sourceVernierFrame.origin.x + (targetVernierFrame.origin.x - sourceVernierFrame.origin.x) * percent;
    //    CGFloat tempVernierWidth = sourceVernierFrame.size.width + (targetVernierFrame.size.width - sourceVernierFrame.size.width) * percent;
    //
    //    [self.vernierLeftConstraint  uninstall];
    //    [self.vernierWidthConstraint uninstall];
    //    [self.vernierWidthConstraint uninstall];
    //    [self.vernier mas_updateConstraints:^(MASConstraintMaker *make) {
    //        self.vernierLeftConstraint = make.left.mas_equalTo(tempVernierX);
    //        self.vernierWidthConstraint = make.width.mas_equalTo(tempVernierWidth);
    //        if (!self.isFixedVernierWidth) {
    //            self->_vernierWidth = tempVernierWidth;
    //        }
    //    }];
    
    if (percent > 0.5) {
        ZJCategoryViewCell *sourceCell = [self getCell:sourceIndex];
        ZJCategoryViewCell *targetCell = [self getCell:targetIndex];
        [self p_changeSourceCellScale:sourceCell targetCell:targetCell];
        _selectedIndex = targetIndex;
    }
    [self p_setScrollOffset:_selectedIndex];
}

#pragma mark - Private Method
- (void)setupSubViews {
//    [self addSubview:self.topBorder];
    [self addSubview:self.collectionView];
    [self.collectionView addSubview:self.vernier];
//    [self addSubview:self.bottomBorder];
    
//
//    [self.topBorder mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self).priorityHigh();
//        make.left.right.equalTo(self);
//        make.height.mas_equalTo(ZJ_ONE_PIXEL);
//    }];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0).priorityHigh();
        make.left.mas_equalTo(0);
        make.right.mas_equalTo(-self.categoryViewRightGap);
        make.height.mas_equalTo(self.height - ZJ_ONE_PIXEL);
    }];
    [self.vernier mas_makeConstraints:^(MASConstraintMaker *make) {
        CGFloat collectionViewHeight = self.height - ZJ_ONE_PIXEL * 2;
        make.top.mas_equalTo(collectionViewHeight - self.vernierHeight);
        make.height.mas_equalTo(self.vernierHeight);
    }];
//    [self.bottomBorder mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.equalTo(self);
//        make.height.mas_equalTo(ZJ_ONE_PIXEL);
//    }];
}

- (ZJCategoryViewCell *)getCell:(NSUInteger)index {
    return (ZJCategoryViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
}

- (void)layoutAndScrollToSelectedItem {
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:self.selectedIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    
    if (self.selectedItemHelper) {
        self.selectedItemHelper(self.selectedIndex);
    }
    
    ZJCategoryViewCell *selectedCell = [self getCell:self.selectedIndex];
    if (selectedCell) {
        self.selectedCellExist = YES;
        [self updateVernierLocation];
    } else {
        self.selectedCellExist = NO;
        //这种情况下updateUnderlineLocation将在self.collectionView滚动结束后执行（代理方法scrollViewDidEndScrollingAnimation）
    }
}

- (void)updateVernierLocation {
    [self.collectionView layoutIfNeeded];
    ZJCategoryViewCell *cell = [self getCell:self.selectedIndex];
    
    [self.vernierLeftConstraint uninstall];
    [self.vernierWidthConstraint uninstall];
    [self.vernier mas_updateConstraints:^(MASConstraintMaker *make) {
        if (self.isFixedVernierWidth) {
            self.vernierLeftConstraint = make.left.equalTo(cell.titleLabel.mas_centerX).offset(-self.vernierWidth / 2);
            self.vernierWidthConstraint = make.width.mas_equalTo(self.vernierWidth);
        } else {
            self.vernierLeftConstraint  = make.left.equalTo(cell.titleLabel);
            self.vernierWidthConstraint = make.width.equalTo(cell.titleLabel);
            self->_vernierWidth = cell.titleLabel.frame.size.width;
        }
    }];
    
    [UIView animateWithDuration:self.animateDuration animations:^{
        [self.collectionView layoutIfNeeded];
    }];
    
}

- (void)updateCollectionViewContentInset {
    [self.collectionView.collectionViewLayout invalidateLayout];
    [self.collectionView layoutIfNeeded];
    CGFloat width = self.collectionView.contentSize.width;
    CGFloat margin;
    if (width > ZJScreenWidth) {
        width = ZJScreenWidth;
        margin = 0;
    } else {
        margin = (ZJScreenWidth - width) / 2.0;
    }
    
//    switch (self.alignment) {
//        case ZJCategoryViewAlignmentLeft:
//            self.collectionView.contentInset = UIEdgeInsetsZero;
//            break;
//        case ZJCategoryViewAlignmentCenter:
//            self.collectionView.contentInset = UIEdgeInsetsMake(0, margin, 0, margin);
//            break;
//        case ZJCategoryViewAlignmentRight:
//            self.collectionView.contentInset = UIEdgeInsetsMake(0, margin * 2, 0, 0);
//            break;
//    }
}

- (CGFloat)getWidthWithContent:(NSString *)content {
    CGRect rect = [content boundingRectWithSize:CGSizeMake(MAXFLOAT, self.height - ZJ_ONE_PIXEL)
                                        options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                     attributes:@{NSFontAttributeName:self.titleSelectedFont}
                                        context:nil
                   ];
    return ceilf(rect.size.width);
}

- (CGFloat)getNormalWidthWithContent:(NSString *)content {
    CGRect rect = [content boundingRectWithSize:CGSizeMake(MAXFLOAT, self.height - ZJ_ONE_PIXEL)
                                        options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                     attributes:@{NSFontAttributeName:self.titleNomalFont}
                                        context:nil
                   ];
    return ceilf(rect.size.width);
}

- (CGRect)vernierFrameWithIndex:(NSUInteger)index {
    ZJCategoryViewCell *cell = [self getCell:index];
    CGRect titleLabelFrame = [cell convertRect:cell.titleLabel.frame toView:self.collectionView];
    if (self.isFixedVernierWidth) {
        return CGRectMake(titleLabelFrame.origin.x + (titleLabelFrame.size.width - self.vernierWidth) / 2,
                          self.collectionView.frame.size.height - self.vernierHeight,
                          self.vernierWidth,
                          self.vernierHeight);
    } else {
        return CGRectMake(titleLabelFrame.origin.x,
                          self.collectionView.frame.size.height - self.vernierHeight,
                          cell.titleLabel.frame.size.width,
                          self.vernierHeight);
    }
}

/// 仅点击item的时候调用
- (void)changeItemToTargetIndex:(NSUInteger)targetIndex {
    if (self.selectedIndex == targetIndex) {
        return;
    }
    
    ZJCategoryViewCell *selectedCell = [self getCell:self.selectedIndex];
    ZJCategoryViewCell *targetCell   = [self getCell:targetIndex];
    
    [self p_changeSourceCellScale:selectedCell targetCell:targetCell];
    [self p_setScrollOffset:_selectedIndex];
    
    self.selectedIndex = targetIndex;
}

#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    //    NSString *key = [NSString stringWithFormat:@"%@_%ld",kNormalPrefix,indexPath.row];
    //    if (self.selectedIndex == indexPath.row) {
    //        key = [NSString stringWithFormat:@"%@_%ld",kBigPrefix,indexPath.row];
    //    }
    //    CGFloat width = [self getWidthWithContent:self.titles[indexPath.row]];
    //    CGFloat width = [self.sizeDic[key] floatValue];
    CGFloat height = self.height - ZJ_ONE_PIXEL * 2;
    if (indexPath.row == self.selectedIndex) {
        return CGSizeMake(self.itemWidth, height);
    }
    return CGSizeMake(self.itemNormalWidth, height);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return self.itemSpacing;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return self.itemSpacing;
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section {
    return UIEdgeInsetsMake(0, self.leftAndRightMargin, 0, self.leftAndRightMargin);
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.titles.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    ZJCategoryViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ZJCategoryViewCell class]) forIndexPath:indexPath];
    cell.titleLabel.text = self.titles[indexPath.row];
    if (self.selectedIndex == indexPath.row) {
        cell.titleLabel.font = self.titleSelectedFont;
        cell.titleLabel.textColor = self.titleSelectedColor;
    } else {
        cell.titleLabel.font = self.titleNomalFont;
        cell.titleLabel.textColor = self.titleNormalColor;
    }
    return cell;
}

#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView
didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    [self changeItemToTargetIndex:indexPath.row];
}

#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView {
    if (!self.selectedCellExist) {
        [self updateVernierLocation];
    }
}

#pragma mark - Setter
- (void)setSelectedIndex:(NSInteger)selectedIndex {
    if (self.titles.count == 0) {
        return;
    }
    if (selectedIndex >= self.titles.count) {
        _selectedIndex = self.titles.count - 1;
    } else {
        _selectedIndex = selectedIndex;
    }
    [self layoutAndScrollToSelectedItem];
}

- (void)setTitles:(NSArray<NSString *> *)titles {
    _titles = titles.copy;
    [self.collectionView reloadData];
    [self updateCollectionViewContentInset];
    
    CGFloat maxWidth = self.leftAndRightMargin * 2 + self.itemWidth *titles.count + self.itemSpacing * titles.count - 1;
    if (maxWidth > CGRectGetWidth(self.collectionView.frame)) {
        [self.collectionView setScrollEnabled:true];
    }
    else {
        [self.collectionView setScrollEnabled:false];
    }

}

- (void)setAlignment:(ZJCategoryViewAlignment)alignment {
    _alignment = alignment;
    [self updateCollectionViewContentInset];
}

- (void)setHeight:(CGFloat)categoryViewHeight {
    _height = categoryViewHeight;
    [self.collectionView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(self.height - ZJ_ONE_PIXEL);
    }];
    [self.vernier mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.height - self.vernierHeight - ZJ_ONE_PIXEL);
    }];
}

- (void)setUnderlineHeight:(CGFloat)underlineHeight {
    _vernierHeight = underlineHeight;
    [self.vernier mas_updateConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(self.height - self.vernierHeight - ZJ_ONE_PIXEL);
    }];
}

- (void)setItemSpacing:(CGFloat)cellSpacing {
    _itemSpacing = cellSpacing;
    [self updateCollectionViewContentInset];
}

- (void)setLeftAndRightMargin:(CGFloat)leftAndRightMargin {
    _leftAndRightMargin = leftAndRightMargin;
    [self updateCollectionViewContentInset];
}

- (void)setIsEqualParts:(CGFloat)isEqualParts {
    _isEqualParts = isEqualParts;
    if (self.isEqualParts && self.titles.count > 0) {
        self.itemWidth = (ZJScreenWidth - self.leftAndRightMargin * 2 - self.itemSpacing * (self.titles.count - 1)) / self.titles.count;
    }
}

- (void)setVernierWidth:(CGFloat)vernierWidth {
    _vernierWidth = vernierWidth;
    self.isFixedVernierWidth = YES;
}

- (void)setTitleNomalFont:(UIFont *)titleNomalFont {
    _titleNomalFont = titleNomalFont;
    [self updateCollectionViewContentInset];
}

- (void)setTitleSelectedFont:(UIFont *)titleSelectedFont {
    _titleSelectedFont = titleSelectedFont;
    [self updateCollectionViewContentInset];
}

- (void)setTitleNormalColor:(UIColor *)titleNormalColor {
    _titleNormalColor = titleNormalColor;
    [self.collectionView reloadData];
}

- (void)setTitleSelectedColor:(UIColor *)titleSelectedColor {
    _titleSelectedColor = titleSelectedColor;
    [self.collectionView reloadData];
}

// MARK: - 改变选中项的外观,以及恢复上一个被选中的外观
- (void)p_changeSourceCellScale:(ZJCategoryViewCell *)sourceCell
                     targetCell:(ZJCategoryViewCell *)targetCell {
    
    if (sourceCell)  {
        sourceCell.titleLabel.textColor = self.titleNormalColor;
    }
    if (targetCell)  {
        targetCell.titleLabel.textColor = self.titleSelectedColor;
    }
    [UIView animateWithDuration:self.animateDuration animations:^{
        if (sourceCell) {
            sourceCell.titleLabel.font = self.titleNomalFont;
        }
        if (targetCell) {
            targetCell.titleLabel.font = self.titleSelectedFont;
        }
    } completion:nil];
}

// MARK: - 调整collectionview 偏移量
- (void)p_setScrollOffset:(NSInteger)index {
    
    if (self.collectionView.contentSize.width <= ZJScreenWidth -_categoryViewRightGap) {
        return;
    }
    ZJCategoryViewCell *selectedCell = [self getCell:index];
    if (!selectedCell) {
        return;
    }
    CGRect rect = selectedCell.frame;
    
    float midX = CGRectGetMidX(rect);
    
    float offset = 0;
    
    float contentWidth = self.collectionView.contentSize.width;
    
    float halfWidth = (ZJScreenWidth - _categoryViewRightGap) / 2.0;
    
    if (midX < halfWidth) {
        offset = 0;
    } else if (midX > contentWidth - halfWidth){
        offset = contentWidth - 2 * halfWidth;
    } else {
        offset = midX - halfWidth;
    }
    
    [UIView animateWithDuration:_animateDuration animations:^{
        [self.collectionView setContentOffset:CGPointMake(offset, 0) animated:NO];
    }];
}

#pragma mark - Getter
- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
        flowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero
                                             collectionViewLayout:flowLayout];
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor clearColor];
        _collectionView.delegate   = self;
        _collectionView.dataSource = self;
        _collectionView.bounces = NO;
        [_collectionView registerClass:[ZJCategoryViewCell class] forCellWithReuseIdentifier:NSStringFromClass([ZJCategoryViewCell class])];
    }
    return _collectionView;
}

//- (UIView *)vernier {
//    if (!_vernier) {
//        _vernier = [[UIView alloc] init];
//    }
//    return _vernier;
//}

//- (UIView *)topBorder {
//    if (!_topBorder) {
//        _topBorder = [[UIView alloc] init];
//        _topBorder.backgroundColor = [UIColor lightGrayColor];
//    }
//    return _topBorder;
//}
//
//- (UIView *)bottomBorder {
//    if (!_bottomBorder) {
//        _bottomBorder = [[UIView alloc] init];
//        _bottomBorder.backgroundColor = [UIColor lightGrayColor];
//    }
//    return _bottomBorder;
//}

- (CGFloat)fontPointSizeScale {
    return self.titleSelectedFont.pointSize / self.titleNomalFont.pointSize;
}

- (void)setItemNormalWidth:(CGFloat)itemNormalWidth {
    _itemNormalWidth = itemNormalWidth;
    if (_itemWidth > 0) {
        [self updateCollectionViewContentInset];
    }
}

- (void)setItemWidth:(CGFloat)itemWidth {
    _itemWidth = itemWidth;
    if (_itemNormalWidth > 0) {
        [self updateCollectionViewContentInset];
    }
}

- (void)layerActionEvent:(UILabel *)label
                 isLarge:(BOOL)isLarge {
    CATransition *transition = [CATransition animation];
    [transition setDuration:0.2f];
    transition.type = kCATransitionFade;
    [label.layer addAnimation:transition forKey:nil];
    if (isLarge) {
        label.font = self.titleSelectedFont;
    }
    else {
        label.font = self.titleNomalFont;
    }
}





@end
