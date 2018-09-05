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

- (void)updateNewsFeedIfNeed:(NSString *)channel completion:(void (^)(TTErrorType errorType, NSArray * topics))completion {
    [self fetchNewsFeed:channel isTimeLimit:YES isPullDown:YES completion:completion];
}

- (void)loadNewsFeedDataWithChannelName:(NSString *)channelName isPullDown:(BOOL )isPullDown completion:(void (^)(TTErrorType errorType, NSArray * topics))completion {
    [self fetchNewsFeed:channelName isTimeLimit:NO isPullDown:isPullDown completion:completion];
}

- (void)fetchNewsFeed:(NSString *)channel isTimeLimit:(BOOL)isTimeLimit isPullDown:(BOOL )isPullDown completion:(void (^)(TTErrorType errorType, NSArray * topics))completion {
    
    self.topics = [TTDatabaseManager cachedTopicsWithChannelName:channel];
    if (channel.length == 0 || !completion) { return; }
    
    if ([TTNetManager notReachableNetwork]) {
        completion(TTErrorTypeNoNetwork, self.topics);
        return;
    }
    
    if (isTimeLimit && [TTTool lastUpdateTimeWithChannelName:channel withinHours:2]) { // 距上次请求没有超过两个小时
        completion(TTErrorTypeNoUpdate, self.topics);
        return;
    }
    
    __weak typeof(self)weakSelf = self;
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
        completion(TTErrorTypeSuccess, weakSelf.topics);
        NSLog(@"%@频道有%ld条新闻",channel,array.count);
        [TTTool updateFetchTime:channel];
        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
            [TTDatabaseManager saveTopics:array channelName:channel];
        });
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        completion(TTErrorTypeRequestFail, weakSelf.topics);
    }];
}



- (NSArray *)topics {
    if (_topics == nil) {
        _topics = [NSArray array];
    }
    return _topics;
}

@end
