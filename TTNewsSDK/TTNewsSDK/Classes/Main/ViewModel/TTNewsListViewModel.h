//
//  TTNewsListViewModel.h
//  TTNewsSDK
//
//  Created by liang on 2018/8/28.
//  Copyright © 2018 梁志远. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TTErrorType){
    /** 成功 */
    TTErrorTypeSuccess = 0,
    /** 请求失败 */
    TTErrorTypeRequestFail = 1,
    /** 无网 */
    TTErrorTypeNoNetwork = 2,
    /** 不用更新 */
    TTErrorTypeNoUpdate = 3,
};


@interface TTNewsListViewModel : NSObject

@property (nonatomic, strong) NSArray *topics;

- (void)loadNewsFeedDataWithChannelName:(NSString *)channelName isPullDown:(BOOL )isPullDown completion:(void (^)(TTErrorType errorType, NSArray * topics))completion;

- (void)updateNewsFeedIfNeed:(NSString *)channel completion:(void (^)(TTErrorType errorType, NSArray * topics))completion;

@end
