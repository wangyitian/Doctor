//
//  MY_CourseIntroCell.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/27.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_CourseIntroCell.h"

@implementation MY_CourseIntroCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor redColor];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    return 200;
}
@end
