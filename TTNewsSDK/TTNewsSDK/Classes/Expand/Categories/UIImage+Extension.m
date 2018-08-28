//
//  UIImage+Extension.m
//  TTNewsSDK
//
//  Created by liang on 2018/8/28.
//  Copyright © 2018 梁志远. All rights reserved.
//

#import "UIImage+Extension.h"

@implementation UIImage (Extension)

+ (UIImage *)imageNameTT:(NSString *)name {
    UIImage *image = [UIImage imageNamed:name inBundle:[NSBundle bundleWithPath:[[NSBundle mainBundle] pathForResource:@"TTSDKResources" ofType:@"bundle"]] compatibleWithTraitCollection:nil];
    if (!image) {
        NSLog(@"没有找到图片");
    }
    return image;
}

@end
