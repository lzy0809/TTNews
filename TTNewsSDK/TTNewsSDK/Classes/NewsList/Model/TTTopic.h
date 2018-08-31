//
//  TTTopic.h
//  TTNewsSDK
//
//  Created by liang on 2018/8/28.
//  Copyright © 2018 梁志远. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TTCellType){
    /** 纯文本 */
    TTCellTypePureTitle = 0,
    /** 右边有图 */
    TTCellTypeRightPic = 1,
    /** 多图 */
    TTCellTypeGroupPic = 2,
    /** 大图 */
    TTCellTypeArticlePic = 3,
    /** 其他 */
    TTCellTypeOther = 4,
};


@interface TTURLList : NSObject
@property (nonatomic, copy) NSString *url;
@end

@interface TTMiddleImage : NSObject
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, copy) NSString *uri;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, strong) NSArray <TTURLList *> *url_list;
@property (nonatomic, assign) CGFloat width;
@end

@interface TTTopicFilter : NSObject
@property (nonatomic, copy) NSString *filterID;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) BOOL is_selected;
@end


/**
 新闻model
 */
@interface TTTopic : NSObject

/** 新闻详情url */
@property (nonatomic, copy) NSString *article_url;
@property (nonatomic, strong) NSArray *filter_words;
@property (nonatomic, copy) NSString *media_name;// 掌阅文学
@property (nonatomic, copy) NSString *source;
@property (nonatomic, strong) TTMiddleImage *middle_image;
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *abstract;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, strong) NSNumber *video_style;
@property (nonatomic, strong) NSNumber *has_video;

@property (nonatomic, copy) NSString *channel;
@property (nonatomic, strong) NSNumber *rownum;
@property (nonatomic, assign) CGFloat cellHeight;
@property (nonatomic, assign) CGRect frame;
@property (nonatomic, copy) NSString *pic_url;
@property (nonatomic, assign) TTCellType draw_type;
@end

@interface TTTopicTip : NSObject
@property (nonatomic, copy) NSString *app_name;
@property (nonatomic, strong) NSNumber *display_duration;
@property (nonatomic, copy) NSString *display_info;
@end


@interface TTTopicNode : NSObject
@property (nonatomic, strong) NSArray *data;
@property (nonatomic, strong) NSArray *tips;
@property (nonatomic, strong) NSNumber *total_number;
@property (nonatomic, copy) NSString *message;
@end


