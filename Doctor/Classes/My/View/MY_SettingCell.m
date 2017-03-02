//
//  MY_SettingCell.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/20.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_SettingCell.h"
@interface MY_SettingCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *valueLabel;
@property (nonatomic, strong) UIImageView *arrowImageView;
@property (nonatomic, strong) UIView *bottomLineView;
@end
@implementation MY_SettingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.titleLabel = [[UILabel alloc] init];
    self.titleLabel.font = MY_Font(15);
    self.titleLabel.textColor = [MY_Util setColorWithInt:0x666666];
    [self.contentView addSubview:self.titleLabel];
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@20);
        make.top.equalTo(@15);
        make.height.equalTo(@15);
        make.width.equalTo(@70);
    }];
    
    self.valueLabel = [[UILabel alloc] init];
    self.valueLabel.font = MY_Font(14);
    self.valueLabel.textColor = [MY_Util setColorWithInt:0xbbbbbb];
    self.valueLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.valueLabel];
    [self.valueLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).with.offset(-20);
        make.top.mas_equalTo(self.titleLabel);
        make.height.mas_equalTo(self.titleLabel);
        make.width.mas_equalTo(@100);
    }];
    
    self.arrowImageView = [[UIImageView alloc] init];
    self.arrowImageView.image = [UIImage imageNamed:@"arrow"];
    [self addSubview:self.arrowImageView];
    [self.arrowImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).with.offset(-20);
        make.size.mas_equalTo(CGSizeMake(7, 7));
        make.centerY.mas_equalTo(self);
    }];
    
    self.bottomLineView = [[UIView alloc] init];
    self.bottomLineView.backgroundColor = [MY_Util setColorWithInt:0xbbbbbb];
    [self addSubview:self.bottomLineView];
    [self.bottomLineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@6);
        make.right.mas_equalTo(self).with.offset(-6);
        make.bottom.mas_equalTo(self);
        make.height.mas_equalTo(@0.5);
    }];
}

- (void)setObject:(id)object indexPath:(NSIndexPath *)indexpath {
    self.titleLabel.text = (NSString*)object;
    self.valueLabel.text = [MY_Util getCacheSize];
    
    self.bottomLineView.hidden = YES;
    if (indexpath.section == 0) {
        self.valueLabel.hidden = NO;
        self.arrowImageView.hidden = YES;
    } else {
        self.valueLabel.hidden = YES;
        self.arrowImageView.hidden = NO;
        if (indexpath.row == 0) {
            self.bottomLineView.hidden = NO;
        }
    }
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    return 44;
}


@end
