//
//  TTChannelViewCell.h
//  TTNewsSDK
//
//  Created by liang on 2018/8/27.
//  Copyright © 2018 梁志远. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TTCategory;

NS_ASSUME_NONNULL_BEGIN

@interface TTChannelViewCell : UICollectionViewCell
@property (nonatomic, strong) TTCategory *channel;

- (void)updateColor:(CGFloat )percent;

@end

NS_ASSUME_NONNULL_END
