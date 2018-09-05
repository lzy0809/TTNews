//
//  TTErrorView.h
//  TTNewsSDK
//
//  Created by 梁志远 on 2018/9/1.
//  Copyright © 2018年 梁志远. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TTErrorView : UIView

@property (nonatomic, copy) void (^refreshData)(void);

@end
