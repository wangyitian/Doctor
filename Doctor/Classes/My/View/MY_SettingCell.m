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
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 70, 15)];
    self.titleLabel.font = MY_Font(15);
    self.titleLabel.textColor = [MY_Util setColorWithInt:0x666666];
    [self.contentView addSubview:self.titleLabel];
    
    self.valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(MY_ScreenWidth-20-100, self.titleLabel.top, 100, self.titleLabel.height)];
    self.valueLabel.font = MY_Font(14);
    self.valueLabel.textColor = [MY_Util setColorWithInt:0xbbbbbb];
    self.valueLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.valueLabel];
    
    self.arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(MY_ScreenWidth-20-6, 0, 6, 12)];
    self.arrowImageView.centerY = self.centerY;
    self.arrowImageView.image = [UIImage imageNamed:@"arrow"];
    [self addSubview:self.arrowImageView];
    
    self.bottomLineView = [[UIView alloc] initWithFrame:CGRectMake(6, self.bottom-0.5, MY_ScreenWidth-6*2, 0.5)];
    self.bottomLineView.backgroundColor = [MY_Util setColorWithInt:0xbbbbbb];
    [self addSubview:self.bottomLineView];
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
