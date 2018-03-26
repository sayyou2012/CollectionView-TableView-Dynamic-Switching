//
//  SAYDynamicSwitchingCollectionView.h
//  CollectionView-TableView-DynamicSwitching
//
//  Created by sayyou2012 on 2018/3/25.
//  Copyright © 2018年 sayyou2012. All rights reserved.
//  对UICollectionView进行封装，使其具有在collectionview布局和tableview布局之间动态切换的功能

#import <UIKit/UIKit.h>

@interface SAYDynamicSwitchingCollectionView : UICollectionView

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
