//
//  TTTool.h
//  TTNewsSDK
//
//  Created by liang on 2018/8/29.
//  Copyright © 2018 梁志远. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTTool : NSObject
+ (BOOL )lastUpdateTimeWithChannelName:(NSString *)channelName withinHours:(NSInteger )hours;
+ (void)updateFetchTime:(NSString *)channelName;
@end
