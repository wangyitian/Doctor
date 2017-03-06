//
//  MY_MyCell.h
//  Doctor
//
//  Created by 王翼天 on 2017/3/2.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_BaseCell.h"

@interface MY_MyCell : MY_BaseCell
+ (MY_MyCell *)cellWithTablebView:(UITableView *)tableView index:(NSIndexPath *)indexPath;
@end
