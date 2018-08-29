//
//  TTCategory.m
//  TTNewsSDK
//
//  Created by 梁志远 on 2018/8/26.
//  Copyright © 2018年 梁志远. All rights reserved.
//

#import "TTCategory.h"
#import "NSString+Extension.h"

@implementation TTCategory

- (CGFloat)textWidth {
    if (_textWidth == 0 && _name.length > 0) {
        _textWidth = [_name widthWithFont:[UIFont systemFontOfSize:16]] + 28;
    }
    return _textWidth;
}

// 如果实现了该方法，则处理过程中会忽略该列表内的所有属性
+ (NSArray *)modelPropertyBlacklist {
    return @[
             @"textWidth",
             @"isSelected"
             ];
}

@end
