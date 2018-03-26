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
@property (nonatomic, assign) BOOL flag;

@end

@implementation ViewController

static NSString * const kCollectionViewCellReuseIdentifier = @"CollectionViewCellReuseIdentifier";
static CGFloat const kTableViewItemHeight = 100;

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"切换" style:UIBarButtonItemStylePlain target:self action:@selector(switchStyle)];
    
    UICollectionViewFlowLayout *collectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    CGFloat width = (self.view.frame.size.width - 2) * 0.5;
    collectionViewFlowLayout.itemSize = CGSizeMake(width, 200);
    collectionViewFlowLayout.minimumLineSpacing = 2.0f;
    collectionViewFlowLayout.minimumInteritemSpacing = 2.0f;
    
    
    self.collectionView = [[SAYDynamicSwitchingCollectionView alloc] initWithCollectionViewFlowLayout:collectionViewFlowLayout tableViewLayoutItemSize:CGSizeMake(self.view.frame.size.width, kTableViewItemHeight)];
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
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kCollectionViewCellReuseIdentifier forIndexPath:indexPath];
    
    return cell;
}

- (void)switchStyle
{
    self.flag = !_flag;
    if (_flag)
    {
        [self.collectionView switchTableViewLayoutAnimated:YES];

    }
    else
    {
        [self.collectionView switchCollectionViewLayoutAnimated:YES];

    }
}

@end
