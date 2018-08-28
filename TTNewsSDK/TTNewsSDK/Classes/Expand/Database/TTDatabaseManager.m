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

- (NSArray *)cacheChannels {
    if (_cacheChannels == nil) {
        _cacheChannels = [TTCategory objectsWhere:@"" arguments:nil];
    }
    return _cacheChannels;
}

- (NSArray *)cacheTopics {
    if (_cacheTopics == nil) {
        _cacheTopics = [TTTopic objectsWhere:@"" arguments:nil];
    }
    return _cacheTopics;
}

@end
