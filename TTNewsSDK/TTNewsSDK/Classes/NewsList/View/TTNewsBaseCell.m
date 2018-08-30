//
//  TTNewsBaseCell.m
//  TTNewsSDK
//
//  Created by liang on 2018/8/28.
//  Copyright © 2018 梁志远. All rights reserved.
//

#import "TTNewsBaseCell.h"
#import "TTTopic.h"

@implementation TTNewsBaseCell

+ (instancetype)cellWithTableView:(UITableView *)tableView topic:(TTTopic *)topic {
    NSString *identifier = [self cellIdentifier:topic];
    TTNewsBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[NSClassFromString(identifier) alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    return cell;
}

+ (NSString *)cellIdentifier:(TTTopic *)topic {
    NSString *identifier = @"TTNewsBaseCell";
    if (topic.middle_image.url_list.count > 0) {
        identifier = @"TTLayOutGroupPicCell";
    }
    identifier = @"TTLayOutRightPicCell";
    return identifier;
}

- (void)setTopic:(TTTopic *)topic {
    _topic = topic;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
