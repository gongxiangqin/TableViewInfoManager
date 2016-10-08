//
//  TDDatePickerController.h
//
//  Created by Nathan  Reed on 30/09/10.
//  Copyright 2010 Nathan Reed. All rights reserved.
//

#import <UIKit/UIKit.h>
#import	"TDSemiModal.h"

@protocol TDTimePickerControllerDelegate;

@interface TDTimePickerController : TDSemiModalViewController

@property (weak) id<TDTimePickerControllerDelegate> delegate;
@property (weak) IBOutlet UIDatePicker* datePicker;
@property (weak) IBOutlet UIToolbar *toolbar;
@property (nonatomic, assign) UIDatePickerMode dateMode;

-(IBAction)saveDateEdit:(id)sender;
-(IBAction)clearDateEdit:(id)sender;
-(IBAction)cancelDateEdit:(id)sender;

@end

@protocol TDTimePickerControllerDelegate <NSObject>

- (void)datePickerSetDate:(TDTimePickerController*)viewController;
- (void)datePickerClearDate:(TDTimePickerController*)viewController;
- (void)datePickerCancel:(TDTimePickerController*)viewController;

@end

