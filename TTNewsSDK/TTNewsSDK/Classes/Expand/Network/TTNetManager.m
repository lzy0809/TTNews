//
//  TTNetManager.m
//  TTNewsSDK
//
//  Created by 梁志远 on 2018/8/26.
//  Copyright © 2018年 梁志远. All rights reserved.
//

#import "TTNetManager.h"
#import <AFNetworking/AFNetworking.h>


static const NSTimeInterval kNetManagerRequestTimeout = 10;

@interface TTNetManager ()
@property (nonatomic, strong) AFHTTPSessionManager *httpManager;
@end

@implementation TTNetManager

+ (instancetype)sharedManager {
    static TTNetManager *sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedManager = [[TTNetManager alloc] init];
        sharedManager.httpManager = [[AFHTTPSessionManager alloc] initWithBaseURL:[NSURL URLWithString:@"https://is.snssdk.com"]];
        AFJSONResponseSerializer *jsonResponSerializer = [AFJSONResponseSerializer serializer];
        jsonResponSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/plain", @"text/javascript", @"text/html", @"application/javascript", nil];
        sharedManager.httpManager.responseSerializer = jsonResponSerializer;
        sharedManager.httpManager.requestSerializer.timeoutInterval = kNetManagerRequestTimeout;
        sharedManager.httpManager.requestSerializer.cachePolicy = NSURLRequestReloadIgnoringCacheData;
    });
    return sharedManager;
}

- (void)GET:(NSString *)URLString parameters:(id)parameters success:(requestSuccessBlock )success failure:(requestFailedBlock )failure {
    NSLog(@"请求接口:%@", URLString);
    
    [self.httpManager GET:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task, error);
        }
    }];
}

- (void)POST:(NSString *)URLString parameters:(id)parameters success:(requestSuccessBlock )success failure:(requestFailedBlock )failure {
    [self.httpManager POST:URLString parameters:parameters progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        if (success) {
            success(task, responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(task, error);
        }
    }];
}































@end
