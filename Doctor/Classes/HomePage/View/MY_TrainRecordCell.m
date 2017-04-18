//
//  MY_TrainRecordCell.m
//  Doctor
//
//  Created by 王翼天 on 2017/4/17.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_TrainRecordCell.h"


@interface MY_TrainRecordCell ()
@property (nonatomic, strong) UIImageView *imgView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@end

@implementation MY_TrainRecordCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

- (void)setupUI {
    UIView *headerLineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, 5)];
    headerLineView.backgroundColor = [MY_Util setColorWithInt:0xf4f4f4];
    [self.contentView addSubview:headerLineView];
    
    
    CGFloat imgHeight = (MY_ScreenWidth-30)*140/(320-30);
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(15, headerLineView.bottom+10, MY_ScreenWidth, imgHeight)];
    [self.contentView addSubview:self.imgView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.imgView.bottom+17, self.imgView.width, 15)];
    self.titleLabel.font = MY_Font(15);
    self.titleLabel.textColor = [MY_Util setColorWithInt:0x333333];
    [self.contentView addSubview:self.titleLabel];
    
    self.detailLabel = [[UILabel alloc] init];
//    self.detailLabel.
}

- (void)setObject:(id)object indexPath:(NSIndexPath *)indexpath {
    
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    return 0;
}

@end
