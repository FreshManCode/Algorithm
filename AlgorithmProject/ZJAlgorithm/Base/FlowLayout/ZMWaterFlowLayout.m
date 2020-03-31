//
//  ZMWaterFlowLayout.m
//  WaterFlowDemo
//
//  Created by ZM on 2018/10/15.
//  Copyright © 2018年 ZM. All rights reserved.
//

#import "ZMWaterFlowLayout.h"

//#define kLineSpacing 10.0f  //行间距
//#define kItemSpacing 10.0f  //列间距 kInterItemSpacing
/**瀑布流的列数*/
static const NSInteger ZM_DefaultColumnCount = 3;
/**每一行之间的间距*/
static const CGFloat   ZM_DefaultRowMargin = 10.f;
/**每一列之间的间距*/
static const CGFloat   ZM_DefaultColumnMargin = 10.f;
/**边缘的间距*/
static const UIEdgeInsets ZM_DefaultEdgeInsets = {10.f, 10.f, 10.f, 10.f};

@interface ZMWaterFlowLayout()

@end

@implementation ZMWaterFlowLayout

#pragma mark - 基本数据的处理
#pragma mark --- 懒加载 Lazy
//初始化存储容器
- (NSMutableArray *)columnHeightArray{ 
    if (!_columnHeightArray) {
        _columnHeightArray = [NSMutableArray arrayWithCapacity:self.columnCount]; //kColumnCount
    } return _columnHeightArray;
}
- (NSMutableDictionary *)attributeDic{
    if (!_attributeDic) {
        _attributeDic = [NSMutableDictionary dictionary];
    }
    return _attributeDic;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        //初始化间距
        self.columnCount  = ZM_DefaultColumnCount;
        self.lineSpacing  = ZM_DefaultRowMargin;
        self.columnMargin = ZM_DefaultColumnMargin;
        self.edgeInsets   = ZM_DefaultEdgeInsets;
    }
    return self;
}

#pragma mark --- prepareLayout
/**
 * 准备布局item前调用，可以在这里面完成必要属性的初始化
 */
- (void)prepareLayout {
    [super prepareLayout];
    //初始化
    self.minimumInteritemSpacing = ZM_DefaultRowMargin;
    self.minimumLineSpacing      = ZM_DefaultColumnMargin;
    self.delegate = (id<UICollectionViewDelegateFlowLayout>)self.collectionView.delegate;
    [self.columnHeightArray removeAllObjects];
    [self.attributeDic removeAllObjects];
    for (int i=0; i< self.columnCount; ++i) {
        [self.columnHeightArray addObject:@(0.f)];
    }
    
    //遍历所有item获取位置信息并且储存
    NSUInteger sectionCount = [self.collectionView numberOfSections];
    for (int i=0; i < sectionCount; ++i) {
        NSUInteger itemCount = [self.collectionView numberOfItemsInSection:i];
        for (int row=0; row<itemCount; ++row) {
            [self zm_layoutItemFrameAtIndexPath:[NSIndexPath indexPathForRow:row inSection:i]];
        }
    }
}
/**
 * 设置每个item的尺寸并和indexPath为键值对存在字典里
 * @param indexPath item的位置x
 */
- (void)zm_layoutItemFrameAtIndexPath:(NSIndexPath *)indexPath {
//    NSLog(@"---indexPath.row= %ld",(long)indexPath.row);
    //代理获取itemSize, 得到等比例大小
    UIEdgeInsets edgeInsets = [self.delegate collectionView:self.collectionView layout:self insetForSectionAtIndex:indexPath.section];
    CGSize itemSize         = [self.delegate collectionView:self.collectionView layout:self sizeForItemAtIndexPath:indexPath];    
    
    CGFloat collectionView_Width = self.collectionView.frame.size.width;
    CGFloat itemWidth  = (collectionView_Width 
                          -edgeInsets.left 
                          -edgeInsets.right 
                          -(self.columnCount-1)*self.columnMargin) / self.columnCount;
    
    CGFloat itemHeight = itemWidth*itemSize.height/itemSize.width;
    itemSize = CGSizeMake(itemWidth, itemHeight);
//    NSLog(@"---新大小_itemSize= %@ \n ",NSStringFromCGSize(itemSize)); //得到等比例大小
    
    //获取列数中高度最低的一组
    NSUInteger miniColumn = 0;
    CGFloat miniHeight    = [self.columnHeightArray[miniColumn] floatValue];
    for (int column=1; column < self.columnHeightArray.count; ++column) {
        CGFloat currentColumnoHeight = [self.columnHeightArray[column] floatValue];
        //如果当前列的高度小于最低y高度，则重新赋值
        if (miniHeight > currentColumnoHeight) {
            miniHeight = currentColumnoHeight;
            miniColumn = column;
        }
    }
    //找到高度最小的列为column，最小高度为miniColumn。在当前高度最低的列上面追加item并且存储位置信息。
    CGFloat x = edgeInsets.left + miniColumn*(self.columnMargin+itemWidth);
    CGFloat y = edgeInsets.top  + miniHeight;
    CGRect frame = CGRectMake(x, y, itemSize.width, itemSize.height);       //确定cell的frame
    [self.attributeDic setValue:indexPath forKey:NSStringFromCGRect(frame)];//每个cell的frame对应一个indexPath，放入字典中
    //更新列高
    [self.columnHeightArray replaceObjectAtIndex:miniColumn withObject:@(CGRectGetMaxY(frame))];
}


#pragma mark ---  UICollectionViewLayout (UISubclassingHooks)
/**
 * 返回所有当前在可视范围内的item的布局属性
 * @param rect 可视范围
 * @return 可视范围内的所有item的布局属性
 */
- (NSArray<UICollectionViewLayoutAttributes *> *)layoutAttributesForElementsInRect:(CGRect)rect {
    //初始化可视化范围内应该显示的所有item的位置数组
    NSMutableArray *indexPaths = [NSMutableArray array];
    //遍历存放item位置信息的字典，并找到需要显示的item
    for (NSString *itemRectInfo in self.attributeDic) {
        CGRect itemRect = CGRectFromString(itemRectInfo);
        //通过CGRectIntersectsRect方法确定每个item的rect与传入的rect是否有交集，如果有交集则说明这个item需要显示，所有我们将item的位置indexPath加入数组
        if (CGRectIntersectsRect(itemRect, rect)) {
            NSIndexPath *indexPath = self.attributeDic[itemRectInfo];
            [indexPaths addObject:indexPath];
        }
    }
    //初始化存需要显示的item的数组
    NSMutableArray *attributeArray = [NSMutableArray arrayWithCapacity:indexPaths.count];
    
    for (NSIndexPath *index in indexPaths) {
        UICollectionViewLayoutAttributes *attribute = [self layoutAttributesForItemAtIndexPath:index];
        [attributeArray addObject:attribute];
    }
    return attributeArray;
}
#pragma mark --- layoutAttributesForItemAtIndexPath
- (UICollectionViewLayoutAttributes *)layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath  {
    UICollectionViewLayoutAttributes *attribute = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    for (NSString * itemFrame in self.attributeDic) {
        if (self.attributeDic[itemFrame] == indexPath) {
            attribute.frame = CGRectFromString(itemFrame);
            break;
        }
    }
    return attribute;
}



#pragma mark --- collectionViewContentSize
/**
 * 计算collectionView的可滚动范围，必重写
 * @return collectionView内容大小
 */
- (CGSize)collectionViewContentSize {
    CGFloat maxHeight = [self.columnHeightArray[0] floatValue];
    for (int clo=1; clo < self.columnHeightArray.count; ++clo) {
        CGFloat currentCloHeight = [self.columnHeightArray[clo] floatValue];
        if (maxHeight < currentCloHeight) {
            maxHeight = currentCloHeight;
        }
    }
    return CGSizeMake(CGRectGetWidth(self.collectionView.frame), maxHeight + self.collectionView.contentInset.bottom );
}

@end
