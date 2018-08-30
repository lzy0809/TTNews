//
//  TTNewsBaseCell.m
//  TTNewsSDK
//
//  Created by liang on 2018/8/28.
//  Copyright © 2018 梁志远. All rights reserved.
//

#import "TTNewsBaseCell.h"
#import "TTTopic.h"
#import <YYWebImage/YYWebImage.h>
#import "NSString+Extension.h"

@interface TTNewsBaseCell ()
@property (nonatomic, assign) BOOL isDrawing;
@property (nonatomic, strong) UIImageView *BGView;
@end

@implementation TTNewsBaseCell

- (void)setTopic:(TTTopic *)topic {
    _topic = topic;
    
    if (self.isDrawing) {
        return;
    }
    self.isDrawing = YES;
    TTWeakSelf
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        CGRect rect = CGRectMake(0, 0, ScreenWidth, 150);
        UIGraphicsBeginImageContextWithOptions(rect.size, YES, [UIScreen mainScreen].scale);
        CGContextRef context = UIGraphicsGetCurrentContext();
        [[UIColor colorForHex:@"#ffffff"] set];
        CGContextFillRect(context, rect);
        
        if ([topic.has_video boolValue]) {
            if ([topic.video_style integerValue] == 0) { //单图
                [weakSelf drawRightPicWithContext:context topic:topic];
            }
            else if ([topic.video_style integerValue] == 2) {
//                identifier = @"TTArticlePicView"; 大图
            }
        } else {
            if (topic.middle_image.url.length == 0 && topic.middle_image.url_list.count == 0) {
                [weakSelf drawPureTitleWithContext:context topic:topic];
            } else {
                if (topic.middle_image.url.length > 0 && topic.middle_image.url_list.count == 0) {
                    [weakSelf drawRightPicWithContext:context topic:topic];
                } else {
                    if (topic.middle_image.url_list.count == 1) {
                        [weakSelf drawRightPicWithContext:context topic:topic];
                    } else {
                        [weakSelf drawGroupPicWithContext:context topic:topic];
                    }
                }
            }
        }
        
        UIImage *temp = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        dispatch_async(dispatch_get_main_queue(), ^{
            weakSelf.BGView.frame = rect;
            weakSelf.BGView.image = temp;
            weakSelf.cellH = CGRectGetMaxY(rect);
        });
        
    });
}

- (void)clear {
    if (!self.isDrawing) {
        return;
    }
    self.BGView.frame = CGRectZero;
    self.BGView.image = nil;
    self.isDrawing = NO;
}

- (void)drawPureTitleWithContext:(CGContextRef)context topic:(TTTopic *)topic {
    CGFloat titleW = ScreenWidth - kMargin * 2;
    CGFloat titleH = [topic.title sizeWithConstrainedWidth:titleW font:[UIFont systemFontOfSize:17] lineSpace:2].height;
    [topic.title drawInContext:context position:CGPointMake(kMargin, 14) font:[UIFont systemFontOfSize:17] textColor:[UIColor colorForHex:@"#222222"] height:titleH width:titleW];
}

- (void)drawRightPicWithContext:(CGContextRef)context topic:(TTTopic *)topic {
    CGFloat imgX = self.width - kMargin - kImageW;
    CGFloat titleW = imgX - kMargin - 16;
    CGFloat titleH = [topic.title sizeWithConstrainedWidth:titleW font:[UIFont systemFontOfSize:17] lineSpace:2].height;
    [topic.title drawInContext:context position:CGPointMake(kMargin, 14) font:[UIFont systemFontOfSize:17] textColor:[UIColor colorForHex:@"#222222"] height:titleH width:titleW];
    
    [[UIColor orangeColor] set];
    CGContextFillRect(context, CGRectMake(imgX, 14, kImageW, kImageH));
}

- (void)drawGroupPicWithContext:(CGContextRef)context topic:(TTTopic *)topic {
    CGFloat titleW = self.width - kMargin * 2;
    CGFloat titleH = [topic.title sizeWithConstrainedWidth:titleW font:[UIFont systemFontOfSize:17] lineSpace:2].height;
    [topic.title drawInContext:context position:CGPointMake(kMargin, 14) font:[UIFont systemFontOfSize:17] textColor:[UIColor colorForHex:@"#222222"] height:titleH width:titleW];
    CGFloat imgY = 14 + titleH + 7;
    [[UIColor orangeColor] set];
    CGContextFillRect(context, CGRectMake(kMargin, imgY, kImageW, kImageH));
    
    [[UIColor orangeColor] set];
    CGContextFillRect(context, CGRectMake(kMargin+kImageW+3, imgY, kImageW, kImageH));
    
    [[UIColor orangeColor] set];
    CGContextFillRect(context, CGRectMake(kMargin+kImageW*2+6, imgY, kImageW, kImageH));
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

+ (instancetype)cellWithTableView:(UITableView *)tableView topic:(TTTopic *)topic {
    NSString *identifier = [self cellIdentifier:topic];
    TTNewsBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[NSClassFromString(identifier) alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    return cell;
}

+ (NSString *)cellIdentifier:(TTTopic *)topic {
    NSString *identifier = @"TTNewsBaseCell";
    if ([topic.has_video boolValue]) {
        if ([topic.video_style integerValue] == 0) {
            identifier = @"TTLayOutRightPicCell";
        }
        else if ([topic.video_style integerValue] == 2) {
            identifier = @"TTArticlePicView";
        }
    } else {
        if (topic.middle_image.url.length == 0 && topic.middle_image.url_list.count == 0) {
            identifier = @"TTLayOutPureTitleCell";
        } else {
            if (topic.middle_image.url.length > 0 && topic.middle_image.url_list.count == 0) {
                identifier = @"TTLayOutRightPicCell";
            } else {
                if (topic.middle_image.url_list.count == 1) {
                    identifier = @"TTLayOutRightPicCell";
                } else {
                    identifier = @"TTLayOutGroupPicCell";
                }
            }
        }
    }
    //    NSLog(@"cell========%@",identifier);
    return @"TTNewsBaseCell";
}

- (UIImageView *)BGView {
    if (_BGView == nil) {
        _BGView = [[UIImageView alloc] init];
        [self.contentView addSubview:_BGView];
    }
    return _BGView;
}

@end
