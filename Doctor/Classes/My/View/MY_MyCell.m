//
//  MY_MyCell.m
//  Doctor
//
//  Created by 王翼天 on 2017/3/2.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_MyCell.h"

@implementation MY_MyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    [super setupUI];
    self.valueLabel.hidden = YES;
}

- (void)setObject:(id)object indexPath:(NSIndexPath *)indexpath {
    self.titleLabel.text = (NSString*)object;
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    return 44;
}

@end
