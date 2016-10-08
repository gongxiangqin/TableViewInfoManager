//
//  DPickerView.m
//  Duwa
//
//  Created by Arthur on 16/6/23.
//  Copyright © 2016年 miduotek. All rights reserved.
//

#import "DPickerView.h"

@implementation DPickerView
- (void)didAddSubview:(UIView *)subview
{
    [subview didAddSubview:subview];
    if (self.selectorColor)
    {
        if (subview.bounds.size.height <= 1.0)
        {
            subview.backgroundColor = self.selectorColor;
        }
    }
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self clearSeparatorWithView:self];
}

//清除分割线
- (void)clearSeparatorWithView:(UIView * )view
{
    if(view.subviews != nil)
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
