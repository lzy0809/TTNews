//
//  NSString+Extension.m
//  TTNewsSDK
//
//  Created by liang on 2018/8/27.
//  Copyright © 2018 梁志远. All rights reserved.
//

#import "NSString+Extension.h"
#import <CommonCrypto/CommonDigest.h>
#import <CoreText/CoreText.h>

@implementation NSString (Extension)

- (NSString *)MD5Encode {
    if (self == nil || self.length == 0) {
        return @"";
    }
    const char *cStr = [self UTF8String];
    unsigned char result[16];
    CC_MD5(cStr, (CC_LONG)strlen(cStr), result);
    return [NSString stringWithFormat:
            @"%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x%02x",
            result[0], result[1], result[2], result[3],
            result[4], result[5], result[6], result[7],
            result[8], result[9], result[10], result[11],
            result[12], result[13], result[14], result[15]];
}

- (CGFloat)widthWithFont:(UIFont *)font {
    return [self sizeWithFont:font maxSize:CGSizeMake(MAXFLOAT, MAXFLOAT) maxNumberOfLines:0].width;
}

- (CGSize)sizeWithFont:(UIFont *)font maxSize:(CGSize)maxSize maxNumberOfLines:(NSUInteger)numberOfLine {
    if (maxSize.width <= 0 || maxSize.height <= 0) {
        return CGSizeZero;
    }
    NSDictionary *dict = @{ NSFontAttributeName : font };
    CGSize size = [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:dict context:nil].size;
    if (size.height > font.lineHeight * numberOfLine && numberOfLine > 0) {
        size.height = font.lineHeight * numberOfLine;
    }
    size.height = ceil(size.height);
    size.width = ceil(size.width);
    return size;
}

@end
