//
//  TTDatabaseManager.m
//  TTNewsSDK
//
//  Created by liang on 2018/8/27.
//  Copyright © 2018 梁志远. All rights reserved.
//

#import "TTDatabaseManager.h"
#import "TTCategory.h"
#import "NSString+Extension.h"
#import "TTNetManager.h"
#import "TTParseParameters.h"

static NSString *const kCacheChannelsKey = @"kCacheChannelsKey";

@implementation TTDatabaseManager

+ (instancetype)sharedManager {
    static TTDatabaseManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

+ (void)updateChannels:(void(^)(NSArray *channels))completion {
    [[TTNetManager sharedManager] GET:kChannelListURL parameters:[TTParseParameters requestDicPraiseChannleList] success:^(NSURLSessionDataTask *operation, id responseObject) {
        NSString *lastMD5 = [[NSUserDefaults standardUserDefaults] objectForKey:kCacheChannelsKey];
        NSString *currentMD5 = [responseObject yy_modelToJSONString];
        if ([lastMD5 isEqualToString:currentMD5]) {
            completion([TTDatabaseManager sharedManager].cacheChannels);
            return;
        }
        NSMutableArray *dataArray = [NSMutableArray array];
        for (NSDictionary *dict in responseObject[@"data"][@"data"]) {
            TTCategory *category = [TTCategory yy_modelWithJSON:dict];
            [category save];
            [dataArray addObject:category];
        }
        completion(dataArray);
        [[NSUserDefaults standardUserDefaults] setObject:currentMD5 forKey:kCacheChannelsKey];
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        NSLog(@"请求失败了");
    }];
    
}

- (NSArray *)cacheChannels {
    if (_cacheChannels == nil) {
        _cacheChannels = [TTCategory objectsWhere:@"" arguments:nil];
    }
    return _cacheChannels;
}

@end
