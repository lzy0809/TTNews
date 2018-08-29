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

- (void)loadNewsFeedDataWithChannelName:(NSString *)channelName finishedBlock:(void(^)(NSArray *topics))finishedBlock {
    
    if (channelName.length == 0 || !finishedBlock) { return; }
    
    if (![TTNetManager checkNetCanUse]) {
        finishedBlock([TTDatabaseManager cachedTopicsWithChannelName:channelName]);
        return;
    }
    if ([TTTool lastUpdateTimeWithChannelName:channelName withinHours:0.5]) { // 距上次请求没有超过两个小时
        finishedBlock([TTDatabaseManager cachedTopicsWithChannelName:channelName]);
        return;
    }
    
    [[TTNetManager sharedManager] GET:kNewsFeedsURL parameters:[TTParseParameters requestDicPraiseNewsFeedWith:channelName] success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSArray *dataArray = responseObject[@"data"];
        NSMutableArray *array = [NSMutableArray array];
        for (NSDictionary *dict in dataArray) {
            TTTopic *topic = [TTTopic yy_modelWithJSON:dict[@"content"]];
            if (topic) {
                topic.channel = channelName;
                [topic save];
                [array addObject:topic];
            }
        }
        if (finishedBlock) {
            finishedBlock(array);
        }
        self.topics = [array copy];
        NSLog(@"%@频道返回%ld条数据",channelName,array.count);
        [TTTool updateFetchTime:channelName];
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
