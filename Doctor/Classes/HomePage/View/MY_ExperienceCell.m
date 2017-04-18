//
//  MY_ExperienceCell.m
//  Doctor
//
//  Created by 王翼天 on 2017/4/17.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_ExperienceCell.h"

@interface MY_ExperienceCell ()
@property (nonatomic, strong) UIImageView *avatarView;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIView *lineView;
@property (nonatomic, strong) UILabel *positionLabel;
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIButton *seeAllButton;
@property (nonatomic, strong) UILabel *projectLabel;
@property (nonatomic, strong) UIButton *zanButton;
@property (nonatomic, assign) BOOL isOpen;
@end

@implementation MY_ExperienceCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UIView *headerLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, 5)];
    headerLineView.backgroundColor = [MY_Util setColorWithInt:0xf4f4f4];
    [self.contentView addSubview:headerLineView];
    
    self.avatarView = [[UIImageView alloc] initWithFrame:CGRectMake(15, headerLineView.bottom+20, 34, 34)];
    [self.contentView addSubview:self.avatarView];
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.textColor = [MY_Util setColorWithInt:0x333333];
    self.nameLabel.font = MY_Font(15);
    [self.contentView addSubview:self.nameLabel];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = [MY_Util setColorWithInt:0x999999];
    [self.contentView addSubview:self.lineView];
    
    self.positionLabel = [[UILabel alloc] init];
    self.positionLabel.font = MY_Font(12);
    self.positionLabel.textColor = [MY_Util setColorWithInt:0x999999];
    [self.contentView addSubview:self.positionLabel];
    
    self.detailLabel = [[UILabel alloc] init];
    [self.contentView addSubview:self.detailLabel];
    
    self.seeAllButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:self.seeAllButton];
    
    self.projectLabel = [[UILabel alloc] init];
    self.projectLabel.textColor = [UIColor whiteColor];
    self.projectLabel.font = MY_Font(13);
    self.projectLabel.backgroundColor = [MY_Util setColorWithInt:0x68d6a7];
    self.projectLabel.layer.masksToBounds = YES;
    self.projectLabel.layer.cornerRadius = 10;
    [self.contentView addSubview:self.projectLabel];
    
    self.zanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.contentView addSubview:self.zanButton];
    
}

- (void)setObject:(id)object indexPath:(NSIndexPath *)indexpath {
    
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    return 0;
}

@end
