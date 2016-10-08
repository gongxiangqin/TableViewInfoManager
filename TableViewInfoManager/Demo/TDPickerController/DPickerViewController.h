//
//  DPickerViewController.h
//  LittleWhite
//
//  Created by Arthur on 16/4/7.
//  Copyright © 2016年 Arthur. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TDSemiModalViewController.h"

@class DPickerViewController;

@protocol DPickerViewControllerDelegate <NSObject>

- (void)pickerSave:(DPickerViewController*)viewController;
- (void)pickerCancel:(DPickerViewController*)viewController;

@end

@interface DPickerViewController : TDSemiModalViewController<UIPickerViewDelegate, UIPickerViewDataSource>
{
   
}
//选取的数据使用(componentIndex, NSString *)的结构储存数据
//key的取值由0开始
@property(nonatomic, strong) NSMutableDictionary<NSNumber *, NSString *> *selectedItem;
//数据源使用(componentIndex, NSArray<NSString *>)的结构储存数据
//key的取值由0开始
@property(nonatomic, strong) NSDictionary<NSNumber *, NSArray<NSString *> *> *dataSource;
@property (weak) id<DPickerViewControllerDelegate> delegate;

-(void)saveClick:(id)sender;
-(void)cancelClick:(id)sender;

@end
