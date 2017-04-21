//
//  MY_PatientScheduleCell.m
//  Doctor
//
//  Created by 王翼天 on 2017/4/19.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_PatientScheduleCell.h"
#import "MY_PatientScheduleModel.h"
@interface MY_PatientScheduleCell ()
@property (nonatomic, strong) UIImageView *circleImageView;
@property (nonatomic, strong) UIView *topLineView;
@property (nonatomic, strong) UIView *bottomLineView;
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
    self.circleImageView = [[UIImageView alloc] initWithFrame:CGRectMake(38, 2, 12, 12)];
    [self.contentView addSubview:self.circleImageView];
    
    self.topLineView = [[UIView alloc] init];
    self.topLineView.backgroundColor = [MY_Util setColorWithInt:0x68d6a7];
    [self.contentView addSubview:self.topLineView];
    
    self.bottomLineView = [[UIView alloc] init];
    self.bottomLineView.backgroundColor = [MY_Util setColorWithInt:0x68d6a7];
    [self.contentView addSubview:self.bottomLineView];
    
    self.detailLabel = [[UILabel alloc] init];
    self.detailLabel.textColor = [MY_Util setColorWithInt:0x666666];
    self.detailLabel.numberOfLines = 0;
    self.detailLabel.font = MY_Font(14);
    [self.contentView addSubview:self.detailLabel];
    
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.textColor = [MY_Util setColorWithInt:0x666666];
    self.timeLabel.font = MY_Font(12);
    [self.contentView addSubview:self.timeLabel];
}

- (void)setObject:(id)object indexPath:(NSIndexPath *)indexpath {
    MY_PatientScheduleModel *model = (MY_PatientScheduleModel*)object;
    self.circleImageView.image = model.status?[UIImage imageNamed:@"schedule_circle"]:[UIImage imageNamed:@"schedule_circle_empty"];
    
    self.detailLabel.text = model.detail;
    CGSize size = [model.detail sizeWithFont:MY_Font(14) andSize:CGSizeMake(MY_ScreenWidth-65-15, MAXFLOAT)];
    self.detailLabel.frame = CGRectMake(65, 0, MY_ScreenWidth-65-15, size.height);
    
    self.timeLabel.text = model.time;
    self.timeLabel.frame = CGRectMake(self.detailLabel.left, self.detailLabel.bottom+10, MY_ScreenWidth-65-15, 12);
    
    if (model.isFirst && model.isLast) {
        self.topLineView.hidden = YES;
        self.bottomLineView.hidden = YES;
    } else {
        if (model.isFirst) {
            self.topLineView.hidden = YES;
            self.bottomLineView.hidden = NO;
            [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self.circleImageView);
                make.top.mas_equalTo(self.circleImageView.mas_bottom);
                make.width.mas_equalTo(@1);
                make.bottom.mas_equalTo(self.contentView);
            }];
        } else if (model.isLast) {
            self.topLineView.hidden = NO;
            self.bottomLineView.hidden = YES;
            [self.topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self.circleImageView);
                make.top.mas_equalTo(self.contentView);
                make.width.mas_equalTo(@1);
                make.bottom.mas_equalTo(self.circleImageView.mas_top);
            }];
        } else {
            self.topLineView.hidden = NO;
            self.bottomLineView.hidden = NO;
            [self.topLineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self.circleImageView);
                make.top.mas_equalTo(self.contentView);
                make.width.mas_equalTo(@1);
                make.bottom.mas_equalTo(self.circleImageView.mas_top);
            }];
            [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
                make.centerX.mas_equalTo(self.circleImageView);
                make.top.mas_equalTo(self.circleImageView.mas_bottom);
                make.width.mas_equalTo(@1);
                make.bottom.mas_equalTo(self.contentView);
            }];
        }
    }
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    MY_PatientScheduleModel *model = (MY_PatientScheduleModel*)object;
    CGSize size = [model.detail sizeWithFont:MY_Font(14) andSize:CGSizeMake(MY_ScreenWidth-65-15, MAXFLOAT)];
    return 70 + (size.height - 15);
}

@end
