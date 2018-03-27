//
//  SAYTableViewFlowLayout.h
//  CollectionView-TableView-DynamicSwitching
//
//  Created by sayyou2012 on 2018/3/25.
//  Copyright © 2018年 sayyou2012. All rights reserved.
//  自定义SAYTableViewFlowLayout，继承自UICollectionViewFlowLayout，使其布局为tableview样式

#import <UIKit/UIKit.h>

@interface SAYTableViewFlowLayout : UICollectionViewFlowLayout

/**
 *  根据cell的size和cell的最小间距进行初始化
 *
 *  @param itemSize           每个Cell的大小
 *  @param minimumLineSpacing 上下两个Cell之间的最小间距
 *
 *  @return TableViewStyleFlowLayout
 */
- (instancetype)initWithCellItemSize:(CGSize)itemSize
                  minimumLineSpacing:(CGFloat)minimumLineSpacing;

/**
 *  根据cell的size和cell的最小间距进行初始化
 *
 *  @param itemSize           每个Cell的大小
 *  @param minimumLineSpacing 上下两个Cell之间的最小间距
 *
 *  @return TableViewStyleFlowLayout
 */
+ (instancetype)tableViewFlowLayoutWithCellItemSize:(CGSize)itemSize
                                 minimumLineSpacing:(CGFloat)minimumLineSpacing;

@end
