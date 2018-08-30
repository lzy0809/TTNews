//
//  TTLayOutGroupPicCell.m
//  TTNewsSDK
//
//  Created by liang on 2018/8/30.
//  Copyright © 2018 梁志远. All rights reserved.
//

#import "TTLayOutGroupPicCell.h"
#import "NSString+Extension.h"
#import "TTTopic.h"
#import "YYWebImage.h"

@interface TTLayOutGroupPicCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *middleImageView;
@property (nonatomic, strong) UIImageView *rightImageView;
@end

@implementation TTLayOutGroupPicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.leftImageView];
        [self.contentView addSubview:self.middleImageView];
        [self.contentView addSubview:self.rightImageView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat titleW = self.width - kMargin * 2;
    CGFloat titleH = [self.topic.title sizeWithFont:[UIFont systemFontOfSize:17] maxSize:CGSizeMake(titleW, MAXFLOAT) maxNumberOfLines:2].height;
    self.titleLabel.frame = CGRectMake(kMargin, 14, titleW, titleH);
    
    CGFloat imgW = (self.width - kMargin * 2 - 3 * 2) / 3;
    CGFloat imgY = self.titleLabel.bottom + 7;
    CGFloat imgH = imgW / 1.54;
    self.leftImageView.frame = CGRectMake(kMargin, imgY, imgW, imgH);
    self.middleImageView.frame = CGRectMake(self.leftImageView.right + 3, imgY, imgW, imgH);
    self.rightImageView.frame = CGRectMake(self.middleImageView.right + 3, imgY, imgW, imgH);
}

- (void)setTopic:(TTTopic *)topic {
    [super setTopic:topic];
    
    self.titleLabel.text = topic.title;
    
    if (topic.middle_image.url_list.count >= 3) {
        [self.leftImageView yy_setImageWithURL:[NSURL URLWithString:topic.middle_image.url_list[0].url] placeholder:nil];
        [self.leftImageView yy_setImageWithURL:[NSURL URLWithString:topic.middle_image.url_list[1].url] placeholder:nil];
        [self.leftImageView yy_setImageWithURL:[NSURL URLWithString:topic.middle_image.url_list[2].url] placeholder:nil];
    }
}


- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:17];
        _titleLabel.numberOfLines = 2;
        _titleLabel.lineBreakMode = NSLineBreakByTruncatingTail;
        _titleLabel.textAlignment = NSTextAlignmentLeft;
    }
    return _titleLabel;
}

- (UIImageView *)leftImageView {
    if ( _leftImageView == nil) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.backgroundColor = [UIColor lightTextColor];
    }
    return _leftImageView;
}

- (UIImageView *)middleImageView {
    if ( _middleImageView == nil) {
        _middleImageView = [[UIImageView alloc] init];
        _middleImageView.backgroundColor = [UIColor lightTextColor];
    }
    return _middleImageView;
}

- (UIImageView *)rightImageView {
    if ( _rightImageView == nil) {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.backgroundColor = [UIColor lightTextColor];
    }
    return _rightImageView;
}

@end
