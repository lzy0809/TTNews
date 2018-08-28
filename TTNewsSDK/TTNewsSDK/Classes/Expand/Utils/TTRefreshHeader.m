//
//  TTRefreshHeader.m
//  TTNewsSDK
//
//  Created by liang on 2018/8/28.
//  Copyright © 2018 梁志远. All rights reserved.
//

#import "TTRefreshHeader.h"

@interface TTRefreshHeader ()
@property (nonatomic, strong) UIImageView *gifView;
@property (nonatomic, strong) UILabel *statusLabel;
@property (nonatomic, strong) NSArray *images;
@end

@implementation TTRefreshHeader

- (void)prepare {
    [super prepare];
    
    self.mj_h = 50;
    
    UIImageView *gifView = [[UIImageView alloc] init];
    gifView.animationImages = self.images;
    [self addSubview:gifView];
    self.gifView = gifView;
    
    UILabel *statusLabel = [[UILabel alloc] init];
    statusLabel.textColor = [UIColor colorWithRed:1.0 green:0.5 blue:0.0 alpha:1.0];
    statusLabel.font = [UIFont boldSystemFontOfSize:16];
    statusLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:statusLabel];
    self.statusLabel = statusLabel;
}

- (void)placeSubviews {
    [super placeSubviews];
    
    self.gifView.frame = CGRectMake(self.mj_w*0.5 - 12, 4, 25, 25);
    self.statusLabel.frame = CGRectMake(0, self.gifView.bottom + 4, self.mj_w, 14);
}

#pragma mark 监听scrollView的contentOffset改变
- (void)scrollViewContentOffsetDidChange:(NSDictionary *)change
{
    [super scrollViewContentOffsetDidChange:change];
    
}

#pragma mark 监听scrollView的contentSize改变
- (void)scrollViewContentSizeDidChange:(NSDictionary *)change
{
    [super scrollViewContentSizeDidChange:change];
    
}

#pragma mark 监听scrollView的拖拽状态改变
- (void)scrollViewPanStateDidChange:(NSDictionary *)change
{
    [super scrollViewPanStateDidChange:change];
    
}

#pragma mark 监听控件的刷新状态
- (void)setState:(MJRefreshState)state
{
    MJRefreshCheckState;
    
    switch (state) {
        case MJRefreshStateIdle:
            [self.gifView stopAnimating];
            self.statusLabel.text = @"下拉推荐";
            break;
        case MJRefreshStatePulling:
            [self.gifView stopAnimating];
            self.statusLabel.text = @"松开推荐";
            break;
        case MJRefreshStateRefreshing:
            self.statusLabel.text = @"推荐中";
            [self.gifView startAnimating];
            break;
        default:
            break;
    }
}

#pragma mark 监听拖拽比例（控件被拖出来的比例）
- (void)setPullingPercent:(CGFloat)pullingPercent
{
    [super setPullingPercent:pullingPercent];
    
    CGFloat red = 1.0 - pullingPercent * 0.5;
    CGFloat green = 0.5 - 0.5 * pullingPercent;
    CGFloat blue = 0.5 * pullingPercent;
    self.statusLabel.textColor = [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

- (NSArray *)images {
    if (_images == nil) {
        NSMutableArray *array = [NSMutableArray array];
        for (NSInteger i = 0; i < 16; i++) {
            UIImage *image = [UIImage imageNameTT:[NSString stringWithFormat:@"dropdown_loading_%ld",i]];
            [array addObject:image];
        }
        _images = [array copy];
    }
    return _images;
}

@end
