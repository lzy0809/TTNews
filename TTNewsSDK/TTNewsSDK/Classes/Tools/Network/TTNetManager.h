//
//  TTNetManager.h
//  TTNewsSDK
//
//  Created by 梁志远 on 2018/8/26.
//  Copyright © 2018年 梁志远. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^requestSuccessBlock)(NSURLSessionDataTask *operation, id responseObject);
typedef void(^requestFailedBlock)(NSURLSessionDataTask *operation, NSError *error);

@interface TTNetManager : NSObject
/**
 * 请求类单例对象
 */
+ (instancetype)sharedManager;
/**
 *  @param URLString    请求url
 *  @param parameters   接口要传得参数的字典
 *  @param success      成功回调
 *  @param failure      失败回调
 */
- (void)GET:(NSString *)URLString parameters:(id)parameters success:(requestSuccessBlock )success failure:(requestFailedBlock )failure;

- (void)POST:(NSString *)URLString parameters:(id)parameters success:(requestSuccessBlock )success failure:(requestFailedBlock )failure;

@end
