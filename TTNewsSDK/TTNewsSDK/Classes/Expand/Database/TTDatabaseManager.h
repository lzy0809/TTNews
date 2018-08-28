//
//  TTDatabaseManager.h
//  TTNewsSDK
//
//  Created by liang on 2018/8/27.
//  Copyright © 2018 梁志远. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTDatabaseManager : NSObject

@property (nonatomic, strong) NSArray *cacheChannels;

/**
 数据库Manager单例
 */
+ (instancetype)sharedManager;
/**
 该频道下的新闻数据
 @param channelName 频道标识
 @return 该频道下的新闻数据
 */
+ (NSArray *)cachedTopicsWithChannelName:(NSString *)channelName;

/**
 删除该频道下的新闻数据
 @param channelName 频道标识
 */
+ (void)clearTopicsWithChannelName:(NSString *)channelName;

@end

