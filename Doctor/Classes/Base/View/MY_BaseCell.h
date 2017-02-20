//
//  MY_BaseCell.h
//  Doctor
//
//  Created by 王翼天 on 2017/2/15.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MY_BaseCell : UITableViewCell

@property (nonatomic, strong) id object;
@property (nonatomic, assign) id delegate;

+ (CGFloat)tableView:(UITableView*)tableView rowHeightForObject:(id)object;
@end
