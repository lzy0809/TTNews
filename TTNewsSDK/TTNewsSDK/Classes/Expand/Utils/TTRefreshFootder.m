//
//  TTRefreshFootder.m
//  TTNewsSDK
//
//  Created by 梁志远 on 2018/8/31.
//  Copyright © 2018年 梁志远. All rights reserved.
//

#import "TTRefreshFootder.h"

@interface TTRefreshFootder ()
@property (weak, nonatomic) UIImageView *loadingImage;
@end

@implementation TTRefreshFootder

#pragma mark - 懒加载子控件
- (UIImageView *)loadingImage
{
    if (!_loadingImage) {
        UIImageView *loadingImage = [[UIImageView alloc] init];
        loadingImage.contentMode = UIViewContentModeCenter;
        [self addSubview:_loadingImage = loadingImage];
    }
    return _loadingImage;
}
#pragma mark - 重写父类的方法
- (void)prepare {
    [super prepare];
    self.mj_h  = 40 + [UIFont systemFontOfSize:12.0].lineHeight;
    self.loadingImage.image = [UIImage imageNameTT:@"icon_footer_loading"];
    self.stateLabel.font = [UIFont systemFontOfSize:12.0];
    self.labelLeftInset = 5;
    self.stateLabel.textColor = [UIColor colorForHex:@"#999999"];
}

- (void)placeSubviews {
    [super placeSubviews];
    if (self.loadingImage.constraints.count) return;
    CGFloat loadingCenterX = self.mj_w * 0.5;
    if (!self.isRefreshingTitleHidden) {
        self.stateLabel.center = CGPointMake(self.mj_w * 0.5, self.mj_h * 0.5);
        loadingCenterX -= self.stateLabel.mj_textWith * 0.5 + self.labelLeftInset + self.loadingImage.image.size.width * 0.5;
    }
    CGFloat loadingCenterY = self.mj_h * 0.5;
    self.loadingImage.center = CGPointMake(loadingCenterX, loadingCenterY);
}

- (void)setState:(MJRefreshState)state {
    MJRefreshCheckState
    switch (state) {
        case MJRefreshStateIdle:
            self.loadingImage.hidden = YES;
            [self stopAnimating];
            self.stateLabel.text = @"正在加载";
            break;
        case MJRefreshStateRefreshing:
            self.loadingImage.hidden = NO;
            [self startAnimating];
            self.stateLabel.text = @"正在加载";
            break;
        case MJRefreshStateNoMoreData:
            self.loadingImage.hidden = YES;
            [self stopAnimating];
            self.stateLabel.text = @"木有了，我们是有底线滴...";
            break;
        default:
            break;
    }
}

- (void)startAnimating {
    CABasicAnimation *animation = [ CABasicAnimation animationWithKeyPath: @"transform" ];
    animation.fromValue = [NSValue valueWithCATransform3D:CATransform3DIdentity];
    animation.toValue = [ NSValue valueWithCATransform3D: CATransform3DMakeRotation(M_PI_2, 0, 0, 1.0) ];
    animation.duration = 0.15;
    animation.cumulative = YES;
    animation.repeatDuration = MAXFLOAT;
    [self.loadingImage.layer addAnimation:animation forKey:nil];
}

- (void)stopAnimating {
    [self.loadingImage.layer removeAllAnimations];
}

@end
