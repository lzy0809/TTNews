//
//  ViewController.m
//  NewsDemo
//
//  Created by 梁志远 on 2018/8/26.
//  Copyright © 2018年 梁志远. All rights reserved.
//

#import "ViewController.h"
#import "TTNewsSDK.h"

@interface ViewController ()
@property (nonatomic, strong) TTNewsViewController *newsCV;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.newsCV.view.bounds = self.view.bounds;
}

- (TTNewsViewController *)newsCV {
    if (_newsCV == nil) {
        _newsCV = [[TTNewsViewController alloc] init];
        [self addChildViewController:_newsCV];
        [self.view insertSubview:_newsCV.view atIndex:0];
    }
    return _newsCV;
}


@end
