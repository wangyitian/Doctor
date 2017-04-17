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
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 0, 70, 16)];
    self.titleLabel.centerY = self.centerY;
    self.titleLabel.font = MY_Font(15);
    self.titleLabel.textColor = [MY_Util setColorWithInt:0x333333];
    [self.contentView addSubview:self.titleLabel];
    
    self.valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(MY_ScreenWidth-36-200, 0, 200, 15)];
    self.valueLabel.centerY = self.centerY;
    self.valueLabel.font = MY_Font(13);
    self.valueLabel.textAlignment = NSTextAlignmentRight;
    self.valueLabel.textColor = [MY_Util setColorWithInt:0x999999];
    [self.contentView addSubview:self.valueLabel];
    
    UIImageView *arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
    arrowImageView.frame = CGRectMake(MY_ScreenWidth-20-6, 0, 6, 12);
    arrowImageView.centerY = self.centerY;
    [self.contentView addSubview:arrowImageView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.bottom-0.5, MY_ScreenWidth, 0.5)];
    lineView.backgroundColor = [MY_Util setColorWithInt:0xbbbbbb];
    [self.contentView addSubview:lineView];
}

- (void)setObject:(id)object indexPath:(NSIndexPath *)indexpath {
    MY_AccountModel *account = [MY_Util getAccountModel];
    if (indexpath.row == 1) {
        self.valueLabel.text = account.nickname;
    } else if (indexpath.row == 2) {
        self.valueLabel.text = account.username;
    } else if (indexpath.row == 3) {
        self.valueLabel.text = account.phonen;
    } else if (indexpath.row == 4) {
        self.valueLabel.text = account.department;
    } else if (indexpath.row == 5) {
        self.valueLabel.text = account.hospital;
    }
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    return 44;
}

@end
