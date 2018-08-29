//
//  TTNewsBaseCell.m
//  TTNewsSDK
//
//  Created by liang on 2018/8/28.
//  Copyright © 2018 梁志远. All rights reserved.
//

#import "TTNewsBaseCell.h"

@implementation TTNewsBaseCell

+ (instancetype)cellWithTableView:(UITableView *)tableView cellType:(TTCellType )cellType {
    NSString *identifier = @"TTNewsBaseCell";
    switch (cellType) {
        case TTCellTypeText:
            identifier = @"TTTextCell";
            break;
        case TTCellTypeBigImage:
            identifier = @"TTBigImageCell";
            break;
        case TTCellTypeThreeImage:
            identifier = @"TTThreeImageCell";
            break;
        case TTCellTypeRightPic:
            identifier = @"TTLayOutRightPicCell";
            break;
        case TTCellTypeVideo:
            identifier = @"TTVideoCell";
            break;
        default:
            
            break;
    }
    
//    NSLog(@"cell type is %ld",cellType);
    TTNewsBaseCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[NSClassFromString(identifier) alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:identifier];
    }
    
    return cell;
}

- (void)setTopic:(TTTopic *)topic {
    _topic = topic;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
