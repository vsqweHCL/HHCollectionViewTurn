//
//  HHCollectionViewTurn.m
//  轮播图UICollectionView
//
//  Created by HCL黄 on 16/11/6.
//  Copyright © 2016年 HCL黄. All rights reserved.
//

#import "HHCollectionViewTurn.h"
#import "HHCollectionTurnCell.h"

@interface HHCollectionViewTurn () <UICollectionViewDelegate,UICollectionViewDataSource>

/** UICollectionView */
@property (nonatomic, strong) UICollectionView *collentionView;
/** 流水布局 */
@property (nonatomic, weak) UICollectionViewFlowLayout *layout;
@end

@implementation HHCollectionViewTurn

- (UICollectionView *)collentionView
{
    if (_collentionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.layout = layout;
        
        _collentionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collentionView.dataSource = self;
        _collentionView.delegate = self;
        _collentionView.showsHorizontalScrollIndicator = NO;
        _collentionView.pagingEnabled = YES;
        _collentionView.bounces = NO;
        [_collentionView registerNib:[UINib nibWithNibName:@"HHCollectionTurnCell" bundle:nil] forCellWithReuseIdentifier:@"turnCell"];
    }
    return _collentionView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.collentionView];
    }
    return self;
}
#pragma mark - 数据
- (void)setDatas:(NSArray *)datas
{
    _datas = datas;

    [self.collentionView reloadData];
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.datas.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HHCollectionTurnCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"turnCell" forIndexPath:indexPath];
    cell.imageName = self.datas[indexPath.item];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.layout.itemSize = self.bounds.size;
    self.collentionView.frame = self.bounds;
}
@end
