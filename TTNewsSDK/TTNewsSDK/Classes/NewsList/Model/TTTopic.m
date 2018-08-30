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
//    if ([topic.has_video boolValue]) {
//        if ([topic.video_style integerValue] == 0) {
//            identifier = @"TTLayOutRightPicCell";
//        }
//        else if ([topic.video_style integerValue] == 2) {
//            identifier = @"TTArticlePicView";
//        }
//    } else {
//        if (topic.middle_image.url.length == 0 && topic.middle_image.url_list.count == 0) {
//            identifier = @"TTLayOutPureTitleCell";
//        } else {
//            if (topic.middle_image.url.length > 0 && topic.middle_image.url_list.count == 0) {
//                identifier = @"TTLayOutRightPicCell";
//            } else {
//                if (topic.middle_image.url_list.count == 1) {
//                    identifier = @"TTLayOutRightPicCell";
//                } else {
//                    identifier = @"TTLayOutGroupPicCell";
//                }
//            }
//        }
//    }
//    CGFloat H = 0;
//    if ([_has_video boolValue]) {
//        if ([_video_style integerValue] == 0) {
//
//            CGFloat titleW = ScreenWidth - kMargin - kImageW - kMargin + 16;
//            CGFloat titleH = [_title sizeWithFont:[UIFont systemFontOfSize:17] maxSize:CGSizeMake(titleW, MAXFLOAT) maxNumberOfLines:3].height;
//            self.titleLabel.frame = CGRectMake(kMargin, 14, titleW, titleH);
//            H = 14 + kImageH;
//        }
//        else if ([_video_style integerValue] == 2) {
//            return 100;
//        }
//    } else {
//        if (_middle_image.url.length == 0 && _middle_image.url_list.count == 0) {
//            return 87;
//        } else {
//            if (_middle_image.url.length > 0 && _middle_image.url_list.count == 0) {
//                return 90;
//            } else {
//                if (_middle_image.url_list.count == 1) {
//                    return 90;
//                } else {
//                    return 140;
//                }
//            }
//        }
//    }
    return 50;
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
