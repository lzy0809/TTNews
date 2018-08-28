//
//  TTChannelViewModel.m
//  TTNewsSDK
//
//  Created by liang on 2018/8/27.
//  Copyright © 2018 梁志远. All rights reserved.
//

#import "TTChannelViewModel.h"
#import "TTCategory.h"
#import "NSString+Extension.h"
#import "TTNetManager.h"
#import "TTParseParameters.h"
#import "TTDatabaseManager.h"

static NSString *const kCacheChannelsKey = @"kCacheChannelsKey";

@implementation TTChannelViewModel

- (void)loadChannelListData:(void (^)(void))finishedBlock {
    // 暂时用数据库数据处理 防止每次启动app都要请求频道列表，后期再改过来
    if ([TTDatabaseManager sharedManager].cacheChannels.count > 0) {
        self.channels = [TTDatabaseManager sharedManager].cacheChannels;
        finishedBlock();
        NSLog(@"数据库有值");
    } else {
        [[TTNetManager sharedManager] GET:kChannelListURL parameters:[TTParseParameters requestDicPraiseChannleList] success:^(NSURLSessionDataTask *operation, id responseObject) {
            NSString *lastMD5 = [[NSUserDefaults standardUserDefaults] objectForKey:kCacheChannelsKey];
            NSString *currentMD5 = [[responseObject yy_modelToJSONString] MD5Encode];
            if ([lastMD5 isEqualToString:currentMD5]) {
                self.channels = [TTDatabaseManager sharedManager].cacheChannels;
                if (finishedBlock) {
                    finishedBlock();
                }
                return;
            }
            NSMutableArray *dataArray = [NSMutableArray array];
            for (NSDictionary *dict in responseObject[@"data"][@"data"]) {
                TTCategory *category = [TTCategory yy_modelWithJSON:dict];
                [category save];
                [dataArray addObject:category];
            }
            self.channels = [dataArray copy];
            if (finishedBlock) {
                finishedBlock();
            }
            NSLog(@"接口返回%ld个频道",dataArray.count);
            [[NSUserDefaults standardUserDefaults] setObject:currentMD5 forKey:kCacheChannelsKey];
        } failure:^(NSURLSessionDataTask *operation, NSError *error) {
            NSLog(@"请求失败了");
        }];
    }
}

- (NSArray *)channels {
    if (_channels == nil) {
        _channels = [NSArray array];
    }
    return _channels;
}

@end
