//
//  MY_PatientScheduleCell.m
//  Doctor
//
//  Created by 王翼天 on 2017/4/19.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_PatientScheduleCell.h"

@interface MY_PatientScheduleCell ()

@property (nonatomic, strong) UIImageView *circleImageView;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UILabel *timeLabel;

@end


@implementation MY_PatientScheduleCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    
}

- (void)setObject:(id)object indexPath:(NSIndexPath *)indexpath {
    
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    return 0;
}

@end
