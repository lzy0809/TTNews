//
//  TTCategory.m
//  TTNewsSDK
//
//  Created by 梁志远 on 2018/8/26.
//  Copyright © 2018年 梁志远. All rights reserved.
//

#import "TTCategory.h"
#import "NSString+Extension.h"

@implementation TTCategory

+ (NSString *)dbName {
    return @"news_cache.db";
}

+ (NSString *)tableName {
    return @"category_table";
}

+ (NSString *)primaryKey {
    return @"category";
}

+ (NSArray *)persistentProperties {
    static NSArray *properties = nil;
    if (!properties) {
        properties = @[
                       @"category",
                       @"name",
                       @"concern_id",
                       @"icon_url",
                       @"web_url",
                       @"flages",
                       @"tip_new",
                       @"type"
                       ];
    };
    return properties;
}

- (CGFloat)textWidth {
    if (_textWidth == 0 && _name.length > 0) {
        _textWidth = [_name widthWithFont:[UIFont systemFontOfSize:16]] + 28;
    }
    return _textWidth;
}

@end
