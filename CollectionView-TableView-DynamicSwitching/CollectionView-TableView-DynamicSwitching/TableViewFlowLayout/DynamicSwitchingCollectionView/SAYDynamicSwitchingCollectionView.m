//
//  SAYDynamicSwitchingCollectionView.m
//  CollectionView-TableView-DynamicSwitching
//
//  Created by sayyou2012 on 2018/3/25.
//  Copyright © 2018年 sayyou2012. All rights reserved.
//

#import "SAYDynamicSwitchingCollectionView.h"
#import "SAYTableViewFlowLayout.h"

@interface SAYDynamicSwitchingCollectionView ()

@property (nonatomic, strong) SAYTableViewFlowLayout *tableViewFlowLayout;
@property (nonatomic, strong) UICollectionViewLayout *collectionViewFlowLayout;
@property (nonatomic, assign) CGSize tableViewLayoutItemSize;
@property (nonatomic, assign, readwrite) CurrentLayoutType currentLayoutType;

@end

@implementation SAYDynamicSwitchingCollectionView

- (instancetype)initWithCollectionViewFlowLayout:(UICollectionViewFlowLayout *)collectionViewFlowLayout
                         tableViewLayoutItemSize:(CGSize)tableViewLayoutItemSize
{
    self = [super initWithFrame:CGRectNull collectionViewLayout:collectionViewFlowLayout];
    if (self)
    {
        self.collectionViewLayout = collectionViewFlowLayout;
        _collectionViewFlowLayout = collectionViewFlowLayout;
        _tableViewLayoutItemSize  = tableViewLayoutItemSize;
        _currentLayoutType        = CurrentLayoutTypeCollectionView;
    }
    
    return self;
}

#pragma mark - Lazy Load

- (SAYTableViewFlowLayout *)tableViewFlowLayout
{
    if (!_tableViewFlowLayout)
    {
        UICollectionViewFlowLayout *collectionViewFlowLayout = (UICollectionViewFlowLayout *)self.collectionViewLayout;
        _tableViewFlowLayout = [SAYTableViewFlowLayout tableViewFlowLayoutWithCellItemSize:self.tableViewLayoutItemSize
                                                                        minimumLineSpacing:collectionViewFlowLayout.minimumLineSpacing];
    }
    
    return _tableViewFlowLayout;
}

#pragma mark - Public Methods

- (void)switchTableViewLayoutAnimated:(BOOL)animated
{
    self.currentLayoutType = CurrentLayoutTypeTableView;
    [self setCollectionViewLayout:self.tableViewFlowLayout animated:animated];
}

- (void)switchCollectionViewLayoutAnimated:(BOOL)animated
{
    self.currentLayoutType = CurrentLayoutTypeCollectionView;
    [self setCollectionViewLayout:self.collectionViewFlowLayout animated:animated];
}

@end
