//
//  TTLayOutPureTitleCell.m
//  TTNewsSDK
//
//  Created by liang on 2018/8/30.
//  Copyright © 2018 梁志远. All rights reserved.
//

#import "TTLayOutPureTitleCell.h"
#import "TTTopic.h"
#import "NSString+Extension.h"

@interface TTLayOutPureTitleCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong)UIView *lineView;
@end

@implementation TTLayOutPureTitleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.lineView];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGFloat titleW = self.width - kMargin * 2;
    CGFloat titleH = [self.topic.title sizeWithFont:[UIFont systemFontOfSize:17] maxSize:CGSizeMake(titleW, MAXFLOAT) maxNumberOfLines:2].height;
    self.titleLabel.frame = CGRectMake(kMargin, 14, titleW, titleH);
    self.lineView.frame = CGRectMake(kMargin, self.titleLabel.bottom, titleW, kLineHeight);
}

- (void)setTopic:(TTTopic *)topic {
    [super setTopic:topic];
    
    self.titleLabel.text = topic.title;
    
}

- (UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
        _titleLabel.font = [UIFont systemFontOfSize:17];
        _titleLabel.numberOfLines = 2;
        _titleLabel.textColor = [UIColor colorForHex:@"#222222"];
        _titleLabel.backgroundColor = [UIColor colorForHex:@"#ffffff"];
        _titleLabel.layer.masksToBounds = YES;
    }
    return _titleLabel;
}

- (UIView *)lineView
{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorForHex:@"#eeeeee"];
    }
    return _lineView;
}

@end
