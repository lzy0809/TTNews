//
//  NSString+Extension.h
//  TTNewsSDK
//
//  Created by liang on 2018/8/27.
//  Copyright © 2018 梁志远. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)

- (NSString *)MD5Encode;

- (CGFloat)widthWithFont:(UIFont *)font;
- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize maxNumberOfLines:(NSUInteger)numberOfLine;

- (CGSize)sizeWithConstrainedWidth:(CGFloat)width font:(UIFont *)font lineSpace:(CGFloat)lineSpace;
- (CGSize)sizeWithConstrainedSize:(CGSize)size font:(UIFont *)font1 lineSpace:(CGFloat)lineSpace;
- (void)drawInContext:(CGContextRef)context position:(CGPoint)p font:(UIFont *)font textColor:(UIColor *)color height:(CGFloat)height;
- (void)drawInContext:(CGContextRef)context position:(CGPoint)p font:(UIFont *)font textColor:(UIColor *)color height:(CGFloat)height width:(CGFloat)width;
@end

