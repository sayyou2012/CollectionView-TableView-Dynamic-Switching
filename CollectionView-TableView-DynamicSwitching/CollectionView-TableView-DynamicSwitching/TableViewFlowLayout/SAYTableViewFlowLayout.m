//
//  SAYTableViewFlowLayout.m
//  CollectionView-TableView-DynamicSwitching
//
//  Created by sayyou2012 on 2018/3/25.
//  Copyright © 2018年 sayyou2012. All rights reserved.
//

#import "SAYTableViewFlowLayout.h"

@interface SAYTableViewFlowLayout ()

/**
 *  每个cell对应的CGRect信息
 */
@property (nonatomic, strong) NSDictionary *layoutAttributesDictionary;
/**
 *  总的cell的个数
 */
@property (nonatomic, assign) NSInteger allItemsCount;

@end

@implementation SAYTableViewFlowLayout

- (instancetype)initWithCellItemSize:(CGSize)itemSize
                  minimumLineSpacing:(CGFloat)minimumLineSpacing
{
    self = [super init];
    if (self)
    {
        self.itemSize           = itemSize;
        self.minimumLineSpacing = minimumLineSpacing;
    }
    
    return self;
}

+ (instancetype)tableViewFlowLayoutWithCellItemSize:(CGSize)itemSize
                                 minimumLineSpacing:(CGFloat)minimumLineSpacing
{
    return [[self alloc] initWithCellItemSize:itemSize
                           minimumLineSpacing:minimumLineSpacing];
}

#pragma mark - Layout Prepare

/**
 *
 *  The collection view calls -prepareLayout once at its first layout as the first message to the layout instance.
 *  The collection view calls -prepareLayout again after layout is invalidated and before requerying the layout information.
 *  系统在准备对item进行布局前会调用这个方法,重写此方法，在该方法中准备好即将要展示的布局
 */
- (void)prepareLayout
{
    [super prepareLayout];
    [self pri_prepareLayoutAttributesDictionary];
}


/**
 *  计算collectionview的宽度和高度(宽度由约束决定)
 *
 *  @return collectionview的宽度和高度
 */
- (CGSize)collectionViewContentSize
{
    CGFloat height = (self.itemSize.height + self.minimumLineSpacing) * _allItemsCount;
    
    return CGSizeMake(0, height);
}

#pragma mark - Runtime Layout Calculations

/**
 *
 *  @param rect 包含了ContentSize的位置和尺寸
 *
 *  @return 返回一个包含UICollectionViewLayoutAttributes对象的数组，为对应的indexPath的Cell提供布局信息
 */
- (NSArray *)layoutAttributesForElementsInRect:(CGRect)rect
{
    NSMutableArray *layoutAttributesArray = [NSMutableArray arrayWithCapacity:self.layoutAttributesDictionary.count];
    //遍历prepareLayout方法中准备好的字典
    [self.layoutAttributesDictionary enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        //检查每个item的位置尺寸，看是否在要布局的矩形区域内，若在，则创建对应indexPath的布局属性
        if (CGRectIntersectsRect([obj CGRectValue], rect))
        {
            UICollectionViewLayoutAttributes *cellAttributes = [self pri_layoutAttributesForItemAtIndexPath:key];
            [layoutAttributesArray addObject:cellAttributes];
        }
    }];
    
    return layoutAttributesArray;
}

#pragma mark - Private Methods

/**
 *  初始化每个item的frame并存储到字典中
 */
- (void)pri_prepareLayoutAttributesDictionary
{
    NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
    //正在使用此自定义layout的 collectionview的 section的个数
    NSInteger sectionCount = [self.collectionView numberOfSections];
    
    CGFloat y = 0;
    
    for (int section = 0; section < sectionCount; section++)
    {
        //正在使用此自定义的layout的 collectionview的 ItemsInSection 个数
        NSInteger sectionItemsCount = [self.collectionView numberOfItemsInSection:section];
        self.allItemsCount += sectionItemsCount;
        for (int row = 0; row < sectionItemsCount; ++row)
        {
            y += self.itemSize.height;
            [dictionary setObject:[NSValue valueWithCGRect:CGRectMake(0, y - self.itemSize.height, self.itemSize.width, self.itemSize.height)] forKey:[NSIndexPath indexPathForItem:row inSection:section]];
            if (row < sectionItemsCount -1)
            {
                y += self.minimumLineSpacing;
            }
        }
    }
    
    self.layoutAttributesDictionary = [NSDictionary dictionaryWithDictionary:dictionary];
}

/**
 *  创建指定indexPath对应的布局属性
 *
 */
- (UICollectionViewLayoutAttributes *)pri_layoutAttributesForItemAtIndexPath:(NSIndexPath *)indexPath
{
    id cellRect = self.layoutAttributesDictionary[indexPath];
    if (!cellRect)
    {
        return nil;
    }
    //类方法创建指定indexPath处的布局属性（UICollectionViewLayoutAttributes）
    UICollectionViewLayoutAttributes *attributes = [UICollectionViewLayoutAttributes layoutAttributesForCellWithIndexPath:indexPath];
    //给创建好的布局属性设置其属性值，即在prepareLayout方法中创建的指定位置的frame
    attributes.frame = [cellRect CGRectValue];
    
    return attributes;
}

@end
