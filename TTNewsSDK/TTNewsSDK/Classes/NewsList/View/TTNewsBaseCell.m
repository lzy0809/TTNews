//
//  TTNewsBaseCell.m
//  TTNewsSDK
//
//  Created by liang on 2018/8/28.
//  Copyright © 2018 梁志远. All rights reserved.
//

#import "TTNewsBaseCell.h"
#import "TTTopic.h"
#import <YYWebImage/YYWebImage.h>
#import "NSString+Extension.h"

@interface TTNewsBaseCell ()
//@property (nonatomic, strong) UIImageView *BGView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *leftImageView;
@property (nonatomic, strong) UIImageView *middleImageView;
@property (nonatomic, strong) UIImageView *rightImageView;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation TTNewsBaseCell

+ (instancetype)cellWithTableView:(UITableView *)tableView {
    TTNewsBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TTNewsBaseCell"];
    if (cell == nil) {
        cell = [[TTNewsBaseCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"TTNewsBaseCell"];
        cell.contentView.backgroundColor = [UIColor colorForHex:@"#ffffff"];
    }
    return cell;
}

- (void)setTopic:(TTTopic *)topic {
    _topic = topic;
    
    self.titleLabel.text = topic.title;
    
    if (topic.draw_type == TTCellTypeRightPic) {
        [self.rightImageView yy_setImageWithURL:[NSURL URLWithString:topic.pic_url] placeholder:nil];
    } else if (topic.draw_type == TTCellTypeGroupPic) {
        [self.leftImageView yy_setImageWithURL:[NSURL URLWithString:topic.middle_image.url_list[0].url] placeholder:nil];
        [self.middleImageView yy_setImageWithURL:[NSURL URLWithString:topic.middle_image.url_list[1].url] placeholder:nil];
        [self.rightImageView yy_setImageWithURL:[NSURL URLWithString:topic.middle_image.url_list[2].url] placeholder:nil];
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
//    self.BGView.frame = CGRectMake(0, 0, self.width, self.topic.cellHeight);
    switch (self.topic.draw_type) {
        case TTCellTypePureTitle:
        {
            self.leftImageView.hidden = YES;
            self.middleImageView.hidden = YES;
            self.rightImageView.hidden = YES;
            CGFloat titleH = [self.titleLabel.text sizeWithFont:TTFontSize(17) maxSize:CGSizeMake(self.width - kMargin * 2, MAXFLOAT) maxNumberOfLines:2].height;
            self.titleLabel.frame = CGRectMake(kMargin, kMargin, self.width - kMargin * 2, titleH);
        }
            break;
        case TTCellTypeRightPic:
        {
            self.leftImageView.hidden = YES;
            self.middleImageView.hidden = YES;
            self.rightImageView.hidden = NO;
            CGFloat titleW = ScreenWidth - kMargin - 16 - kImageW - kMargin;
            CGFloat titleH = [self.titleLabel.text sizeWithFont:TTFontSize(17) maxSize:CGSizeMake(titleW, MAXFLOAT) maxNumberOfLines:2].height;
            self.titleLabel.frame = CGRectMake(kMargin, kMargin, titleW, titleH);
            self.rightImageView.frame = CGRectMake(self.width - kImageW - kMargin, 14, kImageW, kImageH);
        }
            break;
        case TTCellTypeGroupPic:
        {
            self.leftImageView.hidden = NO;
            self.middleImageView.hidden = NO;
            self.rightImageView.hidden = NO;
            CGFloat titleH = [self.titleLabel.text sizeWithFont:TTFontSize(17) maxSize:CGSizeMake(self.width - kMargin * 2, MAXFLOAT) maxNumberOfLines:2].height;
            self.titleLabel.frame = CGRectMake(kMargin, kMargin, self.width - kMargin * 2, titleH);
            self.leftImageView.frame = CGRectMake(kMargin, 14 + titleH + 14, kImageW, kImageH);
            self.middleImageView.frame = CGRectMake(self.leftImageView.right + 3, self.leftImageView.y, kImageW, kImageH);
            self.rightImageView.frame = CGRectMake(self.middleImageView.right + 3, self.middleImageView.y, kImageW, kImageH);
        }
            break;
        default:
            self.leftImageView.hidden = YES;
            self.middleImageView.hidden = YES;
            self.rightImageView.hidden = YES;
            break;
    }
    self.lineView.frame = CGRectMake(kMargin, self.topic.cellHeight - kLineHeight, self.width - kMargin * 2, kLineHeight);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (UILabel *)titleLabel {
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.textColor = [UIColor colorForHex:@"#222222"];
        _titleLabel.textAlignment = NSTextAlignmentLeft;
        _titleLabel.numberOfLines = 2;
        [self.contentView addSubview:_titleLabel];
    }
    return _titleLabel;
}

- (UIImageView *)leftImageView {
    if (_leftImageView == nil) {
        _leftImageView = [[UIImageView alloc] init];
        _leftImageView.hidden = YES;
        [self.contentView addSubview:_leftImageView];
    }
    return _leftImageView;
}

- (UIImageView *)middleImageView {
    if (_middleImageView == nil) {
        _middleImageView = [[UIImageView alloc] init];
        _middleImageView.hidden = YES;
        [self.contentView addSubview:_middleImageView];
    }
    return _middleImageView;
}

- (UIImageView *)rightImageView {
    if (_rightImageView == nil) {
        _rightImageView = [[UIImageView alloc] init];
        _rightImageView.hidden = YES;
        [self.contentView addSubview:_rightImageView];
    }
    return _rightImageView;
}

- (UIView *)lineView {
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorForHex:@"#e8e8e8"];
        [self.contentView addSubview:_lineView];
    }
    return _lineView;
}

@end
