//
//  MY_CourseCustomedDemoCell.m
//  Doctor
//
//  Created by 王翼天 on 2017/3/10.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_CourseCustomedDemoCell.h"
@interface MY_CourseCustomedDemoCell ()
@property (nonatomic, strong) UIButton *mainButton;
@property (nonatomic, strong) UIView *detailView;
@end
@implementation MY_CourseCustomedDemoCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    return 100;
}

@end
