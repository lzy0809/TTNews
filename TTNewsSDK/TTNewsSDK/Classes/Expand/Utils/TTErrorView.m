//
//  TTErrorView.m
//  TTNewsSDK
//
//  Created by 梁志远 on 2018/9/1.
//  Copyright © 2018年 梁志远. All rights reserved.
//

#import "TTErrorView.h"

@interface TTErrorView ()
@property (nonatomic, strong) UILabel *statusLabel;
@end

@implementation TTErrorView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self addSubview:self.statusLabel];
        self.userInteractionEnabled = YES;
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(refreshAction)];
        [self addGestureRecognizer:tap];
    }
    return self;
}

- (void)refreshAction {
    if (self.refreshData) {
        self.refreshData();
    }
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.statusLabel.frame = CGRectMake(ScreenWidth*0.5 - 100, ScreenHeigth*0.5 - 15, 200, 30);
}

- (UILabel *)statusLabel {
    if (_statusLabel == nil) {
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.textAlignment = NSTextAlignmentCenter;
        _statusLabel.text = @"网络异常，请检查网络";
        _statusLabel.font = [UIFont systemFontOfSize:15];
        _statusLabel.textColor = [UIColor colorWithRed:197.0/255 green:197.0/255 blue:197.0/255 alpha:1];
    }
    return _statusLabel;
}

@end
