//
//  TTNewsViewController.m
//  TTNewsSDK
//
//  Created by 梁志远 on 2018/8/26.
//  Copyright © 2018年 梁志远. All rights reserved.
//

#import "TTNewsViewController.h"
#import "TTNetManager.h"
#import "TTParseParameters.h"

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
    [[TTNetManager sharedManager] GET:kChannelListURL parameters:[TTParseParameters requestDicPraiseChannleList] success:^(NSURLSessionDataTask *operation, id responseObject) {
        for (NSDictionary *dict in responseObject[@"data"][@"data"]) {
            TTCategory *category = [TTCategory yy_modelWithJSON:dict];
            [self.channels addObject:category];
        }
        NSLog(@"请求成功:%ld",self.channels.count);
    } failure:^(NSURLSessionDataTask *operation, NSError *error) {
        NSLog(@"请求失败了");
    }];
}

- (NSMutableArray *)channels {
    if (_channels == nil) {
        _channels = [NSMutableArray array];
    }
    return _channels;
}
@end
