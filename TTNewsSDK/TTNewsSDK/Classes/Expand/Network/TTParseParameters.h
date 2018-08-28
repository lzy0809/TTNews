//
//  TTParseParameters.h
//  TTNewsSDK
//
//  Created by 梁志远 on 2018/8/26.
//  Copyright © 2018年 梁志远. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTParseParameters : NSObject

/** 获取频道列表的接口 */
+ (NSMutableDictionary*)requestDicPraiseChannleList;
/** 获取新闻列表的接口 */
+ (NSMutableDictionary*)requestDicPraiseNewsFeedWith:(NSString *)channel;

@end
