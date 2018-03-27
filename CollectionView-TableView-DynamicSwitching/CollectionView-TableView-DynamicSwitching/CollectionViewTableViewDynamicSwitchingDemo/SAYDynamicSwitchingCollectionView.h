//
//  SAYDynamicSwitchingCollectionView.h
//  CollectionView-TableView-DynamicSwitching
//
//  Created by sayyou2012 on 2018/3/25.
//  Copyright © 2018年 sayyou2012. All rights reserved.
//  对UICollectionView进行封装，使其具有在collectionview布局和tableview布局之间动态切换的功能

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, CurrentLayoutType)
{
    CurrentLayoutTypeCollectionView,
    CurrentLayoutTypeTableView
};

@interface SAYDynamicSwitchingCollectionView : UICollectionView

@property (nonatomic, assign, readonly) CurrentLayoutType currentLayoutType;// 默认为CurrentLayoutTypeCollectionView

/**
 *  根据collectionViewFlowLayout和tableViewLayoutItemSize进行初始化
 *
 *  @param collectionViewFlowLayout     collectionView布局
 *  @param tableViewLayoutItemSize      tableview布局中的item的大小
 *
 *  @return SAYDynamicSwitchingCollectionView
 */
- (instancetype)initWithCollectionViewFlowLayout:(UICollectionViewFlowLayout *)collectionViewFlowLayout
                         tableViewLayoutItemSize:(CGSize)tableViewLayoutItemSize;

/**
 *  切换到tableview布局
 *  @param animated 是否有动画
 */
- (void)switchTableViewLayoutAnimated:(BOOL)animated;

/**
 *  切换到collectionView布局
 *  @param animated 是否有动画
 */
- (void)switchCollectionViewLayoutAnimated:(BOOL)animated;

@end
