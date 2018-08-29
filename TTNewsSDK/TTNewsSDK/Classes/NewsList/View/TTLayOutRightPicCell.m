//
//  TTLayOutRightPicCell.m
//  TTNewsSDK
//
//  Created by 梁志远 on 2018/8/28.
//  Copyright © 2018年 梁志远. All rights reserved.
//

#import "TTLayOutRightPicCell.h"
#import "NSString+Extension.h"
#import "TTTopic.h"
#import "YYWebImage.h"

static CGFloat const kMargin = 15;  //边距

@interface TTLayOutRightPicCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) UIView *statusView;
@end

@implementation TTLayOutRightPicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.rightImageView];
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
    self.rightImageView.frame = CGRectMake(imgX, imgY, imgW, imgH);
    
    CGFloat titleW = imgX - kMargin - 16;
    CGFloat titleH = [self.topic.abstract sizeWithFont:[UIFont systemFontOfSize:19] maxSize:CGSizeMake(titleW, MAXFLOAT) maxNumberOfLines:3].height;
    self.titleLabel.frame = CGRectMake(kMargin, 14, titleW, titleH);
    
    self.statusView.frame = CGRectMake(0, self.rightImageView.bottom + 7, self.width, 36);
}

- (void)setTopic:(TTTopic *)topic {
    [super setTopic:topic];
    
    self.titleLabel.text = topic.abstract;
    
    [self.rightImageView yy_setImageWithURL:[NSURL URLWithString:@"http://p3.pstatp.com/list/300x196/pgc-image/ede2003ab4864c30a33194a98cea6f03.webp"] placeholder:nil];
    if (topic.image_list.count > 0) {
        TTMiddleImage *media_image = topic.image_list[0];
        NSLog(@"11有没有值%@", media_image.url);
        [self.rightImageView yy_setImageWithURL:[NSURL URLWithString:media_image.url] placeholder:nil];
    }
    if (topic.middle_image.url_list.count > 0) {
        TTURLList *list = topic.middle_image.url_list[0];
        NSLog(@"22有没有值%@", list.url);
        [self.rightImageView yy_setImageWithURL:[NSURL URLWithString:list.url] placeholder:nil];
    }
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

- (UIImageView *)rightImageView {
    if ( _rightImageView == nil) {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.backgroundColor = [UIColor lightTextColor];
    }
    return _rightImageView;
}

- (UIView *)statusView {
    if (_statusView == nil) {
        _statusView = [[UIView alloc] init];
        _statusView.backgroundColor = [UIColor redColor];
    }
    return _statusView;
}

@end
