//
//  MY_MessageCell.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/20.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_MessageCell.h"
#import "MY_MessageModel.h"
@interface MY_MessageCell ()
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *messageLabel;
@property (nonatomic, strong) UIView *lineView;
@end

@implementation MY_MessageCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.font = MY_Font(11);
    self.timeLabel.textColor = [UIColor whiteColor];
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    self.timeLabel.layer.masksToBounds = YES;
    self.timeLabel.layer.cornerRadius = 2;
    self.timeLabel.backgroundColor = [MY_Util setColorWithInt:0xdddddd];
    [self.contentView addSubview:self.timeLabel];
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@20);
        make.size.mas_equalTo(CGSizeMake(150, 25));
        make.centerX.mas_equalTo(self);
    }];
    
    self.messageLabel = [[UILabel alloc] init];
    self.messageLabel.textColor = [MY_Util setColorWithInt:0x333333];
    self.messageLabel.numberOfLines = 0;
    self.messageLabel.font = MY_Font(14);
    [self.contentView addSubview:self.messageLabel];
    
    self.lineView = [[UIView alloc] init];
    self.lineView.backgroundColor = [UIColor clearColor];
    self.lineView.layer.borderColor = [MY_Util setColorWithInt:0xdddddd].CGColor;
    self.lineView.layer.borderWidth = 1;
    [self.contentView addSubview:self.lineView];
}

- (void)setObject:(id)object indexPath:(NSIndexPath *)indexpath {
    MY_MessageModel *model = (MY_MessageModel*)object;
    
    self.timeLabel.text = model.time;
    
    CGSize size = [model.message sizeWithFont:MY_Font(14) andSize:CGSizeMake(MY_ScreenWidth - 30*2, MAXFLOAT)];
    self.messageLabel.text = model.message;
    [self.messageLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(@30);
        make.top.mas_equalTo(self.timeLabel.mas_bottom).with.offset(25);
        make.size.mas_equalTo(CGSizeMake(MY_ScreenWidth-30*2, size.height+5));
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.messageLabel).with.offset(-10);
        make.top.mas_equalTo(self.messageLabel).with.offset(-10);
        make.right.mas_equalTo(self.messageLabel).with.offset(10);
        make.bottom.mas_equalTo(self.messageLabel).with.offset(10);
    }];
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    MY_MessageModel *model = (MY_MessageModel*)object;
    CGSize size = [model.message sizeWithFont:MY_Font(14) andSize:CGSizeMake(MY_ScreenWidth - 30*2, MAXFLOAT)];
    return size.height+10*2+10+15+20+25+5;
}

@end
