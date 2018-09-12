//
//  TTProxy.h
//  TTNewsSDK
//
//  Created by 梁志远 on 2018/9/12.
//  Copyright © 2018年 梁志远. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTProxy : NSProxy
+ (instancetype)proxyWithTarget:(id )target;
@end
