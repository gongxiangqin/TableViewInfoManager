//
//  DemoController.m
//  TableViewInfoManager
//
//  Created by gong on 16/10/8.
//  Copyright © 2016年 George. All rights reserved.
//

#import "DemoController.h"
#import "MPTitleAndPromptCell.h"
#import "MPIconAndTitleCell.h"
#import "MPMultitextCell.h"
#import "TDDatePickerController.h"
#import "DPickerViewController.h"
#import "NSDate+Utils.h"
#import <IQKeyboardManager/IQKeyboardManager.h>

@interface DemoController ()<UITableViewDataSource, UITableViewDelegate,TDDatePickerControllerDelegate, DPickerViewControllerDelegate>
@property (nonatomic,strong) UITableView *myTableView;
@property(nonatomic, strong)TDDatePickerController *datePickerViewController;
@property(nonatomic, strong)DPickerViewController *relationshipPickerViewController;
@property(nonatomic, strong)NSIndexPath *selectedIndexPath;
@property(nonatomic,copy)NSString *myUserName,*mySex,*myBirthday,*myAddress;
@end

@implementation DemoController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor grayColor];
    
    [self layoutPageView];
}

-(void)layoutPageView
{
    //初始化表格
    if (!_myTableView) {
        _myTableView = [[UITableView alloc] initWithFrame:CGRectMake(0,0.5, Main_Screen_Width, Main_Screen_Height) style:UITableViewStylePlain];
        _myTableView.showsVerticalScrollIndicator = NO;
        _myTableView.showsHorizontalScrollIndicator = NO;
        _myTableView.dataSource = self;
        _myTableView.delegate = self;
        _myTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        _myTableView.tableFooterView = [[UIView alloc] init];
        [_myTableView registerClass:[MPTitleAndPromptCell class] forCellReuseIdentifier:NSStringFromClass([MPTitleAndPromptCell class])];
        [_myTableView registerClass:[MPIconAndTitleCell class] forCellReuseIdentifier:NSStringFromClass([MPIconAndTitleCell class])];
        [_myTableView registerClass:[MPMultitextCell class] forCellReuseIdentifier:NSStringFromClass([MPMultitextCell class])];
        [self.view addSubview:_myTableView];
        
        __weak typeof(self)wSelf = self;
        [_myTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.left.equalTo(wSelf.view);
        }];
    }
}


#pragma mark UITableViewDataSource, UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==4) {
        return [MPMultitextCell cellHeight];
    }
    return 44;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row==0) {
        MPIconAndTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MPIconAndTitleCell class]) forIndexPath:indexPath];
        [cell configCellIconName:@"mine_setting_icon" cellTitle:@"系统设置" showLine:YES];
        
        return cell;
    }
    else if (indexPath.row==1) {
        MPTitleAndPromptCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MPTitleAndPromptCell class]) forIndexPath:indexPath];
        [cell setCellDataKey:@"姓名" curValue:self.myUserName blankValue:@"请输入姓名" isShowLine:YES cellType:MPTitleAndPromptCellTypeInput];
        cell.textValueChangedBlock = ^(NSString* text){
            self.myUserName = text;
        };
        return cell;
    }
    else if (indexPath.row==2)
    {
        MPTitleAndPromptCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MPTitleAndPromptCell class]) forIndexPath:indexPath];
        [cell setCellDataKey:@"性别" curValue:self.mySex blankValue:@"请选择性别" isShowLine:YES cellType:MPTitleAndPromptCellTypeSelect];
        return cell;
    }
    else if (indexPath.row==3)
    {
        MPTitleAndPromptCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MPTitleAndPromptCell class]) forIndexPath:indexPath];
        [cell setCellDataKey:@"生日" curValue:self.myBirthday blankValue:@"请选择出生日期" isShowLine:YES cellType:MPTitleAndPromptCellTypeSelect];
        return cell;
    }
    else if (indexPath.row==4)
    {
        MPMultitextCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([MPMultitextCell class]) forIndexPath:indexPath];
        [cell setCellDataKey:@"家庭地址" textValue:self.myAddress blankValue:@"请输入家庭地址" showLine:NO];
        cell.placeFontSize=15;
        cell.textValueChangedBlock=^(NSString* text)
        {
            self.myAddress=text;
        };
        return cell;
    }
    
    return nil;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selectedIndexPath = indexPath;
    [tableView deselectRowAtIndexPath:indexPath animated:YES];

    if (indexPath.row==0) {

        NSLog(@"点击设置成功");
    }
    else if(indexPath.row==2)
    {
        //弹出选择控制器之前先让键盘退出
        [[IQKeyboardManager sharedManager] resignFirstResponder];
        self.relationshipPickerViewController = [[DPickerViewController alloc] init];
        self.relationshipPickerViewController.delegate = self;
        self.relationshipPickerViewController.dataSource = @{@0: @[@"男", @"女"]};
        [self presentSemiModalViewController:self.relationshipPickerViewController];
    }
    else if (indexPath.row==3)
    {
        [[IQKeyboardManager sharedManager] resignFirstResponder];
        self.datePickerViewController = [[TDDatePickerController alloc] init];
        self.datePickerViewController.selectedDate = [NSDate dateFromString:self.myBirthday];
        self.datePickerViewController.delegate = self;
        [self presentSemiModalViewController:self.datePickerViewController];
    }
}

- (NSInteger)indexOfFirst:(NSString *)firstLevelName firstLevelArray:(NSArray *)firstLevelArray
{
    NSInteger index = [firstLevelArray indexOfObject:firstLevelName];
    if (index == NSNotFound) {
        return 0;
    }
    return index;
}

- (void)datePickerSetDate:(TDDatePickerController*)viewController{
    if(self.selectedIndexPath.row == 3){
        self.myBirthday = [viewController.selectedDate stringWithFormat:@"yyyy-MM-dd"];
    }

    [self.myTableView reloadData];
    
    [self dismissSemiModalViewController:viewController];
    self.datePickerViewController = nil;
}

- (void)datePickerCancel:(TDDatePickerController*)viewController{
    [self dismissSemiModalViewController:viewController];
    self.datePickerViewController = nil;
}

- (void)pickerSave:(DPickerViewController*)viewController{
    if ([viewController.selectedItem[@0] isEqualToString:@"女"]) {
        self.mySex = @"女";
    }else
    {
        self.mySex = @"男";
    }
    
    [self.myTableView reloadData];
    
    [self dismissSemiModalViewController:viewController];
    self.relationshipPickerViewController = nil;
}
- (void)pickerCancel:(DPickerViewController*)viewController{
    [self dismissSemiModalViewController:viewController];
    self.relationshipPickerViewController = nil;
}
@end
