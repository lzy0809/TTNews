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
    __weak typeof(self)weakSelf = self;
    [self.viewModel loadNewsFeedDataWithChannelName:channel finishedBlock:^(NSArray *topics) {
        weakSelf.viewModel.topics = topics;
        [weakSelf.tableView reloadData];
    }];
}

#pragma mark - 加载新数据
- (void)loadNewData {
//    [self.tableView.mj_header endRefreshing];
    [self.viewModel loadNewsFeedDataWithChannelName:self.channel finishedBlock:^(NSArray *topics) {
        NSLog(@"刷新新数据了");
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
    TTNewsBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TTNewsBaseCell" forIndexPath:indexPath];
    if (!cell) {
        cell = [[TTNewsBaseCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"TTNewsBaseCell"];
    }
    TTTopic *topic = self.viewModel.topics[indexPath.row];
    cell.textLabel.text = topic.abstract;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50;
}

- (UITableView *)tableView {
    if (_tableView == nil) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [_tableView registerClass:[TTNewsBaseCell class] forCellReuseIdentifier:@"TTNewsBaseCell"];
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        if (@available(iOS 11.0, *)) {
            _tableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
            _tableView.estimatedRowHeight = 0;
        }
        _tableView.mj_header = [TTRefreshHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        [_tableView.mj_header beginRefreshing];
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
