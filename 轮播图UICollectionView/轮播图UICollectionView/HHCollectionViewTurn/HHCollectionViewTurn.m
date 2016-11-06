//
//  HHCollectionViewTurn.m
//  轮播图UICollectionView
//
//  Created by HCL黄 on 16/11/6.
//  Copyright © 2016年 HCL黄. All rights reserved.
//

#import "HHCollectionViewTurn.h"
#import "HHCollectionTurnCell.h"

#define kIdentifierCell @"turnCell"
#define kMaxSections 100

// 另外实现可以用控制器封装试试
@interface HHCollectionViewTurn () <UICollectionViewDelegate,UICollectionViewDataSource>

/** UICollectionView */
@property (nonatomic, strong) UICollectionView *collentionView;
/** UIPageControll */
@property (nonatomic, strong) UIPageControl *pageControll;
/** 流水布局 */
@property (nonatomic, weak) UICollectionViewFlowLayout *layout;
/** 定时器 */
@property (nonatomic, strong) NSTimer *timer;
@end

@implementation HHCollectionViewTurn

- (UIPageControl *)pageControll
{
    if (_pageControll == nil) {
        _pageControll = [[UIPageControl alloc] init];
    }
    return _pageControll;
}

- (UICollectionView *)collentionView
{
    if (_collentionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        self.layout = layout;
        
        _collentionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collentionView.backgroundColor = [UIColor clearColor];
        _collentionView.dataSource = self;
        _collentionView.delegate = self;
        _collentionView.showsHorizontalScrollIndicator = NO;
        _collentionView.pagingEnabled = YES;
//        _collentionView.bounces = NO;
        [_collentionView registerNib:[UINib nibWithNibName:@"HHCollectionTurnCell" bundle:nil] forCellWithReuseIdentifier:kIdentifierCell];
    }
    return _collentionView;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.collentionView];
        [self addSubview:self.pageControll];
        
    }
    return self;
}
#pragma mark - 数据
- (void)setDatas:(NSArray *)datas
{
    _datas = datas;
    
    [self layoutIfNeeded];
    
    // 默认滚到中间
    [self.collentionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:0 inSection:kMaxSections/2] atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    // 设置页码
    self.pageControll.numberOfPages = datas.count;
    // 添加定时器
    [self addTimer];
    
}
#pragma mark - 添加定时器
- (void)addTimer
{
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(nextPage) userInfo:nil repeats:YES];
    self.timer = timer;
}
// 重置中间组第0行
- (NSIndexPath *)resetIndexPath
{
    // 当前正在展示的位置
    NSIndexPath *currentIndexPath = [[self.collentionView indexPathsForVisibleItems] lastObject];
    // 重新滚动到中间
    NSIndexPath *resetIndexPath = [NSIndexPath indexPathForItem:currentIndexPath.item inSection:kMaxSections/2];
    [self.collentionView scrollToItemAtIndexPath:resetIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:NO];
    return resetIndexPath;
}
- (void)nextPage
{
    // 当前正在展示的位置
    NSIndexPath *resetIndexPath = [self resetIndexPath];
    
    // 计算下一个展示的位置
    NSInteger nextItem = resetIndexPath.item + 1;
    NSInteger nextSection = resetIndexPath.section;
    if (nextItem == self.datas.count) {
        nextItem = 0;
        nextSection++;
    }
    NSIndexPath *nextIndexPath = [NSIndexPath indexPathForItem:nextItem inSection:nextSection];
    
    // 滚动到下一个位置
    [self.collentionView scrollToItemAtIndexPath:nextIndexPath atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
}
#pragma mark - 停止定时器
- (void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

#pragma mark - 数据源
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return kMaxSections;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.datas.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    HHCollectionTurnCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:kIdentifierCell forIndexPath:indexPath];
    cell.imageName = self.datas[indexPath.item];
    return cell;
}

#pragma mark - 代理
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    // 用户即将拖拽就停止定时器
    [self stopTimer];
}
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    // 用户停止拖拽就开启定时器
    [self addTimer];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    int page = (int)(scrollView.contentOffset.x / scrollView.bounds.size.width + 0.5) % self.datas.count;
    self.pageControll.currentPage = page;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    // 减速完毕调用，可以调用重置，当组较少的时候可以用这个方法
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    self.layout.itemSize = self.bounds.size;
    self.collentionView.frame = self.bounds;
    
    
    CGFloat pageW = 100;
    CGFloat pageH = 30;
    CGFloat pageY = self.frame.size.height - pageH;
    CGFloat pageX = (self.frame.size.width - pageW) * 0.5;
    self.pageControll.frame = CGRectMake(pageX, pageY, pageW, pageH);
}
@end
