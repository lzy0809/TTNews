//
//  TTPageContentView.m
//  TTNewsSDK
//
//  Created by liang on 2018/8/27.
//  Copyright © 2018 梁志远. All rights reserved.
//

#import "TTPageContentView.h"
#import "TTNewsListCell.h"
#import "TTCategory.h"

@interface TTPageContentView ()  <UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) CGFloat oldOffsetX;
@property (nonatomic, assign) NSUInteger currentIndex;
@end

@implementation TTPageContentView

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

- (void)setChannels:(NSArray *)channels {
    _channels = channels;
    [self.collectionView reloadData];
}

#pragma mark - Public Method
- (void)scrollToTargetIndex:(NSInteger)targetIndex {
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:targetIndex inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
    self.currentIndex = targetIndex;
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.channels.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TTNewsListCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TTNewsListCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorForRandom];
    TTCategory *channel = self.channels[indexPath.row];
    cell.channel = channel.category;
    return cell;
}
#pragma mark - UICollectionViewDelegate
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.bounds.size;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat progress = 0; NSInteger sourceIndex = 0; NSInteger targetIndex = 0;
    sourceIndex = scrollView.contentOffset.x / scrollView.width;
    if (scrollView.contentOffset.x < 0 || sourceIndex >= self.channels.count - 1 ) {
        self.oldOffsetX = sourceIndex * scrollView.width;
        return;
    }
    progress = scrollView.contentOffset.x / scrollView.width - sourceIndex;
    targetIndex = sourceIndex + 1;
    if (self.delegate) {
        [self.delegate updateStatusWithProgress:progress sourceIndex:sourceIndex targetIndex:targetIndex];
    }
    self.oldOffsetX = scrollView.contentOffset.x;
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    if (index != self.currentIndex) {
        self.currentIndex = index;
        if (self.delegate) {
            [self.delegate scrollToIndex:index];
        }
    }
}

- (UICollectionView *)collectionView {
    if (_collectionView == nil) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        [_collectionView registerClass:[TTNewsListCell class] forCellWithReuseIdentifier:@"TTNewsListCell"];
        _collectionView.pagingEnabled = YES;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        if (@available(iOS 10.0, *)) {
            _collectionView.prefetchingEnabled = NO;
        }
        if (@available(iOS 11.0, *)) {
            _collectionView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
        _collectionView.showsHorizontalScrollIndicator = NO;
    }
    return _collectionView;
}

@end
