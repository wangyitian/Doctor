//
//  MY_PersonalAvatarCell.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/21.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_PersonalAvatarCell.h"
@interface MY_PersonalAvatarCell ()
@property (nonatomic, strong) UIImageView *avatarImageView;
@end
@implementation MY_PersonalAvatarCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.avatarImageView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 13, 50, 50)];
    self.avatarImageView.layer.masksToBounds = YES;
    self.avatarImageView.layer.cornerRadius = 25;
    self.avatarImageView.clipsToBounds = YES;
    self.avatarImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.contentView addSubview:self.avatarImageView];
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(MY_ScreenWidth-36-200, 0, 200, 15)];
    titleLabel.centerY = self.avatarImageView.centerY;
    titleLabel.font = MY_Font(13);
    titleLabel.textColor = [MY_Util setColorWithInt:0x999999];
    titleLabel.textAlignment = NSTextAlignmentRight;
    titleLabel.text = @"修改头像";
    [self.contentView addSubview:titleLabel];
    
    UIImageView *arrowImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"arrow"]];
    arrowImageView.frame = CGRectMake(MY_ScreenWidth-20-6, 0, 6, 12);
    arrowImageView.centerY = self.avatarImageView.centerY;
    [self.contentView addSubview:arrowImageView];
    
    UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 75-0.5, MY_ScreenWidth, 0.5)];
    lineView.backgroundColor = [MY_Util setColorWithInt:0xbbbbbb];
    [self.contentView addSubview:lineView];
}

- (void)setObject:(id)object indexPath:(NSIndexPath *)indexpath {
    MY_AccountModel *account = [MY_Util getAccountModel];
    [self.avatarImageView sd_setImageWithURL:[NSURL URLWithString:account.head] placeholderImage:[UIImage imageNamed:@"icon"]];
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    return 75;
}
@end
