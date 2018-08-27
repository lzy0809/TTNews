//
//  TTCategory.h
//  TTNewsSDK
//
//  Created by 梁志远 on 2018/8/26.
//  Copyright © 2018年 梁志远. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GYDataCenter/GYDataCenter.h>

@interface TTCategory : GYModelObject
@property (nonatomic, copy) NSString *category;
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *concern_id;
@property (nonatomic, copy) NSString *icon_url;
@property (nonatomic, copy) NSString *web_url;
@property (nonatomic, assign) NSInteger flages;
@property (nonatomic, assign) NSInteger tip_new;
@property (nonatomic, assign) NSInteger type;

@property (nonatomic, assign) CGFloat textWidth;
@end
