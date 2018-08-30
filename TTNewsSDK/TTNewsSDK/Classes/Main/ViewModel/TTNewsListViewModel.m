//
//  TTNewsListViewModel.m
//  TTNewsSDK
//
//  Created by liang on 2018/8/28.
//  Copyright © 2018 梁志远. All rights reserved.
//

#import "TTNewsListViewModel.h"
#import "TTTopic.h"
#import "TTNetManager.h"
#import "TTParseParameters.h"
#import "TTDatabaseManager.h"
#import "TTTool.h"

@implementation TTNewsListViewModel

- (void)loadNewsFeedDataWithChannelName:(NSString *)channelName finishedBlock:(void(^)(void))finishedBlock {
    [self fetchNewsFeed:channelName isForce:NO isPullDown:YES finishedBlock:finishedBlock];
}

- (void)loadNewsFeedDataWithChannelName:(NSString *)channelName isPullDown:(BOOL )isPullDown finishedBlock:(void(^)(void))finishedBlock {
    [self fetchNewsFeed:channelName isForce:NO isPullDown:isPullDown finishedBlock:finishedBlock];
}

- (void)fetchNewsFeed:(NSString *)channel isForce:(BOOL )isForce isPullDown:(BOOL )isPullDown finishedBlock:(void(^)(void))finishedBlock {
    
    self.topics = [TTDatabaseManager cachedTopicsWithChannelName:channel];
    if (channel.length == 0 || !finishedBlock) { return; }
    
    if (![TTNetManager checkNetCanUse]) {
        finishedBlock();
        return;
    }
    
    if (!isForce && [TTTool lastUpdateTimeWithChannelName:channel withinHours:0.5]) { // 距上次请求没有超过两个小时
        finishedBlock();
        return;
    }
    __weak typeof(self)weakSelf = self;
    NSLog(@"被%@频道调用了",channel);
    [[TTNetManager sharedManager] GET:kNewsFeedsURL parameters:[TTParseParameters requestDicPraiseNewsFeedWith:channel] success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSArray *dataArray = responseObject[@"data"];
        NSMutableArray *array = [NSMutableArray arrayWithArray:weakSelf.topics];
        for (NSDictionary *dict in dataArray) {
            TTTopic *topic = [TTTopic yy_modelWithJSON:dict[@"content"]];
            if (topic) {
                topic.channel = channel;
                if (isPullDown) {
                    [array insertObject:topic atIndex:0];
                } else {
                    [array addObject:topic];
                }
            }
        }
        weakSelf.topics = [array copy];
        finishedBlock();
        NSLog(@"%@频道有%ld条新闻",channel,array.count);
        [TTTool updateFetchTime:channel];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [TTDatabaseManager saveTopics:array];
        });
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        NSLog(@"请求失败---逻辑待完善");
    }];
}



- (NSArray *)topics {
    if (_topics == nil) {
        _topics = [NSArray array];
    }
    return _topics;
}

@end
