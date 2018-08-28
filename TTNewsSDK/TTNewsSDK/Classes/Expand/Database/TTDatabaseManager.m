//
//  TTDatabaseManager.m
//  TTNewsSDK
//
//  Created by liang on 2018/8/27.
//  Copyright © 2018 梁志远. All rights reserved.
//

#import "TTDatabaseManager.h"
#import "TTCategory.h"
#import "TTTopic.h"

@implementation TTDatabaseManager

+ (instancetype)sharedManager {
    static TTDatabaseManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
    });
    return sharedManager;
}

+ (NSArray *)cachedTopicsWithChannelName:(NSString *)channelName {
    return [[self sharedManager] cachedTopicsWithChannelName:channelName];
}

- (NSArray *)cachedTopicsWithChannelName:(NSString *)channelName {
    return [TTTopic objectsWhere:@"WHERE channel = ?" arguments:@[channelName]];// SELECT * FROM topic_table WHERE channel = ?
}

+ (void)clearTopicsWithChannelName:(NSString *)channelName {
    [[self sharedManager] clearTopicsWithChannelName:channelName];
}

- (void)clearTopicsWithChannelName:(NSString *)channelName {
    [TTTopic deleteObjectsWhere:@"WHERE channel = ?" arguments:@[channelName]];
}

- (NSArray *)cacheChannels {
    if (_cacheChannels == nil) {
        _cacheChannels = [TTCategory objectsWhere:@"" arguments:nil];
    }
    return _cacheChannels;
}

@end
