//
//  TTPageContentView.h
//  TTNewsSDK
//
//  Created by liang on 2018/8/27.
//  Copyright © 2018 梁志远. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TTPageContentView;

@protocol TTPageContentDelegate <NSObject>

@required
- (void)updateStatusWithProgress:(CGFloat )progress sourceIndex:(NSInteger )sourceIndex targetIndex:(NSInteger )targetIndex;
- (void)scrollToIndex:(NSInteger )index;
@end

@interface TTPageContentView : UIView

@property (nonatomic, strong) NSArray *channels;
@property (nonatomic, weak) id<TTPageContentDelegate>delegate;

- (void)scrollToTargetIndex:(NSInteger )targetIndex;

@end
