//
//  TTNewsListViewModel.h
//  TTNewsSDK
//
//  Created by liang on 2018/8/28.
//  Copyright © 2018 梁志远. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTNewsListViewModel : NSObject

@property (nonatomic, strong) NSArray *topics;

//- (void)loadNewsFeedDataWithChannelName:(NSString *)channelName completion:(void (^)(NSError * error, NSArray * topics))completion;

- (void)loadNewsFeedDataWithChannelName:(NSString *)channelName isPullDown:(BOOL )isPullDown completion:(void (^)(NSInteger errorType, NSArray * topics))completion;

@end
