//
//  MY_TrainRecordCell.m
//  Doctor
//
//  Created by 王翼天 on 2017/4/17.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_TrainRecordCell.h"
#import "MY_TrainRecordModel.h"

@interface MY_TrainRecordCell ()
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@end

@implementation MY_TrainRecordCell

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
    
    CGFloat imgHeight = (MY_ScreenWidth-30)*140/(375-30);
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, headerLineView.bottom+10, MY_ScreenWidth-30, imgHeight)];
    [self.contentView addSubview:self.imgView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.imgView.bottom+17, self.imgView.width, 15)];
    self.titleLabel.font = MY_Font(15);
    self.titleLabel.textColor = [MY_Util setColorWithInt:0x333333];
    [self.contentView addSubview:self.titleLabel];
    
    self.detailLabel = [[UILabel alloc] init];
    self.detailLabel.textColor = [MY_Util setColorWithInt:0x666666];
    self.detailLabel.font = MY_Font(13);
    self.detailLabel.numberOfLines = 4;
    [self.contentView addSubview:self.detailLabel];
}

- (void)setObject:(id)object indexPath:(NSIndexPath *)indexpath {
    MY_TrainRecordModel *model = (MY_TrainRecordModel*)object;
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.url] placeholderImage:[UIImage imageNamed:@"default"]];
    
    self.titleLabel.text = model.title;
    
    NSString *detail = model.abst;
//    NSString *detail = @"回家看到舒服哈尽快恢复健康后回家看到舒服哈尽快恢复健康后回家看到舒服哈尽快恢复健康后回家看到舒服";
    
    CGFloat height = [self.detailLabel getLabelHeightWithSpaceHeight:10 withFont:13 withStr:detail withTextColor:[MY_Util setColorWithInt:0x666666] withLabelWidth:MY_ScreenWidth-15*2];
    if (height >= 93) {
        height = 93;
    }
    self.detailLabel.frame = CGRectMake(15, self.titleLabel.bottom+10, MY_ScreenWidth-15*2, height);
    
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    return 315-140+(MY_ScreenWidth-30)*140/(375-30);
}

@end
