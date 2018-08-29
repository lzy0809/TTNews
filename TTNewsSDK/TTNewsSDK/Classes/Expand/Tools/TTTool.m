//
//  TTTool.m
//  TTNewsSDK
//
//  Created by liang on 2018/8/29.
//  Copyright © 2018 梁志远. All rights reserved.
//

#import "TTTool.h"

@implementation TTTool


+ (BOOL )lastUpdateTimeWithChannelName:(NSString *)channelName withinHours:(CGFloat )hours {
    NSDictionary *dict = [[NSUserDefaults standardUserDefaults] objectForKey:kLastUpdateTimeKey];
    NSDate *date = dict[channelName];
    if (!date) {
        return NO;
    }
    NSTimeInterval lastTime = ABS([date timeIntervalSinceNow]);
    return lastTime < hours * 60 * 60;
}

+ (void)updateFetchTime:(NSString *)channelName {
    NSMutableDictionary *dict = [[[NSUserDefaults standardUserDefaults] objectForKey:kLastUpdateTimeKey] mutableCopy];
    if (dict == nil) {
        dict = [NSMutableDictionary dictionary];
    }
    NSDate *date = [NSDate date];
    [dict setObject:date forKey:channelName];
    [[NSUserDefaults standardUserDefaults] setObject:dict forKey:kLastUpdateTimeKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

@end
