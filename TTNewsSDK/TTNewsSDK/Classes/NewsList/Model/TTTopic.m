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

//+ (NSDictionary *)modelContainerPropertyGenericClass {
//    return @{
//             @"image_list" : [TTMiddleImage class]
//             };
//}

// 如果实现了该方法，则处理过程中会忽略该列表内的所有属性
+ (NSArray *)modelPropertyBlacklist {
    return @[
             @"channel",
             @"rownum",
             @"cellHeight",
             @"frame",
             @"pic_url",
             @"draw_type"
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

- (TTCellType)draw_type {
    if ([_has_video boolValue]) {
        if ([_video_style integerValue] == 0) { //单图
            _draw_type = TTCellTypeRightPic;
        } else if ([_video_style integerValue] == 2) {// [_video_style integerValue] == 2 大图
            _draw_type = TTCellTypeArticlePic;
        } else {
            _draw_type = TTCellTypeOther;
        }
    } else {
        if (_middle_image.url.length == 0 && _middle_image.url_list.count == 0) {
            _draw_type = TTCellTypePureTitle;
        } else {
            if (_middle_image.url.length > 0 && _middle_image.url_list.count == 0) {
                _draw_type = TTCellTypeRightPic;
            } else {
                if (_middle_image.url_list.count == 1) {
                    _draw_type = TTCellTypeRightPic;
                } else {
                    _draw_type = TTCellTypeGroupPic;
                }
            }
        }
    }
    return _draw_type;
}

- (CGFloat)cellHeight {
//    if (_cellHeight == 0) {
        switch (_draw_type) {
            case TTCellTypePureTitle:
            {
                CGFloat titleH = [_title sizeWithConstrainedWidth:ScreenWidth - kMargin - kMargin font:TTFontSize(17) lineSpace:2].height;
                _cellHeight = kMargin + titleH + kMargin + kLineHeight;
            }
                break;
            case TTCellTypeRightPic:
                _cellHeight = kMargin + kImageH + kMargin + kLineHeight;
                break;
            case TTCellTypeGroupPic:
            {
                CGFloat titleH = [_title sizeWithConstrainedWidth:ScreenWidth - kMargin - kMargin font:TTFontSize(17) lineSpace:2].height;
                _cellHeight = kMargin + titleH + kMargin + kImageH + kMargin + kLineHeight;
            }
                break;
            default:
                _cellHeight = 40;
                break;
        }
//        NSLog(@"会不会一直调%.2f", _cellHeight);
//    }
    return _cellHeight;
}

- (void)drawPureTitleWithContext:(CGContextRef)context {
    CGFloat titleW = ScreenWidth - kMargin * 2;
//    CGFloat titleH = [_title sizeWithConstrainedWidth:titleW font:TTFontSize(17) lineSpace:2].height;
    [_title drawInContext:context position:CGPointMake(kMargin, kMargin) font:TTFontSize(17) textColor:[UIColor colorForHex:@"#222222"] height:_cellHeight width:titleW];
    
    [[UIColor colorForHex:@"#e8e8e8"] set];
    CGContextFillRect(context, CGRectMake(kMargin, _cellHeight - kLineHeight, titleW, kLineHeight));
}

- (void)drawRightPicWithContext:(CGContextRef)context {
//    CGFloat imgX = ScreenWidth - kMargin - kImageW;
    CGFloat titleW = ScreenWidth - kMargin - 16 - kImageW - kMargin;
    CGFloat titleH = [_title sizeWithConstrainedWidth:titleW font:TTFontSize(17) lineSpace:2].height;
    [_title drawInContext:context position:CGPointMake(kMargin, kMargin) font:TTFontSize(17) textColor:[UIColor colorForHex:@"#222222"] height:titleH width:titleW];
    
//    [[UIColor orangeColor] set];
//    CGContextFillRect(context, CGRectMake(imgX, kMargin, kImageW, kImageH));
    
    [[UIColor colorForHex:@"#e8e8e8"] set];
    CGContextFillRect(context, CGRectMake(kMargin, _cellHeight - kLineHeight, titleW, kLineHeight));
}

- (void)drawGroupPicWithContext:(CGContextRef)context {
    CGFloat titleW = ScreenWidth - kMargin * 2;
    CGFloat titleH = [_title sizeWithConstrainedWidth:titleW font:TTFontSize(17) lineSpace:2].height;
    [_title drawInContext:context position:CGPointMake(kMargin, kMargin) font:TTFontSize(17) textColor:[UIColor colorForHex:@"#222222"] height:titleH width:titleW];
    
    [[UIColor colorForHex:@"#e8e8e8"] set];
    CGContextFillRect(context, CGRectMake(kMargin, _cellHeight - kLineHeight, titleW, kLineHeight));
}

- (void)drawUNKnowWithContext:(CGContextRef)context {
    CGFloat titleW = ScreenWidth - kMargin * 2;
    CGFloat titleH = [@"暂时不支持的新闻类型" sizeWithConstrainedWidth:titleW font:TTFontSize(17) lineSpace:2].height;
    [@"暂时不支持的新闻类型" drawInContext:context position:CGPointMake(kMargin, kMargin) font:TTFontSize(17) textColor:[UIColor colorForHex:@"#222222"] height:titleH width:titleW];
    
    [[UIColor colorForHex:@"#e8e8e8"] set];
    CGContextFillRect(context, CGRectMake(kMargin, _cellHeight - kLineHeight, titleW, kLineHeight));
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
