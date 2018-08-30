//
//  TTTopic.m
//  TTNewsSDK
//
//  Created by liang on 2018/8/28.
//  Copyright © 2018 梁志远. All rights reserved.
//

#import "TTTopic.h"
#import <YYModel/YYModel.h>
#import "NSString+Extension.h"

@implementation TTURLList
@end

@implementation TTMiddleImage
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{ @"url_list" : [TTURLList class] };
}
@end

@implementation TTTopicFilter
//返回一个 Dict，将 Model 属性名对映射到 JSON 的 Key。
+ (NSDictionary *)modelCustomPropertyMapper {
    return @{@"filterID" : @"id"};
}

@end

@implementation TTTopic

- (NSString *)abstract {
    return _abstract.length == 0 ? @"接口没有返回有效数据" : _abstract;
}

+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"image_list" : [TTMiddleImage class]
             };
}

// 如果实现了该方法，则处理过程中会忽略该列表内的所有属性
+ (NSArray *)modelPropertyBlacklist {
    return @[
             @"channel",
             @"rownum",
             @"cellHeight",
             @"frame",
             @"pic_url"
             ];
}

- (NSString *)pic_url {
    if (_middle_image.url.length > 0) {
        return _middle_image.url;
    } else {
        if (_middle_image.url_list.count > 0) {
            return _middle_image.url_list[0].url;
        }
    }
    return @"http://p3.pstatp.com/list/300x196/pgc-image/ede2003ab4864c30a33194a98cea6f03.webp";
}

- (CGFloat)cellHeight {
    if (_cellHeight == 0) {
        CGFloat H = 0;
        if ([_has_video boolValue]) {
            if ([_video_style integerValue] == 0) { //单图
                H = 14 + kImageH + 14 + kLineHeight;
            }
            else {// [_video_style integerValue] == 2 大图
                return 40;
            }
        } else {
            if (_middle_image.url.length == 0 && _middle_image.url_list.count == 0) {
                CGFloat titleH = [_title sizeWithConstrainedWidth:ScreenWidth - kMargin - kImageW font:[UIFont systemFontOfSize:17] lineSpace:2].height;
                H = 14 + titleH + 14 + kLineHeight;
            } else {
                if (_middle_image.url.length > 0 && _middle_image.url_list.count == 0) {
                    H = 14 + kImageH + 14 + kLineHeight;
                } else {
                    if (_middle_image.url_list.count == 1) {
                        H = 14 + kImageH + 14 + kLineHeight;
                    } else {
                        CGFloat titleH = [_title sizeWithConstrainedWidth:ScreenWidth - kMargin - kImageW font:[UIFont systemFontOfSize:17] lineSpace:2].height;
                        H = 14 + titleH + 14 + kImageH + 14 + kLineHeight;
                    }
                }
            }
        }
        _cellHeight = ceil(H);
    }
    return _cellHeight;
}


@end

@implementation TTTopicTip
@end

@implementation TTTopicNode
+ (NSDictionary *)modelContainerPropertyGenericClass {
    return @{
             @"data" : [TTTopic class],
             @"tips" : [TTTopicTip class]
             };
}
@end
