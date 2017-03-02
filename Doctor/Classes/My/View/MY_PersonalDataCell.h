//
//  MY_PersonalDataCell.h
//  Doctor
//
//  Created by 王翼天 on 2017/2/20.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_BaseCell.h"

@interface MY_PersonalDataCell : MY_BaseCell
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *valueLabel;
- (void)setupUI;
+ (MY_PersonalDataCell *)cellWithTablebView:(UITableView *)tableView index:(NSIndexPath *)indexPath;
@end
