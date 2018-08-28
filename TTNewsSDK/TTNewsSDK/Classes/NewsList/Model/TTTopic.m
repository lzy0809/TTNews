//
//  TTTopic.m
//  TTNewsSDK
//
//  Created by liang on 2018/8/28.
//  Copyright © 2018 梁志远. All rights reserved.
//

#import "TTTopic.h"
#import "NSString+Extension.h"

@implementation TTAction

@end

@implementation TTTopic
+ (NSString *)dbName {
    return @"news_cache.db";
}

+ (NSString *)tableName {
    return @"topic_table";
}

+ (NSString *)primaryKey {
    return @"identity";
}

+ (NSArray *)persistentProperties {
    static NSArray *properties = nil;
    if (!properties) {
        properties = @[
                       @"identity",
                       @"article_url",
                       @"abstract",
                       @"action_list",
                       @"ban_comment",
                       @"behot_time",
                       @"bury_count",
                       @"comment_count"
                       ];
    };
    return properties;
}

- (NSString *)identity {
    return [_article_url MD5Encode];
}

@end
