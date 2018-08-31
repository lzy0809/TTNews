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


/** 创建 t_topic 表 */
static NSString *const create_t_topic_sql = @"CREATE TABLE IF NOT EXISTS t_topic(channel TEXT, abstract TEXT, middle_image TEXT, media_name TEXT, source TEXT, title TEXT, url TEXT, video_style INTEGER, has_video INTEGER, rownum INTEGER, pic_url TEXT)";
/** 缓存 topic 数据 */
static NSString *const insert_topic_sql = @"INSERT INTO t_topic(channel, abstract, middle_image, media_name, source, title, url, video_style, has_video, rownum, pic_url) VALUES(?,?,?,?,?,?,?,?,?,?,?)";



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
        NSLog(@"数据库路径:%@",fileName);
        sharedManager.dbQueue = [FMDatabaseQueue databaseQueueWithPath:fileName];
        [sharedManager initDatabaseTables];
    });
    return sharedManager;
}

- (void)initDatabaseTables {
    
    // 建表 t_category
    [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        BOOL channel_success = [db executeUpdate:create_t_category_sql];
        if (!channel_success) {
            NSLog(@"TTDatabaseManager: createTable t_category error!");
        }
        
        BOOL topic_success = [db executeUpdate:create_t_topic_sql];
        if (!topic_success) {
            NSLog(@"TTDatabaseManager: createTable t_topic error!");
        }
        
        if (![db columnExists:@"pic_url" inTableWithName:@"t_topic"]) {
            [db executeUpdate:@"ALTER TABLE t_topic ADD COLUM pic_url TEXT"];
        }
        
    }];
}

- (BOOL )updateDBFrom0To1 {
    __block BOOL channel_success;
    __block BOOL topic_success;
    
    // 建表 t_category
    [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        channel_success = [db executeUpdate:create_t_category_sql];
        if (!channel_success) {
            NSLog(@"TTDatabaseManager: createTable t_category error!");
        }
    }];
    // 建表 t_topic
    [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        topic_success = [db executeUpdate:create_t_topic_sql];
        if (!channel_success) {
            NSLog(@"TTDatabaseManager: createTable t_topic error!");
        }
    }];
    return channel_success && topic_success;
}

- (BOOL )updateDBFrom1To2 {
    __block BOOL success;
    [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        if (![db columnExists:@"pic_url" inTableWithName:@"t_topic"]) {
            success = [db executeUpdate:@"ALTER TABLE t_topic ADD COLUM pic_url TEXT"];
        }
    }];
    return success;
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

- (void)saveTopics:(NSArray *)topics channelName:(NSString *)channel {
    __block NSInteger rownum = [self countOfCacheTopics:channel];
    [self.dbQueue inTransaction:^(FMDatabase * _Nonnull db, BOOL * _Nonnull rollback) {
        for (NSInteger i = 0; i < topics.count; i++) {
            TTTopic *topic = topics[i];
            [db executeUpdate:insert_topic_sql, topic.channel, topic.abstract, [topic.middle_image yy_modelToJSONString], topic.media_name, topic.source, topic.title, topic.url, topic.video_style, topic.has_video, @(rownum++), topic.pic_url];
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
            topic.middle_image = [TTMiddleImage yy_modelWithJSON:[rs stringForColumn:@"middle_image"]];
            topic.media_name = [rs stringForColumn:@"media_name"];
            topic.source = [rs stringForColumn:@"source"];
            topic.title = [rs stringForColumn:@"title"];
            topic.url = [rs stringForColumn:@"url"];
            topic.video_style = @([rs intForColumn:@"video_style"]);
            topic.has_video = @([rs intForColumn:@"has_video"]);
            topic.rownum = @([rs intForColumn:@"rownum"]);
            topic.pic_url = [rs stringForColumn:@"pic_url"];
            [array addObject:topic];
        }
        [rs close];
    }];
    return [array copy];
}

- (NSInteger )countOfCacheTopics:(NSString *)channel {
    __block NSUInteger count = 0;
    [self.dbQueue inDatabase:^(FMDatabase * _Nonnull db) {
        FMResultSet *rs = [db executeQuery:@"SELECT count(*) FROM t_topic WHERE channel = ?", channel];
        while ([rs next]) {
            count = [rs intForColumnIndex:0];
        }
        [rs close];
    }];
    return count;
}

#pragma mark - Public Method
+ (void)saveChannels:(NSArray *)channels {
    [[self sharedManager] saveChannels:channels];
}

+ (void)saveTopics:(NSArray *)topics channelName:(NSString *)channel {
    [[self sharedManager] saveTopics:topics channelName:channel];
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
