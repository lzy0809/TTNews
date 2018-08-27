//
//  TTParseParameters.m
//  TTNewsSDK
//
//  Created by 梁志远 on 2018/8/26.
//  Copyright © 2018年 梁志远. All rights reserved.
//

#import "TTParseParameters.h"

@implementation TTParseParameters

+ (NSMutableDictionary*)requestDicPraiseChannleList {
    NSMutableDictionary *requestDict = [[NSMutableDictionary alloc]init];
    [requestDict setObject:@"6096495334" forKey:@"device_id"];
    [requestDict setObject:@"5034850950" forKey:@"iid"];
    return requestDict;
}

@end
