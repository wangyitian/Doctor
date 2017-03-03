//
//  MY_PersonalDataCell.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/20.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_PersonalDataCell.h"
@interface MY_PersonalDataCell ()

@end
@implementation MY_PersonalDataCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

+ (MY_PersonalDataCell *)cellWithTablebView:(UITableView *)tableView index:(NSIndexPath *)indexPath{
    static NSString *indent = @"MY_PersonalDataCell";
    [tableView registerClass:[MY_PersonalDataCell class] forCellReuseIdentifier:indent];
    MY_PersonalDataCell  *cell = [tableView dequeueReusableCellWithIdentifier:indent];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    if (indexPath.row == 1) {
        cell.titleLabel.text = @"昵称";
    } else if (indexPath.row == 2) {
        cell.titleLabel.text = @"真实姓名";
    } else if (indexPath.row == 3) {
        cell.titleLabel.text = @"手机号码";
    } else if (indexPath.row == 4) {
        cell.titleLabel.text = @"科室";
    } else if (indexPath.row == 5) {
        cell.titleLabel.text = @"医院";
    }
    
    return cell;
}

- (void)setupUI {
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = MY_Font(15);
    self.titleLabel.textColor = [MY_Util setColorWithInt:0x333333];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@20);
        make.centerY.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(70, 16));
    }];
    
    self.valueLabel = [[UILabel alloc] init];
    self.valueLabel.font = MY_Font(13);
    self.valueLabel.textAlignment = NSTextAlignmentRight;
    self.valueLabel.textColor = [MY_Util setColorWithInt:0x999999];
    [self.contentView addSubview:self.valueLabel];
    [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).with.offset(-36);
        make.centerY.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(200, 15));
    }];
    
    UIImageView *arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
    [self.contentView addSubview:arrowImageView];
    [arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).with.offset(-20);
        make.size.mas_equalTo(CGSizeMake(7, 7));
        make.centerY.mas_equalTo(self);
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [MY_Util setColorWithInt:0xbbbbbb];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@0);
        make.bottom.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(MY_ScreenWidth, 0.5));
    }];
}

- (void)setObject:(id)object indexPath:(NSIndexPath *)indexpath {
    
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    return 44;
}

@end
