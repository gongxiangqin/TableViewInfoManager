//
//  MPIconAndTitleCell.h
//  TableViewInfoManager  有图标跟标题的Cell
//
//  Created by gong on 16/10/8.
//  Copyright © 2016年 George. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MPIconAndTitleCell : UITableViewCell
-(void)configCellIconName:(NSString *)iconName
                cellTitle:(NSString *)cellTitle
                 showLine:(BOOL)isShowLine;
@end
