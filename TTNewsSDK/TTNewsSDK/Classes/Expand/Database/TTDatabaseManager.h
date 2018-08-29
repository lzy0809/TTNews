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
/** 数据库Manager单例 */
+ (instancetype)sharedManager;
/** 该频道下的新闻数据 */
+ (NSArray *)cachedTopicsWithChannelName:(NSString *)channelName;

//+ (void)cachedTopicsWithChannelName:(NSString *)channelName callBlock:(void(^)(NSArray *topics))callBlock;

/**
 删除该频道下的新闻数据
 @param channelName 频道标识
 */
//+ (void)clearTopicsWithChannelName:(NSString *)channelName;

+ (void)saveChannels:(NSArray *)channels;

+ (void)saveTopics:(NSArray *)topics;

@end

