//
//  TTNewsBaseCell.h
//  TTNewsSDK
//
//  Created by liang on 2018/8/28.
//  Copyright © 2018 梁志远. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TTTopic;

@interface TTNewsBaseCell : UITableViewCell

@property (nonatomic, strong) TTTopic *topic;
@property (nonatomic, assign) CGFloat cellH;
+ (instancetype)cellWithTableView:(UITableView *)tableView topic:(TTTopic *)topic;
- (void)clear;
@end
