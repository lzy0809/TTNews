//
//  TTNewsListCell.m
//  TTNewsSDK
//
//  Created by liang on 2018/8/27.
//  Copyright © 2018 梁志远. All rights reserved.
//

#import "TTNewsListCell.h"
#import "TTNewsBaseCell.h"
#import "TTNewsListViewModel.h"
#import "TTTopic.h"
#import "TTRefreshHeader.h"

@interface TTNewsListCell () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) TTNewsListViewModel *viewModel;
@property (nonatomic, strong) NSArray *feedList;
@end

@implementation TTNewsListCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.tableView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.tableView.frame = self.contentView.frame;
}

- (void)setChannel:(NSString *)channel {
    _channel = channel;
    
    if ([self.tableView.mj_header isRefreshing] || self.tableView.mj_header.hidden) {
        return;
    }
    [NSObject cancelPreviousPerformRequestsWithTarget:self selector:@selector(refreshData) object:nil];
    [self performSelector:@selector(refreshData) withObject:nil afterDelay:0.3];
}

- (void)refreshData {
    if ([self.tableView numberOfRowsInSection:0] > 0) {
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
    }
    [self.tableView.mj_header beginRefreshing];
}

#pragma mark - 加载新数据
- (void)loadNewData {
    __weak typeof(self)weakSelf = self;
    [self.viewModel loadNewsFeedDataWithChannelName:self.channel isPullDown:YES finishedBlock:^{
        [weakSelf.tableView.mj_header endRefreshing];
        [weakSelf.tableView reloadData];
    }];
}

#pragma mark - UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.viewModel.topics.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TTTopic *topic = self.viewModel.topics[indexPath.row];
    TTNewsBaseCell *cell = [TTNewsBaseCell cellWithTableView:tableView topic:topic];
    cell.topic = topic;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 87;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.backgroundColor = [UIColor whiteColor];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[TTNewsBaseCell class] forCellReuseIdentifier:@"TTNewsBaseCell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 0;
        }
        _tableView.mj_header = [TTRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
//        [_tableView.mj_header beginRefreshing];
    }
    return _tableView;
}

- (TTNewsListViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [[TTNewsListViewModel alloc] init];
    }
    return _viewModel;
}


@end
