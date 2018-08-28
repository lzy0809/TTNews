//
//  TTChannelViewCell.m
//  TTNewsSDK
//
//  Created by liang on 2018/8/27.
//  Copyright © 2018 梁志远. All rights reserved.
//

#import "TTChannelViewCell.h"
#import "TTCategory.h"

@interface TTChannelViewCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation TTChannelViewCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

- (void)setChannel:(TTCategory *)channel {
    _channel = channel;
    self.titleLabel.text = channel.name;
    self.titleLabel.textColor = channel.isSelected ? [UIColor colorForHex:@"#D43D3CFF"] : [UIColor colorForHex:@"#000000FF"];
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.titleLabel.frame = self.contentView.frame;
}

- (void)updateColor:(CGFloat)percent {
    CGFloat R = (0x00 * percent + 0xd3 * (1 - percent)) / 255.0;
    CGFloat G = (0x00 * percent + 0x3d * (1 - percent)) / 255.0;
    CGFloat B = (0x00 * percent + 0x3c * (1 - percent)) / 255.0;
    self.titleLabel.textColor = [UIColor colorWithRed:R green:G blue:B alpha:1];
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont boldSystemFontOfSize:16];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _titleLabel;
}

@end
