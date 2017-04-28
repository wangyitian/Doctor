//
//  MY_ExperienceCell.m
//  Doctor
//
//  Created by 王翼天 on 2017/4/17.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_ExperienceCell.h"
#import "MY_ExperienceModel.h"
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
@property (nonatomic, weak) NSIndexPath *indexPath;
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
    
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.font = MY_Font(12);
    self.timeLabel.textColor = [MY_Util setColorWithInt:0x999999];
    [self.contentView addSubview:self.timeLabel];
    
    self.detailLabel = [[UILabel alloc] init];
    self.detailLabel.numberOfLines = 0;
    self.detailLabel.font = MY_Font(14);
    self.detailLabel.textColor = [MY_Util setColorWithInt:0x666666];
    [self.contentView addSubview:self.detailLabel];
    
    self.seeAllButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.seeAllButton setTitle:@"查看全文" forState:UIControlStateNormal];
    [self.seeAllButton setTitle:@"收起全文" forState:UIControlStateSelected];
    [self.seeAllButton setTitleColor:[MY_Util setColorWithInt:0x68d6a7] forState:UIControlStateNormal];
    [self.seeAllButton setTitleColor:[MY_Util setColorWithInt:0x68d6a7] forState:UIControlStateSelected];
    self.seeAllButton.titleLabel.font = MY_Font(14);
    [self.seeAllButton addTarget:self action:@selector(seeAllButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.seeAllButton];
    
    self.projectLabel = [[UILabel alloc] init];
    self.projectLabel.textColor = [UIColor whiteColor];
    self.projectLabel.font = MY_Font(12);
    self.projectLabel.backgroundColor = [MY_Util setColorWithInt:0x68d6a7];
    self.projectLabel.layer.masksToBounds = YES;
    self.projectLabel.layer.cornerRadius = 10;
    self.projectLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.projectLabel];
    
    self.zanButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [self.zanButton addTarget:self action:@selector(zanButtonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.zanButton];
    
}

- (void)setObject:(id)object indexPath:(NSIndexPath *)indexpath {
    MY_ExperienceModel *model = (MY_ExperienceModel*)object;
    self.indexPath = indexpath;
    
    [self.avatarView sd_setImageWithURL:[NSURL URLWithString:model.head] placeholderImage:[UIImage imageNamed:@"default"]];
    
    CGFloat nameWidth = [model.nickname sizeWithFont:MY_Font(15)].width;
    self.nameLabel.text = model.nickname;
    self.nameLabel.frame = CGRectMake(self.avatarView.right+16, 35, nameWidth, 15);
    
    self.lineView.frame = CGRectMake(self.nameLabel.right+8, self.nameLabel.top, 1, self.nameLabel.height);
    
    CGFloat positionWidth = [model.department sizeWithFont:MY_Font(12)].width;
    self.positionLabel.text = model.department;
    self.positionLabel.frame = CGRectMake(self.lineView.right+8, self.nameLabel.top, positionWidth, self.nameLabel.height);
    
    CGFloat timeWidth = [model.date sizeWithFont:MY_Font(12)].width;
    self.timeLabel.text = model.date;
    self.timeLabel.frame = CGRectMake(MY_ScreenWidth-15-timeWidth, self.nameLabel.top, timeWidth, self.nameLabel.height);
    
    NSString *experience = model.experience;
    
    CGFloat height = [self.detailLabel getLabelHeightWithSpaceHeight:10 withFont:14 withStr:experience withTextColor:[MY_Util setColorWithInt:0x666666] withLabelWidth:MY_ScreenWidth-15-65];
    
    if (height > 125) {
        if (model.isOpen) {
            self.detailLabel.numberOfLines = 0;
            self.seeAllButton.selected = YES;
        } else {
            height = 125;
            self.detailLabel.numberOfLines = 5;
            self.seeAllButton.selected = NO;
        }
        
        self.seeAllButton.hidden = NO;
        self.detailLabel.frame = CGRectMake(65, 70, MY_ScreenWidth-15-65, height);
        self.seeAllButton.frame = CGRectMake(45, self.detailLabel.bottom+10, 100, 25);
        self.projectLabel.frame = CGRectMake(65, self.seeAllButton.bottom+10, 200, 20);
        self.projectLabel.width = MY_Iphone4or5?150:200;
    } else {
        self.seeAllButton.hidden = YES;
        self.detailLabel.frame = CGRectMake(65, 70, MY_ScreenWidth-15-65, height);
        self.projectLabel.frame = CGRectMake(65, self.detailLabel.bottom+10, 200, 20);
        self.projectLabel.width = MY_Iphone4or5?150:200;
    }
    self.projectLabel.text = model.project;
    
    CGFloat zanWidth = [model.dianzan sizeWithFont:MY_Font(12)].width + 16;
    CGFloat buttonWidth = zanWidth + 14;
    [self.zanButton setImage:[UIImage imageNamed:@"zan"] forState:UIControlStateNormal];
    [self.zanButton setImage:[UIImage imageNamed:@"zan_s"] forState:UIControlStateSelected];
    [self.zanButton setTitle:model.dianzan forState:UIControlStateNormal];
    [self.zanButton setTitle:model.dianzan forState:UIControlStateSelected];
    [self.zanButton setTitleColor:[MY_Util setColorWithInt:0x999999] forState:UIControlStateNormal];
    self.zanButton.titleLabel.font = MY_Font(12);
    self.zanButton.frame = CGRectMake(MY_ScreenWidth-20-buttonWidth, self.projectLabel.top, buttonWidth, 20);
    self.zanButton.imageEdgeInsets = UIEdgeInsetsMake(3, 0, 3, buttonWidth-14);
    self.zanButton.titleEdgeInsets = UIEdgeInsetsMake(0, 14, 0, 0);
    
    __weak typeof(self) weakSelf = self;
    self.zanBlock = ^() {
        weakSelf.zanButton.selected = !weakSelf.zanButton.selected;
        NSString *zanCount = weakSelf.zanButton.titleLabel.text;
        if (weakSelf.zanButton.selected) {
            zanCount = [NSString stringWithFormat:@"%ld",[zanCount integerValue]+1];
        } else {
            zanCount = [NSString stringWithFormat:@"%ld",[zanCount integerValue]-1];
        }
        [weakSelf.zanButton setTitle:zanCount forState:UIControlStateNormal];
        [weakSelf.zanButton setTitle:zanCount forState:UIControlStateSelected];
        CGFloat zanWidth = [zanCount sizeWithFont:MY_Font(12)].width + 16;
        CGFloat buttonWidth = zanWidth + 14;
        weakSelf.zanButton.frame = CGRectMake(MY_ScreenWidth-20-buttonWidth, weakSelf.projectLabel.top, buttonWidth, 20);
        weakSelf.zanButton.imageEdgeInsets = UIEdgeInsetsMake(3, 0, 3, buttonWidth-14);
        weakSelf.zanButton.titleEdgeInsets = UIEdgeInsetsMake(0, 14, 0, 0);
    };
}

- (void)seeAllButtonAction:(UIButton*)button {
    if ([self.delegate respondsToSelector:@selector(seeAllActionWithIndexPath:)]) {
        [self.delegate seeAllActionWithIndexPath:self.indexPath];
    }
}

- (void)zanButtonAction:(UIButton*)button {
    if ([self.delegate respondsToSelector:@selector(zanActionWithIndexPath: isZan:)]) {
        [self.delegate zanActionWithIndexPath:self.indexPath isZan:[NSString stringWithFormat:@"%d",!button.selected]];
    }
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    MY_ExperienceModel *model = (MY_ExperienceModel*)object;
    
    CGFloat detailHeight = [model.experience getHeightWithSpaceHeight:10 withFont:14 withStr:model.experience withWidth:MY_ScreenWidth-15-65];
    if (detailHeight > 125) {
        
        if (!model.isOpen) {
            detailHeight = 125;
        }
        
        return 70+detailHeight+10+25+10+20+20;
    } else {
        return 70+detailHeight+10+20+20;
    }
}

@end
