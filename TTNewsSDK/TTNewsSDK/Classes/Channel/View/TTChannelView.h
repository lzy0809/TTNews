//
//  TTChannelView.h
//  TTNewsSDK
//
//  Created by liang on 2018/8/27.
//  Copyright © 2018 梁志远. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TTChannelView;

@protocol TTChannelDelegate <NSObject>

@optional
- (void)channelViewDidSelectedIndex:(NSInteger )index;

@end


@interface TTChannelView : UIView

@property (nonatomic, weak) id<TTChannelDelegate>delegate;

- (void)channelViewScrollToIndex:(NSInteger )index;

- (void)refreshData:(void (^)(NSArray *channels))complation;

- (void)updateStatusWithProgress:(CGFloat )progress sourceIndex:(NSInteger )sourceIndex targetIndex:(NSInteger )targetIndex;

@end
