//
//  TTChannelView.m
//  TTNewsSDK
//
//  Created by liang on 2018/8/27.
//  Copyright © 2018 梁志远. All rights reserved.
//

#import "TTChannelView.h"
#import "TTChannelViewCell.h"
#import "TTCategory.h"
#import "TTChannelViewModel.h"

@interface TTChannelView () <UICollectionViewDelegate, UICollectionViewDataSource>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) TTChannelViewModel *viewModel;
@property (nonatomic, assign) NSInteger currentIndex;
@end

@implementation TTChannelView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.collectionView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.collectionView.frame = self.bounds;
}

- (void)refreshData:(void (^)(NSArray *channels))complation {
    __weak typeof(self)weakSelf = self;
    [self.viewModel loadChannelListData:^{
        complation(weakSelf.viewModel.channels);
        [weakSelf.collectionView reloadData];
    }];
}

- (void)refreshData {
    __weak typeof(self)weakSelf = self;
    [self.viewModel loadChannelListData:^{
        [weakSelf.collectionView reloadData];
    }];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.viewModel.channels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TTChannelViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TTChannelViewCell" forIndexPath:indexPath];
    TTCategory *channel = self.viewModel.channels[indexPath.item];
    channel.isSelected = self.currentIndex == indexPath.item;
    cell.channel = channel;
    return cell;
}
#pragma mark - UICollectionViewDelegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (self.currentIndex == indexPath.item) {
        NSLog(@"点击当前选中频道，执行刷新逻辑");
    } else {
        self.currentIndex = indexPath.item;
        [collectionView scrollToItemAtIndexPath:indexPath atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        if (self.delegate) {
            [self.delegate channelViewDidSelectedIndex:indexPath.row];
        }
    }
}
#pragma mark - UICollectionViewDelegateFlowLayout
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TTCategory *channel = self.viewModel.channels[indexPath.item];
    return CGSizeMake(channel.textWidth, collectionView.height);
}

#pragma mark - Public Method
- (void)updateStatusWithProgress:(CGFloat)progress sourceIndex:(NSInteger)sourceIndex targetIndex:(NSInteger)targetIndex {
    TTChannelViewCell *sourceCell = (TTChannelViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:sourceIndex inSection:0]];
    TTChannelViewCell *targetCell = (TTChannelViewCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0]];
    [sourceCell updateColor:1 - progress];
    [targetCell updateColor:progress];
    self.currentIndex = progress >= 0.8 ? targetIndex : sourceIndex;
    [self.collectionView reloadData];
}

- (void)channelViewScrollToIndex:(NSInteger)index {
    self.currentIndex = index;
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:index inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    [self.collectionView reloadItemsAtIndexPaths:@[[NSIndexPath indexPathForItem:index inSection:0]]];
}


- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.itemSize = CGSizeMake(0.01, 0.01);
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.contentInset = UIEdgeInsetsMake(0, 0, 0, 40);
        if (@available(iOS 10.0, *)) {
            _collectionView.prefetchingEnabled = NO;
        }
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerClass:NSClassFromString(@"TTChannelViewCell") forCellWithReuseIdentifier:@"TTChannelViewCell"];
    }
    return _collectionView;
}

- (TTChannelViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [[TTChannelViewModel alloc] init];
    }
    return _viewModel;
}

@end
