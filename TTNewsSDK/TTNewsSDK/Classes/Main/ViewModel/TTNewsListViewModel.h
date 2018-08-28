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

- (void)loadNewsFeedDataWithChannelName:(NSString *)channelName finishedBlock:(void(^)(NSArray *topics))finishedBlock;

@end
