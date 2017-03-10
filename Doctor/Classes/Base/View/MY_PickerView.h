//
//  MY_PickerView.h
//  Doctor
//
//  Created by 王翼天 on 2017/3/10.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^ConfirmBlock)(NSString *value);

@interface MY_PickerView : UIView
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, copy) ConfirmBlock confirmBlock;
- (instancetype)initWithDataSource:(NSArray*)dataSource title:(NSString*)title;
@end
