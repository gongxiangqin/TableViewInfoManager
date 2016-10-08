//
//  MPTitleAndPromptCell.h
//  TableViewInfoManager  左边标题 右边当为空时显示色较浅的提示语 有值时显示内容
//
//  Created by gong on 16/10/8.
//  Copyright © 2016年 George. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, MPTitleAndPromptCellType)
{
    MPTitleAndPromptCellTypeInput = 0,//输入框
    MPTitleAndPromptCellTypeSelect //点击弹出选择控制器
};

@interface MPTitleAndPromptCell : UITableViewCell

@property (nonatomic,copy) void(^textValueChangedBlock)(NSString* text);

/**
 *  @brief  左边标题 右边当为空时显示色较浅的提示语 有值时显示内容
 *
 *  @param curkey     左边标题
 *  @param curvalue   右边内容
 *  @param blankvalue 提示语
 *  @param blankValueColor 提示语颜色
 *  @param showLine   是否显示下划线
 *  @param cellType   CELL的类型
 */
-(void)setCellDataKey:(NSString *)curkey
             curValue:(NSString *)curvalue
           blankValue:(NSString *)blankvalue
      blankValueColor:(UIColor *)blankValueColor
           isShowLine:(BOOL)showLine
             cellType:(MPTitleAndPromptCellType)cellType;
@end
