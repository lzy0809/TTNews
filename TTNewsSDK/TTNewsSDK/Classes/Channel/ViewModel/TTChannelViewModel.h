//
//  TTChannelViewModel.h
//  TTNewsSDK
//
//  Created by liang on 2018/8/27.
//  Copyright © 2018 梁志远. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TTChannelViewModel : NSObject

@property (nonatomic, strong) NSArray *channels;

- (void)loadChannelListData:(void(^)(void))finishedBlock;

@end
