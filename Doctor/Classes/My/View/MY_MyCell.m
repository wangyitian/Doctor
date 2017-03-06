//
//  MY_MyCell.m
//  Doctor
//
//  Created by 王翼天 on 2017/3/2.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_MyCell.h"
@interface MY_MyCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *iconView;
@end

@implementation MY_MyCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

+ (MY_MyCell *)cellWithTablebView:(UITableView *)tableView index:(NSIndexPath *)indexPath {
    static NSString *indent = @"MY_MyCell";
    [tableView registerClass:[MY_MyCell class] forCellReuseIdentifier:indent];
    MY_MyCell  *cell = [tableView dequeueReusableCellWithIdentifier:indent];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSArray *icons = [NSArray arrayWithObjects:@"my_feedback",@"my_about",@"my_setting", nil];
    if (indexPath.row == 0) {
        cell.titleLabel.text = @"意见反馈";
    } else if (indexPath.row == 1) {
        cell.titleLabel.text = @"关于我们";
    } else if (indexPath.row == 2) {
        cell.titleLabel.text = @"设置";
    }
    UIImage *icon = [UIImage imageNamed:icons[indexPath.row]];
    cell.iconView.image = icon;
    cell.iconView.bounds = CGRectMake(0, 0, icon.size.width, icon.size.height);
    cell.iconView.center = CGPointMake(26, 23);
    return cell;
}

- (void)setupUI {
    self.iconView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.iconView];
    
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = MY_Font(15);
    self.titleLabel.textColor = [MY_Util setColorWithInt:0x333333];
    self.titleLabel.frame = CGRectMake(47, 15, 100, 15);
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(100, 15));
        make.left.mas_equalTo(@47);
        make.top.mas_equalTo(@15);
    }];
    
    UIView *line = [[UIView alloc] init];
    line.backgroundColor = [MY_Util setColorWithInt:0xbbbbbb];
    [self.contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(MY_ScreenWidth, 0.5));
        make.left.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
    }];
    
    UIImageView *arrow = [[UIImageView alloc] init];
    arrow.image = [UIImage imageNamed:@"arrow"];
    [self.contentView addSubview:arrow];
    [arrow mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(7, 7));
        make.right.mas_equalTo(self).with.offset(-20);
        make.centerY.mas_equalTo(self);
    }];
}

- (void)setObject:(id)object indexPath:(NSIndexPath *)indexpath {
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    return 45;
}

@end
