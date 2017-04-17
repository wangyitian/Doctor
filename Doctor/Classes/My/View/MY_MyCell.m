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
    
    NSArray *icons = [NSArray arrayWithObjects:@"service_schedule",@"patient_recommend",@"feedback",@"aboutUS",@"setting",@"invite", nil];
    
    if (indexPath.row == 0) {
        cell.titleLabel.text = @"服务进度";
    } else if (indexPath.row == 1) {
        cell.titleLabel.text = @"患者推荐";
    } else if (indexPath.row == 2) {
        cell.titleLabel.text = @"意见反馈";
    } else if (indexPath.row == 3) {
        cell.titleLabel.text = @"关于我们";
    } else if (indexPath.row == 4) {
        cell.titleLabel.text = @"设置";
    } else if (indexPath.row == 5) {
        cell.titleLabel.text = @"邀请";
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
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(47, 15, 100, 15)];
    self.titleLabel.font = MY_Font(15);
    self.titleLabel.textColor = [MY_Util setColorWithInt:0x333333];
    self.titleLabel.frame = CGRectMake(47, 15, 100, 15);
    [self.contentView addSubview:self.titleLabel];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.bottom-0.5, MY_ScreenWidth, 0.5)];
    line.backgroundColor = [MY_Util setColorWithInt:0xbbbbbb];
    [self.contentView addSubview:line];
    
    UIImageView *arrow = [[UIImageView alloc] initWithFrame:CGRectMake(MY_ScreenWidth-20-6, 0, 6, 12)];
    arrow.centerY = self.centerY;
    arrow.image = [UIImage imageNamed:@"arrow"];
    [self.contentView addSubview:arrow];
}

- (void)setObject:(id)object indexPath:(NSIndexPath *)indexpath {
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    return 45;
}

@end
