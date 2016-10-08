//
//  TDDatePickerController.m
//
//  Created by Nathan  Reed on 30/09/10.
//  Copyright 2010 Nathan Reed. All rights reserved.
//

#import "TDTimePickerController.h"

@implementation TDTimePickerController

-(void)viewDidLoad
{
    [super viewDidLoad];

	self.datePicker.date = [NSDate date];
    
    self.datePicker.datePickerMode = UIDatePickerModeTime;
    self.datePicker.timeZone = [NSTimeZone systemTimeZone];
//    if (self.dateMode == UIDatePickerModeTime) {
//        self.datePicker.datePickerMode = UIDatePickerModeTime;
//    }else{
//        self.datePicker.datePickerMode = UIDatePickerModeDate;
//    }
    
	// we need to set the subview dimensions or it will not always render correctly
	// http://stackoverflow.com/questions/1088163
	for (UIView* subview in self.datePicker.subviews) {
		subview.frame = self.datePicker.bounds;
	}
}

-(BOOL)shouldAutorotate
{
    return YES;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return YES;
}

- (UIInterfaceOrientationMask)supportedInterfaceOrientations
{
    return UIInterfaceOrientationMaskAll;
}

#pragma mark -
#pragma mark Actions

-(IBAction)saveDateEdit:(id)sender {
	if([self.delegate respondsToSelector:@selector(datePickerSetDate:)]) {
		[self.delegate datePickerSetDate:self];
	}
}

-(IBAction)clearDateEdit:(id)sender {
	if([self.delegate respondsToSelector:@selector(datePickerClearDate:)]) {
		[self.delegate datePickerClearDate:self];
	}
}

-(IBAction)cancelDateEdit:(id)sender {
	if([self.delegate respondsToSelector:@selector(datePickerCancel:)]) {
		[self.delegate datePickerCancel:self];
	} else {
		// just dismiss the view automatically?
	}
}

#pragma mark -
#pragma mark Memory Management

- (void)viewDidUnload
{
    [self setToolbar:nil];
    [super viewDidUnload];

	self.datePicker = nil;
	self.delegate = nil;

}

@end


