//
//  TTTopic.h
//  TTNewsSDK
//
//  Created by liang on 2018/8/28.
//  Copyright © 2018 梁志远. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTAction : NSObject
@property (nonatomic, copy) NSString *action;
@property (nonatomic, copy) NSString *desc;
@property (nonatomic, strong) NSDictionary *extra;
@end

@interface TTFilter : NSObject
@property (nonatomic, copy) NSString *id;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) BOOL is_selected;
@property (nonatomic, strong) NSDictionary *extra;
@end

@interface TTURLList : NSObject
@property (nonatomic, copy) NSString *url;
@end

@interface TTMiddleImage : NSObject
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, copy) NSString *uri;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, strong) NSArray *url_list;
@property (nonatomic, assign) CGFloat width;
@end


@interface TTTopic : NSObject
@property (nonatomic, copy) NSString *abstract;
//@property (nonatomic, strong) NSArray *action_list;
@property (nonatomic, assign) NSInteger aggr_type;
@property (nonatomic, assign) BOOL allow_download;
@property (nonatomic, assign) NSInteger article_sub_type;
@property (nonatomic, assign) NSInteger article_type;
/** 新闻详情url */
@property (nonatomic, copy) NSString *article_url;
@property (nonatomic, strong) TTMiddleImage *middle_image;
@property (nonatomic, strong) NSArray *image_list;

@property (nonatomic, assign) NSInteger ban_comment;
@property (nonatomic, copy) NSString *behot_time;
@property (nonatomic, assign) NSInteger bury_count;
@property (nonatomic, assign) NSInteger cell_flag;
@property (nonatomic, assign) NSInteger cell_layout_style;
@property (nonatomic, assign) NSInteger cell_type;
@property (nonatomic, assign) NSInteger comment_count;
@property (nonatomic, copy) NSString *content_decoration;
@property (nonatomic, copy) NSString *cursor;
@property (nonatomic, assign) NSInteger digg_count;
@property (nonatomic, copy) NSString *display_url;
//@property (nonatomic, strong) NSArray *filter_words;
@property (nonatomic, strong) NSDictionary *forward_info; //{forward_count : 13}
@property (nonatomic, copy) NSString *group_id;
@property (nonatomic, assign) BOOL has_m3u8_video;
@property (nonatomic, assign) NSInteger has_mp4_video;
@property (nonatomic, assign) BOOL has_video;
@property (nonatomic, assign) NSInteger hot;
@property (nonatomic, assign) NSInteger ignore_web_transform;
@property (nonatomic, copy) NSString *interaction_data;
@property (nonatomic, assign) BOOL is_stick;
@property (nonatomic, assign) BOOL is_subject;
@property (nonatomic, copy) NSString *item_id;
@property (nonatomic, assign) NSInteger item_version;
@property (nonatomic, copy) NSString *keywords;
@property (nonatomic, copy) NSString *label;
//@property (nonatomic, strong) label_extra
@property (nonatomic, copy) NSString *title;

@property (nonatomic, copy) NSString *channel;
@property (nonatomic, assign) NSNumber *rownum;

@end


