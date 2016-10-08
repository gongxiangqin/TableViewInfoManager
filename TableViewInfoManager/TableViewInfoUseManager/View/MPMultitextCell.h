//
//  MPMultitextCell.h
//  TableViewInfoManager 多行输入框效果 值为空时有提示
//
//  Created by gong on 16/10/8.
//  Copyright © 2016年 George. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MPMultitextCell : UITableViewCell<UITextViewDelegate>

//字体大小
@property(nonatomic,assign)CGFloat placeFontSize;

@property (nonatomic,copy) void(^textValueChangedBlock)(NSString* text);

//返回行高
+ (CGFloat)cellHeight;

/**
 *  @brief  多行输入框效果 值为空时有提示
 *
 *  @param cellTitle  标题
 *  @param textValue  值
 *  @param blankvalue 空值时的提示语
 *  @param isShowLine 是否显示下划线
 */
-(void)setCellDataKey:(NSString *)cellTitle
            textValue:(NSString *)textValue
           blankValue:(NSString *)blankvalue
             showLine:(BOOL)isShowLine;

//焦点事件
-(BOOL)becomeFirstResponder;

-(BOOL)resignFirstResponder;
@end
