//
//  TDDatePickerController.m
//
//  Created by Nathan  Reed on 30/09/10.
//  Copyright 2010 Nathan Reed. All rights reserved.
//

#import "TDDatePickerController.h"

@interface TDDatePickerController()
@property (strong) UIDatePicker* datePicker;
@property (strong) UIView *fakeToolbar;
@end

@implementation TDDatePickerController

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    [self addDatePicker];
    
    [self addFakeToolBar];

    
	// we need to set the subview dimensions or it will not always render correctly
	// http://stackoverflow.com/questions/1088163
	for (UIView* subview in self.datePicker.subviews) {
		subview.frame = self.datePicker.bounds;
	}

    [self addSingleTapDismiss];
    
    [self clearSeparatorWithView:self.datePicker];
}


- (void)addSingleTapDismiss
{
    //添加点击消失
    UITapGestureRecognizer* singleRecognizer;
    singleRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(singleTapped:)];
    singleRecognizer.numberOfTapsRequired = 1; // 单击
    [self.view addGestureRecognizer:singleRecognizer];
}

- (void)singleTapped:(UIGestureRecognizer *)gestureRecognizer
{
    if([self.delegate respondsToSelector:@selector(datePickerCancel:)]) {
        [self.delegate datePickerCancel:self];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

- (void)addDatePicker
{
     __weak typeof(self) wSelf = self;
    
    self.datePicker = [[UIDatePicker alloc] init];
    self.datePicker.date = [NSDate date];
    self.datePicker.datePickerMode = UIDatePickerModeDate;
    self.datePicker.timeZone = [NSTimeZone systemTimeZone];
    self.datePicker.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.datePicker];
    
    [self.datePicker mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(wSelf.view);
        make.height.equalTo(@162);
    }];
    
    //    self.datePicker.locale = [NSLocale systemLocale];
    //    if (self.dateMode == UIDatePickerModeTime) {
    //        self.datePicker.datePickerMode = UIDatePickerModeTime;
    //    }else{
    //        self.datePicker.datePickerMode = UIDatePickerModeDate;
    //    }
    
    if(self.selectedDate){
        [_datePicker setDate:_selectedDate];
    }
}

- (void)addFakeToolBar
{
    __weak typeof(self) wSelf = self;
    
    //toolbar
    self.fakeToolbar = [[UIView alloc] init];
    self.fakeToolbar.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.fakeToolbar];
    
    UIButton *cancelButton = [[UIButton alloc] init];
    [cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButton setTitleColor:COLOR_RGB(0x333333, 1) forState:UIControlStateNormal];
    [cancelButton addTarget:self action:@selector(cancelDateEdit:) forControlEvents:UIControlEventTouchUpInside];
    [self.fakeToolbar addSubview:cancelButton];
    
    UIButton *confirmButton = [[UIButton alloc] init];
    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [confirmButton setTitleColor:COLOR_RGB(0x333333, 1) forState:UIControlStateNormal];
    [confirmButton addTarget:self action:@selector(saveDateEdit:) forControlEvents:UIControlEventTouchUpInside];
    [self.fakeToolbar addSubview:confirmButton];
    
    [cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@10);
        make.top.equalTo(@5);
        make.bottom.equalTo(wSelf.fakeToolbar).offset(-5);
        make.width.equalTo(@44);
    }];
    
    [confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(wSelf.fakeToolbar).offset(-10);
        make.top.equalTo(@5);
        make.bottom.equalTo(wSelf.fakeToolbar).offset(-5);
        make.width.equalTo(@44);
    }];
    
    
    
    [self.fakeToolbar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(wSelf.datePicker.mas_top);
        make.left.right.equalTo(wSelf.view);
        make.height.equalTo(@44);
    }];
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

- (void)setSelectedDate:(NSDate *)selectedDate
{
    _selectedDate = selectedDate;
    
    if(_datePicker){
        [_datePicker setDate:_selectedDate];
    }
}

#pragma mark -
#pragma mark Actions

-(void)saveDateEdit:(id)sender {
    _selectedDate = _datePicker.date;
    
	if([self.delegate respondsToSelector:@selector(datePickerSetDate:)]) {
		[self.delegate datePickerSetDate:self];
	}
}

-(void)cancelDateEdit:(id)sender {
    _selectedDate = nil;
    
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
    [super viewDidUnload];

}

//清除分割线
- (void)clearSeparatorWithView:(UIView * )view
{
    if(view.subviews != 0  )
    {
        if(view.bounds.size.height < 5)
        {
            view.backgroundColor = [UIColor clearColor];
        }
        
        [view.subviews enumerateObjectsUsingBlock:^(__kindof UIView * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            [self clearSeparatorWithView:obj];
        }];
    }
    
}
@end


