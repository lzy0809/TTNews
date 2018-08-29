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
#import "FMDB.h"

/** 创建 t_category 表 */
static NSString *const create_t_category_sql = @"CREATE TABLE IF NOT EXISTS t_category(concern_id TEXT, name TEXT, category TEXT, icon_url TEXT, web_url TEXT, flages INTEGER, tip_new INTEGER, type INTEGER)";
/** 缓存 channel 数据 */
static NSString *const insert_channel_sql = @"INSERT INTO t_category(concern_id, name, category, icon_url, web_url, flages, tip_new, type) VALUES(?,?,?,?,?,?,?,?)";
/** 根据index排序 */
static NSString *const order_by_index_channel_sql = @"SELECT * FROM t_category";

/** 创建 t_category 表 */
static NSString *const create_t_topic_sql = @"CREATE TABLE IF NOT EXISTS t_topic(channel TEXT, abstract TEXT, middle_image TEXT, romnum INTEGER)";
/** 缓存 topic 数据 */
static NSString *const insert_topic_sql = @"INSERT INTO t_topic(channel, abstract, middle_image, romnum) VALUES(?, ?, ?, ?)";



@interface TTDatabaseManager ()
@property (nonatomic, strong) FMDatabaseQueue *dbQueue;
@end

@implementation TTDatabaseManager

+ (instancetype)sharedManager {
    static TTDatabaseManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[self alloc] init];
        NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
        NSString *fileName = [cachePath stringByAppendingPathComponent:@"news_cache.db"];
//        NSLog(@"数据库路径:%@",fileName);
        sharedManager.dbQueue = [FMDatabaseQueue databaseQueueWithPath:fileName];
        [sharedManager createChannelCacheTable];
        [sharedManager createTopicCacheTable];
    });
    return sharedManager;
}

- (void)createChannelCacheTable {
    [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        BOOL success = [db executeUpdate:create_t_category_sql];
        if (!success) {
            NSLog(@"TTDatabaseManager: createTable t_category error!");
        }
    }];
}

- (void)createTopicCacheTable {
    [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        BOOL success = [db executeUpdate:create_t_topic_sql];
        if (!success) {
            NSLog(@"TTDatabaseManager: createTable t_channel error!");
        }
    }];
}

#pragma mark - 核心方法
- (void)saveChannels:(NSArray *)channels {
    
    [self.dbQueue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
        for (NSInteger i = 0; i < channels.count; i++) {
            TTCategory *channel = channels[i];
           [db executeUpdate:insert_channel_sql, channel.concern_id, channel.name, channel.category, channel.icon_url, channel.web_url, channel.flages, channel.tip_new, channel.type];
        }
    }];
}

- (void)saveTopics:(NSArray *)topics {
    [self.dbQueue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
        for (NSInteger i = 0; i < topics.count; i++) {
            TTTopic *topic = topics[i];
            [db executeUpdate:insert_topic_sql, topic.channel, topic.abstract, [topic.middle_image yy_modelToJSONString], @(i)];
        }
    }];
}

- (NSArray *)cachedTopicsWithChannelName:(NSString *)channelName {
    NSMutableArray *array = [NSMutableArray array];
    [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        FMResultSet *rs = [db executeQuery:@"SELECT * FROM t_topic WHERE channel = ?", channelName];
        while ([rs next]) {
            TTTopic *topic = [[TTTopic alloc] init];
            topic.channel = channelName;
            topic.abstract = [rs stringForColumn:@"abstract"];
            topic.middle_image = [TTMiddleImage yy_modelWithJSON:[[rs stringForColumn:@"middle_image"] yy_modelToJSONObject]];
//            topic.rownum = @([rs intForColumn:@"rownum"]);
            [array addObject:topic];
        }
        [rs close];
    }];
    return array;
}

#pragma mark - Public Method
+ (void)saveChannels:(NSArray *)channels {
    [[self sharedManager] saveChannels:channels];
}

+ (void)saveTopics:(NSArray *)topics {
    [[self sharedManager] saveTopics:topics];
}

+ (void)cachedTopicsWithChannelName:(NSString *)channelName callBlock:(void(^)(NSArray *topics))callBlock {
    [[self sharedManager] cachedTopicsWithChannelName:channelName callBlock:callBlock];
}

+ (NSArray *)cachedTopicsWithChannelName:(NSString *)channelName {
    return [[self sharedManager] cachedTopicsWithChannelName:channelName];
}

+ (void)clearTopicsWithChannelName:(NSString *)channelName {
    [[self sharedManager] clearTopicsWithChannelName:channelName];
}

- (NSArray *)cacheChannels {
    if (_cacheChannels == nil) {
        _cacheChannels = [NSArray array];
        NSMutableArray *array = [NSMutableArray array];
        [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
            FMResultSet *rs = [db executeQuery:order_by_index_channel_sql];
            while ([rs next]) {
                TTCategory *channel = [[TTCategory alloc] init];
                channel.category = [rs stringForColumn:@"category"];
                channel.name = [rs stringForColumn:@"name"];
                channel.concern_id = [rs stringForColumn:@"concern_id"];
                channel.icon_url = [rs stringForColumn:@"icon_url"];
                channel.web_url = [rs stringForColumn:@"web_url"];
                channel.flages = @([rs intForColumn:@"flages"]);
                channel.tip_new = @([rs intForColumn:@"tip_new"]);
                channel.type = @([rs intForColumn:@"type"]);
                [array addObject:channel];
            }
            [rs close];
        }];
        _cacheChannels = [array copy];
    }
    return _cacheChannels;
}

@end
