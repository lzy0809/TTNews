//
//  TTTopic.m
//  TTNewsSDK
//
//  Created by liang on 2018/8/28.
//  Copyright © 2018 梁志远. All rights reserved.
//

#import "TTTopic.h"
#import <YYModel/YYModel.h>

@implementation TTAction

@end

@implementation TTURLList

@end

@implementation TTMiddleImage
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"url_list" : [TTURLList class]
             };
}

@end

@implementation TTTopic

- (NSString *)abstract {
    return _abstract.length == 0 ? @"接口没有返回有效数据" : _abstract;
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"image_list" : [TTMiddleImage class]
             };
}

// 如果实现了该方法，则处理过程中会忽略该列表内的所有属性
+ (NSArray *)modelPropertyBlacklist {
    return @[
             @"channel",
             @"rownum"
             ];
}

@end
