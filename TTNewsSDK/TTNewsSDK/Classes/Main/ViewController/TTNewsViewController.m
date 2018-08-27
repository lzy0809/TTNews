//
//  TTNewsViewController.m
//  TTNewsSDK
//
//  Created by 梁志远 on 2018/8/26.
//  Copyright © 2018年 梁志远. All rights reserved.
//

#import "TTNewsViewController.h"
#import "TTDatabaseManager.h"

#import "TTCategory.h"

@interface TTNewsViewController ()
@property (nonatomic, strong) NSMutableArray *channels;
@end

@implementation TTNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor redColor];
    
    [self requestData];
}

- (void)requestData {
    if ([TTDatabaseManager sharedManager].cacheChannels.count > 0) {
        NSLog(@"数据库有值:%@",[TTDatabaseManager sharedManager].cacheChannels);
    } else {
        [TTDatabaseManager updateChannels:^(NSArray *channels) {
            NSLog(@"接口返回:%@",channels);
        }];
    }
}

- (NSMutableArray *)channels {
    if (_channels == nil) {
        _channels = [NSMutableArray array];
    }
    return _channels;
}
@end
