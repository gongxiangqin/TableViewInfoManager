//
//  DPickerViewController.m
//  LittleWhite
//
//  Created by Arthur on 16/4/7.
//  Copyright © 2016年 Arthur. All rights reserved.
//

#import "DPickerViewController.h"
#import "DPickerView.h"
@interface DPickerViewController()
@property (strong) DPickerView* pickerView;
@property (strong) UIView *fakeToolbar;
@end

@implementation DPickerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self addPickerView];
    
    [self addFakeToolBar];
    
    [self addSingleTapDismiss];
}

- (void)addPickerView
{
    __weak typeof(self) wSelf = self;
    
    _pickerView = [[DPickerView alloc] init];
    //_pickerView.selectorColor = [UIColor clearColor];
    _pickerView.delegate = self;
    _pickerView.dataSource = self;
    _pickerView.backgroundColor = UIColor.whiteColor;
    
    if(self.selectedItem && self.dataSource){
        for (NSNumber *key in self.selectedItem) {
            [self.pickerView selectRow:[self.dataSource[key] indexOfObject:self.selectedItem[key]]
                           inComponent:key.integerValue animated:YES];
        }
    }
    
    [self.view addSubview:_pickerView];
    
    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(wSelf.view);
        make.height.equalTo(@162);
    }];
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
    [cancelButton addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.fakeToolbar addSubview:cancelButton];
    
    UIButton *confirmButton = [[UIButton alloc] init];
    [confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    [confirmButton setTitleColor:COLOR_RGB(0x333333, 1) forState:UIControlStateNormal];
    [confirmButton addTarget:self action:@selector(saveClick:) forControlEvents:UIControlEventTouchUpInside];
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
        make.bottom.equalTo(wSelf.pickerView.mas_top);
        make.left.right.equalTo(wSelf.view);
        make.height.equalTo(@44);
    }];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(void)saveClick:(id)sender {
    _selectedItem = [[NSMutableDictionary alloc] init];
    
    for (int componentIndex=0; componentIndex<_dataSource.count; componentIndex++) {
        NSInteger row = [_pickerView selectedRowInComponent:componentIndex];
        _selectedItem[@(componentIndex)] = _dataSource[@(componentIndex)][row];
    }
    
    if([self.delegate respondsToSelector:@selector(pickerSave:)]) {
        [self.delegate pickerSave:self];
    }
}

-(void)cancelClick:(id)sender {
    if([self.delegate respondsToSelector:@selector(pickerCancel:)]) {
        [self.delegate pickerCancel:self];
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

#pragma mark - datasource

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    return [_dataSource count];
}

-(NSInteger) pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component{
    return _dataSource[@(component)].count;
}

-(NSString*) pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    return _dataSource[@(component)][row];
}

- (void)setSelectedItem:(NSMutableDictionary<NSNumber *,NSString *> *)selectedItem
{
    _selectedItem = selectedItem;
    
    if(self.pickerView && self.dataSource){
        for (NSNumber *key in selectedItem) {
            [self.pickerView selectRow:[self.dataSource[key] indexOfObject:selectedItem[key]]
                           inComponent:key.integerValue animated:YES];
        }
    }
}

- (void)setDataSource:(NSDictionary<NSNumber *,NSArray<NSString *> *> *)dataSource
{
    _dataSource = dataSource;
    
    if(self.selectedItem && self.pickerView){
        for (NSNumber *key in self.selectedItem) {
            [self.pickerView selectRow:[self.dataSource[key] indexOfObject:self.selectedItem[key]]
                           inComponent:key.integerValue animated:YES];
        }
    }
}

//- (NSAttributedString *)pickerView:(UIPickerView *)pickerView attributedTitleForRow:(NSInteger)row forComponent:(NSInteger)component
//{
//    NSString *title = _dataSource[@(component)][row];
//    NSAttributedString *attString = [[NSAttributedString alloc] initWithString:title attributes:@{NSForegroundColorAttributeName:[UIColor colorFromRBG:0xff7f3f]}];
//    
//    return attString;
//}
//
//- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view{
//    NSInteger selectedRow = [pickerView selectedRowInComponent:component];
//    
//    NSString *text = _dataSource[@(component)][row];
//    
//    DLog(@"%ld : %ld : %@",selectedRow, row, text);
//    
//    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, pickerView.frame.size.width, 44)];
//    label.backgroundColor = [UIColor clearColor];
//    label.textColor = [UIColor colorFromRBG:0xff7f3f];
//    
//    if(row == selectedRow)
//        label.font = [UIFont fontWithName:@"HelveticaNeue-Bold" size:25];
//    else
//        label.font = [UIFont systemFontOfSize:10];
//    
//    label.text = _dataSource[@(component)][row];
//    label.textAlignment = NSTextAlignmentCenter;
//    return label;
//}

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
    if([self.delegate respondsToSelector:@selector(pickerCancel:)]) {
        [self.delegate pickerCancel:self];
    } else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}
@end
