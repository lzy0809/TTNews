//
//  TTProxy.m
//  TTNewsSDK
//
//  Created by 梁志远 on 2018/9/12.
//  Copyright © 2018年 梁志远. All rights reserved.
//  代理target

#import "TTProxy.h"

@interface TTProxy ()
@property (nonatomic, weak) id target;
@end

@implementation TTProxy

+ (instancetype)proxyWithTarget:(id)target {
    // NSProxy对象不需要调用init，因为它本来就没有init方法
    TTProxy *proxy = [TTProxy alloc];
    proxy.target = target;
    return proxy;
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self.target methodSignatureForSelector:sel];
}

- (void)forwardInvocation:(NSInvocation *)invocation {
    [invocation invokeWithTarget:self.target];
}

@end
