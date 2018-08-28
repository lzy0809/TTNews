//
//  TTNewsBaseCell.h
//  TTNewsSDK
//
//  Created by liang on 2018/8/28.
//  Copyright © 2018 梁志远. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TTTopic;

typedef NS_ENUM(NSUInteger, TTCellType) {
    /** 文本 */
    TTCellTypeText = 0,
    /** 大图 */
    TTCellTypeBigImage,
    /** 三图 */
    TTCellTypeThreeImage,
    /** 单图 */
    TTCellTypeSingleImage,
    /** 视频 */
    TTCellTypeVideo,
    /** 其他 */
    TTCellTypeOther
};

@interface TTNewsBaseCell : UITableViewCell

@property (nonatomic, strong) TTTopic *topic;

+ (instancetype)cellWithTableView:(UITableView *)tableView cellType:(TTCellType )cellType;
@end
