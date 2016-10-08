//
//  TDDatePickerController.h
//
//  Created by Nathan  Reed on 30/09/10.
//  Copyright 2010 Nathan Reed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import	"TDSemiModal.h"

@protocol TDDatePickerControllerDelegate;

@interface TDDatePickerController : TDSemiModalViewController

@property (weak) id<TDDatePickerControllerDelegate> delegate;
@property (nonatomic, strong)NSDate *selectedDate;
-(void)saveDateEdit:(id)sender;
-(void)cancelDateEdit:(id)sender;

@end

@protocol TDDatePickerControllerDelegate <NSObject>

- (void)datePickerSetDate:(TDDatePickerController*)viewController;
- (void)datePickerCancel:(TDDatePickerController*)viewController;

@end

