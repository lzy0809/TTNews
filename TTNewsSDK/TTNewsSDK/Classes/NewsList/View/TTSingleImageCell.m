//
//  TTSingleImageCell.m
//  TTNewsSDK
//
//  Created by 梁志远 on 2018/8/28.
//  Copyright © 2018年 梁志远. All rights reserved.
//

#import "TTSingleImageCell.h"
#import "NSString+Extension.h"
#import "TTTopic.h"
//#import ""

static CGFloat const kMargin = 15;  //边距

@interface TTSingleImageCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *singleImageView;
@property (nonatomic, strong) UIView *statusView;
@end

@implementation TTSingleImageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.singleImageView];
        [self.contentView addSubview:self.statusView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat imgW = (self.width - kMargin * 2 - 3 * 2) / 3;
    CGFloat imgX = self.width - kMargin - imgW;
    CGFloat imgY = 14;
    CGFloat imgH = imgW / 1.54;
    self.singleImageView.frame = CGRectMake(imgX, imgY, imgW, imgH);
    
    CGFloat titleW = imgX - kMargin - 16;
    CGFloat titleH = [self.topic.abstract sizeWithFont:[UIFont systemFontOfSize:19] maxSize:CGSizeMake(titleW, MAXFLOAT) maxNumberOfLines:3].height;
    self.titleLabel.frame = CGRectMake(kMargin, 14, titleW, titleH);
    
    self.statusView.frame = CGRectMake(0, self.singleImageView.bottom + 7, self.width, 36);
}

- (void)setTopic:(TTTopic *)topic {
    [super setTopic:topic];
    
    self.titleLabel.text = topic.abstract;
}


- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:19];
        _titleLabel.numberOfLines = 3;
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (UIImageView *)singleImageView {
    if ( _singleImageView == nil) {
        _singleImageView = [[UIImageView alloc] init];
        _singleImageView.backgroundColor = [UIColor orangeColor];
    }
    return _singleImageView;
}

- (UIView *)statusView {
    if (_statusView == nil) {
        _statusView = [[UIView alloc] init];
        _statusView.backgroundColor = [UIColor redColor];
    }
    return _statusView;
}

@end
