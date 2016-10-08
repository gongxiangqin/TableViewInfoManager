//
//  MPTitleAndPromptCell.m
//  TableViewInfoManager
//
//  Created by gong on 16/10/8.
//  Copyright © 2016年 George. All rights reserved.
//

#import "MPTitleAndPromptCell.h"

static const CGFloat spaceWith=15;

@interface MPTitleAndPromptCell()<UITextFieldDelegate>
@property(strong,nonatomic)UILabel *keyLabel;
@property (nonatomic, strong)UITextField *valueTextField;
@property(strong,nonatomic)UIView *lineView;
@end

@implementation MPTitleAndPromptCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //设置背影色
        self.backgroundColor=[UIColor whiteColor];
        self.accessoryType = UITableViewCellAccessoryNone;
        self.selectionStyle=UITableViewCellSelectionStyleNone;
        
        if (self.keyLabel==nil) {
            self.keyLabel=[[UILabel alloc]init];
            self.keyLabel.font=AdaptedFontSize(14);
            self.keyLabel.textColor=COLOR_WORD_GRAY_1;
            [self.contentView addSubview:self.keyLabel];
            [self.keyLabel mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(spaceWith);
                make.centerY.mas_equalTo(0);
                make.size.mas_equalTo(CGSizeMake(80, AdaptedHeight(15)));
            }];
        }
        
        if (self.valueTextField==nil) {
            self.valueTextField=[[UITextField alloc]init];
            self.valueTextField.textAlignment=NSTextAlignmentRight;
            self.valueTextField.font=AdaptedFontSize(14);
            self.valueTextField.textColor=COLOR_WORD_GRAY_2;
            [self.valueTextField addTarget:self action:@selector(valueTextFieldChange:) forControlEvents:UIControlEventValueChanged];
            [self.contentView addSubview:self.valueTextField];
            [self.valueTextField mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(0);
                make.right.mas_equalTo(0);
                make.size.mas_equalTo(CGSizeMake(Main_Screen_Width-80-2*spaceWith, AdaptedHeight(18)));
            }];
        }
        
        if (self.lineView==nil) {
            self.lineView = [[UIView alloc] init];
            self.lineView.hidden=YES;
            self.lineView.backgroundColor=COLOR_UNDER_LINE;
            [self.contentView addSubview:self.lineView];
            [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.mas_equalTo(spaceWith);
                make.right.mas_equalTo(self).offset(0);
                make.bottom.mas_equalTo(0);
                make.height.mas_equalTo(@0.5);
            }];
        }
    }
    return self;
}

- (void)valueTextFieldChange:(UITextField *)textField
{
    if (self.textValueChangedBlock) {
        self.textValueChangedBlock(textField.text);
    }
}


-(void)setCellDataKey:(NSString *)curkey curValue:(NSString *)curvalue blankValue:(NSString *)blankvalue isShowLine:(BOOL)showLine cellType:(MPTitleAndPromptCellType)cellType
{
    self.keyLabel.text=curkey;
    self.lineView.hidden=!showLine;
    if ([curvalue length]==0) {
        self.valueTextField.placeholder=blankvalue;
        self.valueTextField.textColor=COLOR_WORD_GRAY_2;
    }
    else
    {
        self.valueTextField.text=curvalue;
        self.valueTextField.textColor=COLOR_WORD_BLACK;
    }
    switch (cellType) {
        case MPTitleAndPromptCellTypeInput: {
            self.accessoryType = UITableViewCellAccessoryNone;
            [self.valueTextField mas_remakeConstraints:^(MASConstraintMaker *make) {
                make.centerY.mas_equalTo(0);
                make.right.mas_equalTo(-2*spaceWith);
                make.size.mas_equalTo(CGSizeMake(Main_Screen_Width-80-2*spaceWith, AdaptedHeight(18)));
            }];
            [self.valueTextField layoutIfNeeded];
            break;
        }
        case MPTitleAndPromptCellTypeSelect: {
            self.valueTextField.enabled = NO;
            self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
            break;
        }
    }
}

@end
