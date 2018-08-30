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

@interface TTLayOutRightPicCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *rightImageView;

@end

@implementation TTLayOutRightPicCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.rightImageView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat imgX = self.width - kMargin - kImageW;
    CGFloat imgY = 14;
    self.rightImageView.frame = CGRectMake(imgX, imgY, kImageW, kImageH);
    
    CGFloat titleW = imgX - kMargin - 16;
    CGFloat titleH = [self.topic.title sizeWithFont:[UIFont systemFontOfSize:17] maxSize:CGSizeMake(titleW, MAXFLOAT) maxNumberOfLines:2].height;
    self.titleLabel.frame = CGRectMake(kMargin, 14, titleW, titleH);
}

- (void)setTopic:(TTTopic *)topic {
    [super setTopic:topic];
    
    
    
    
    
    
    self.titleLabel.text = topic.title;
    
    
    
    NSString *url;
    if (topic.middle_image.url.length > 0) {
        url = topic.middle_image.url;
    } else {
        TTURLList *mode = topic.middle_image.url_list[0];
        url = mode.url;
    }
    [self.rightImageView yy_setImageWithURL:[NSURL URLWithString:url] placeholder:nil];//@"http://p3.pstatp.com/list/300x196/pgc-image/ede2003ab4864c30a33194a98cea6f03.webp"
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

- (UIImageView *)rightImageView {
    if ( _rightImageView == nil) {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.backgroundColor = [UIColor lightTextColor];
    }
    return _rightImageView;
}

@end
