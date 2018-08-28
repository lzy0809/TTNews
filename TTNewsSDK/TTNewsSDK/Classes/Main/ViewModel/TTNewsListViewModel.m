//
//  TTNewsListViewModel.m
//  TTNewsSDK
//
//  Created by liang on 2018/8/28.
//  Copyright © 2018 梁志远. All rights reserved.
//

#import "TTNewsListViewModel.h"
#import "TTTopic.h"
//#import "NSString+Extension.h"
#import "TTNetManager.h"
#import "TTParseParameters.h"
#import "TTDatabaseManager.h"

@implementation TTNewsListViewModel

- (void)loadNewsFeedDataWithChannelName:(NSString *)channelName finishedBlock:(void(^)(NSArray *topics))finishedBlock {
    if ([TTDatabaseManager sharedManager].cacheTopics.count > 0) {
        finishedBlock([TTDatabaseManager sharedManager].cacheTopics);
        NSLog(@"数据库有值");
        return;
    } else {
        [[TTNetManager sharedManager] GET:kNewsFeedsURL parameters:[TTParseParameters requestDicPraiseNewsFeedWith:channelName] success:^(NSURLSessionDataTask *operation, id responseObject) {
            NSArray *dataArray = responseObject[@"data"];
            NSMutableArray *array = [NSMutableArray array];
            for (NSDictionary *dict in dataArray) {
                TTTopic *topic = [TTTopic yy_modelWithJSON:dict[@"content"]];
                [topic save];
                [array addObject:topic];
            }
            finishedBlock(array);
            self.topics = [array copy];
            
        } failure:^(NSURLSessionDataTask *operation, NSError *error) {
            NSLog(@"请求失败");
        }];
    }
}

- (NSArray *)topics {
    if (_topics == nil) {
        _topics = [NSArray array];
    }
    return _topics;
}

@end