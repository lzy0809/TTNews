//
//  TTNewsViewController.m
//  TTNewsSDK
//
//  Created by 梁志远 on 2018/8/26.
//  Copyright © 2018年 梁志远. All rights reserved.
//

#import "TTNewsViewController.h"
#import "TTChannelViewModel.h"
#import "TTChannelView.h"
#import "TTPageContentView.h"

@interface TTNewsViewController () <TTChannelDelegate, TTPageContentDelegate>
@property (nonatomic, strong) TTChannelView *channelView;
@property (nonatomic, strong) TTPageContentView *pageContentView;
@end

@implementation TTNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.channelView];
    [self.view addSubview:self.pageContentView];
    
    __weak typeof(self)weakSelf = self;
    [self.channelView refreshData:^(NSArray * _Nonnull channels) {
        weakSelf.pageContentView.channels = channels;
    }];
}

#pragma mark - TTChannelDelegate
- (void)channelViewDidSelectedIndex:(NSInteger)index {
    [self.pageContentView scrollToTargetIndex:index];
}

#pragma mark - TTPageContentDelegate
- (void)updateStatusWithProgress:(CGFloat)progress sourceIndex:(NSInteger)sourceIndex targetIndex:(NSInteger)targetIndex {
    [self.channelView updateStatusWithProgress:progress sourceIndex:sourceIndex targetIndex:targetIndex];
}

- (void)scrollToIndex:(NSInteger)index {
    [self.channelView channelViewScrollToIndex:index];
}


- (TTChannelView *)channelView {
    if (_channelView == nil) {
        _channelView = [[TTChannelView alloc] initWithFrame:CGRectMake(0, NavigationBarH, self.view.width, 40)];
        _channelView.delegate = self;
    }
    return _channelView;
}

- (TTPageContentView *)pageContentView {
    if (_pageContentView == nil) {
        _pageContentView = [[TTPageContentView alloc] initWithFrame:CGRectMake(0, self.channelView.bottom, self.view.width, self.view.height - self.channelView.bottom)];
        _pageContentView.backgroundColor = [UIColor whiteColor];
        _pageContentView.delegate = self;
    }
    return _pageContentView;
}

@end
