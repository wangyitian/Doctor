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
    self.avatarImageView = [[UIImageView alloc] init];
    self.avatarImageView.layer.masksToBounds = YES;
    self.avatarImageView.layer.cornerRadius = 25;
    self.avatarImageView.backgroundColor = [UIColor redColor];
    [self.contentView addSubview:self.avatarImageView];
    [self.avatarImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(50, 50));
        make.left.mas_equalTo(@20);
        make.top.mas_equalTo(@13);
    }];
    
    UILabel *titleLabel = [[UILabel alloc] init];
    titleLabel.font = MY_Font(13);
    titleLabel.textColor = [MY_Util setColorWithInt:0x999999];
    titleLabel.textAlignment = NSTextAlignmentRight;
    titleLabel.text = @"修改头像";
    [self.contentView addSubview:titleLabel];
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).with.offset(-36);
        make.centerY.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(200, 15));
    }];
    
    UIView *lineView = [[UIView alloc] init];
    lineView.backgroundColor = [MY_Util setColorWithInt:0xbbbbbb];
    [self.contentView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self);
        make.bottom.mas_equalTo(self);
        make.size.mas_equalTo(CGSizeMake(MY_ScreenWidth, 0.5));
    }];
}

- (void)setObject:(id)object indexPath:(NSIndexPath *)indexpath {
    
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    return 75;
}
@end
