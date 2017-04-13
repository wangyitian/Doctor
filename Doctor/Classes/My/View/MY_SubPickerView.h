//
//  MY_SubPickerView.h
//  Doctor
//
//  Created by 王翼天 on 2017/4/13.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ConfirmBlock)(NSString *value);
@interface MY_SubPickerView : UIView
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, copy) ConfirmBlock confirmBlock;
@property (nonatomic, strong) NSString *tempMain;
@property (nonatomic, strong) NSString *tempSub;
@property (nonatomic, assign) NSInteger mainIndex;
@property (nonatomic, assign) NSInteger subIndex;
- (instancetype)initWithDataSource:(NSString*)dataSource title:(NSString*)title;
@end
