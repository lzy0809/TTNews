//
//  TTParseParameters.m
//  TTNewsSDK
//
//  Created by 梁志远 on 2018/8/26.
//  Copyright © 2018年 梁志远. All rights reserved.
//

#import "TTParseParameters.h"

@implementation TTParseParameters

#pragma mark 获取频道列表的接口
+ (NSMutableDictionary*)requestDicPraiseChannleList {
    NSMutableDictionary *requestDict = [[NSMutableDictionary alloc]init];
    requestDict[@"device_id"] = @"6096495334";
    requestDict[@"iid"] = @"5034850950";
    return requestDict;
}

#pragma mark 获取新闻列表的接口
+ (NSMutableDictionary*)requestDicPraiseNewsFeedWith:(NSString *)channel {
    NSMutableDictionary *requestDict = [[NSMutableDictionary alloc]init];
    requestDict[@"device_id"] = @"6096495334";
    requestDict[@"iid"] = @"5034850950";
    requestDict[@"count"] = @"20";
    requestDict[@"list_count"] = @"15";
    requestDict[@"category"] = channel;
    requestDict[@"min_behot_time"] = @([[NSDate date] timeIntervalSince1970]);
    requestDict[@"strict"] = @"0";
    requestDict[@"detail"] = @"1";
    requestDict[@"refresh_reason"] = @"1";
    requestDict[@"tt_from"] = @"pull";
    return requestDict;
}

@end
