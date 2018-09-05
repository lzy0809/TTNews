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
#import "TTRefreshFootder.h"
#import "TTErrorView.h"

@interface TTNewsListCell () <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) TTErrorView *errorView;
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
    __weak typeof(self)weakSelf = self;
    [self.viewModel updateNewsFeedIfNeed:channel completion:^(TTErrorType errorType, NSArray *topics) {
        [weakSelf updateInterfaceWithTopics:topics errorType:errorType];
    }];
}

- (void)updateInterfaceWithTopics:(NSArray *)topics errorType:(TTErrorType )errorType {
    if (errorType == TTErrorTypeNoNetwork) {
        if (topics.count == 0) {
//            self.tableView.hidden = YES;
//            self.errorView.hidden = NO;
            self.tableView.backgroundView = self.errorView;
        } else {
//            self.tableView.hidden = NO;
//            self.errorView.hidden = YES;
            self.tableView.backgroundView = nil;
        }
    } else if (errorType == TTErrorTypeRequestFail) {
        if (topics.count == 0) {
//            self.tableView.hidden = YES;
//            self.errorView.hidden = NO;
            self.tableView.backgroundView = self.errorView;
        } else {
//            self.tableView.hidden = NO;
//            self.errorView.hidden = YES;
            self.tableView.backgroundView = nil;
        }
    } else {
//        self.tableView.hidden = NO;
//        self.errorView.hidden = YES;
        self.tableView.backgroundView = nil;
        [self.tableView reloadData];
    }
}

#pragma mark - 加载新数据
- (void)fetchNewsFeedWithChannel:(NSString *)channel isPullDown:(BOOL )isPullDown {
    __weak typeof(self)weakSelf = self;
    [self.viewModel loadNewsFeedDataWithChannelName:channel isPullDown:isPullDown completion:^(NSInteger errorType, NSArray *topics) {
        [weakSelf updateInterfaceWithTopics:topics errorType:errorType];
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
    TTNewsBaseCell *cell = [TTNewsBaseCell cellWithTableView:tableView];
    cell.topic = topic;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    TTTopic *topic = self.viewModel.topics[indexPath.row];
    return topic.cellHeight;
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
        __weak typeof(self)weakSelf = self;
        _tableView.mj_header = [TTRefreshHeader headerWithRefreshingBlock:^{
            [weakSelf fetchNewsFeedWithChannel:weakSelf.channel isPullDown:YES];
        }];
        _tableView.mj_footer = [TTRefreshFootder footerWithRefreshingBlock:^{
            [weakSelf fetchNewsFeedWithChannel:weakSelf.channel isPullDown:NO];
        }];
    }
    return _tableView;
}

- (TTErrorView *)errorView {
    if (_errorView == nil) {
        _errorView = [[TTErrorView alloc] initWithFrame:self.contentView.bounds];
//        _errorView.hidden = YES;
        __weak typeof(self) weakSelf = self;
        _errorView.refreshData = ^{
            [weakSelf fetchNewsFeedWithChannel:weakSelf.channel isPullDown:YES];
        };
//        [self.contentView addSubview:_errorView];
    }
    return _errorView;
}

- (TTNewsListViewModel *)viewModel {
    if (_viewModel == nil) {
        _viewModel = [[TTNewsListViewModel alloc] init];
    }
    return _viewModel;
}


@end
