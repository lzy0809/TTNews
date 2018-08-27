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

+ (instancetype)sharedManager;

+ (void)updateChannels:(void(^)(NSArray *channels))completion;

@end

