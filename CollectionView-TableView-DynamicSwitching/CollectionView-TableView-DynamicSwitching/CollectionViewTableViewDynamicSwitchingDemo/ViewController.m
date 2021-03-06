//
//  ViewController.m
//  CollectionView-TableView-DynamicSwitching
//
//  Created by sayyou2012 on 2018/3/25.
//  Copyright © 2018年 sayyou2012. All rights reserved.
//

#import "ViewController.h"
#import "SAYDynamicSwitchingCollectionView.h"
#import "CollectionViewCell.h"
#import "Masonry.h"

@interface ViewController () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) SAYDynamicSwitchingCollectionView *collectionView;

@end

@implementation ViewController

static NSString * const kCollectionViewCellReuseIdentifier = @"CollectionViewCellReuseIdentifier";
static CGFloat const kTableViewItemHeight = 100;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"切换" style:UIBarButtonItemStylePlain target:self action:@selector(switchLayout)];
    
    UICollectionViewFlowLayout *collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat width = (self.view.frame.size.width - 2) * 0.5;
    collectionViewFlowLayout.itemSize = CGSizeMake(width, 200);
    collectionViewFlowLayout.minimumLineSpacing = 2.0f;
    collectionViewFlowLayout.minimumInteritemSpacing = 2.0f;
    
    self.collectionView = [[SAYDynamicSwitchingCollectionView alloc] initWithCollectionViewFlowLayout:collectionViewFlowLayout tableViewLayoutItemSize:CGSizeMake(self.view.frame.size.width, kTableViewItemHeight)];
    self.collectionView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [self.view addSubview:self.collectionView];
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.mas_equalTo(self.view);
    }];
    
    [self.collectionView registerNib:[UINib nibWithNibName:NSStringFromClass([CollectionViewCell class]) bundle:nil] forCellWithReuseIdentifier:kCollectionViewCellReuseIdentifier];
    
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    
}


#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 20;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewCellReuseIdentifier forIndexPath:indexPath];
    //TODO:根据SAYDynamicSwitchingCollectionView当前的布局样式来展示对应图片
    SAYDynamicSwitchingCollectionView *dynamicSwitchCollectionView = (SAYDynamicSwitchingCollectionView *)collectionView;
    if (dynamicSwitchCollectionView.currentLayoutType == CurrentLayoutTypeCollectionView)
    {
        cell.cellImage = [UIImage imageNamed:@"IMG_0250"];
    }
    else
    {
        cell.cellImage = [UIImage imageNamed:@"IMG_0251"];
    }
    
    return cell;
}

- (void)switchLayout
{
    NSArray *visibleCells = [self.collectionView visibleCells];

    if (self.collectionView.currentLayoutType == CurrentLayoutTypeCollectionView)
    {
        [self.collectionView switchTableViewLayoutAnimated:YES];
        [visibleCells enumerateObjectsUsingBlock:^(CollectionViewCell *  _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
            cell.cellImage = [UIImage imageNamed:@"IMG_0251"];
        }];

    }
    else
    {
        [self.collectionView switchCollectionViewLayoutAnimated:YES];
        [visibleCells enumerateObjectsUsingBlock:^(CollectionViewCell *  _Nonnull cell, NSUInteger idx, BOOL * _Nonnull stop) {
            cell.cellImage = [UIImage imageNamed:@"IMG_0250"];
        }];
    }
}

@end
