//
//  MY_LiveCell.m
//  Doctor
//
//  Created by 王翼天 on 2017/7/10.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_LiveCell.h"
#import "MY_LiveModel.h"
@interface MY_LiveCell ()
@property (nonatomic, strong) UIImageView *photoView;

@property (nonatomic, strong) UILabel *tagLabel;

@property (nonatomic, strong) UILabel *titleLabel;
@end

@implementation MY_LiveCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    CGFloat photoHeight = 140*(MY_ScreenWidth-10)/(375-10);
    self.photoView = [[UIImageView alloc] initWithFrame:CGRectMake(5, 5, MY_ScreenWidth-5*2, photoHeight)];
    [self.contentView addSubview:self.photoView];
    
    self.tagLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.photoView.width-10-50, 10, 50, 20)];
    self.tagLabel.font = MY_Font(14);
    self.tagLabel.textAlignment = NSTextAlignmentCenter;
    self.tagLabel.textColor = [MY_Util setColorWithInt:0x68d6a7];
    self.tagLabel.layer.borderColor = [MY_Util setColorWithInt:0x68d6a7].CGColor;
    self.tagLabel.layer.borderWidth = 1;
    self.tagLabel.layer.masksToBounds = YES;
    self.tagLabel.layer.cornerRadius = 7.5;
    self.tagLabel.alpha = 0.8;
    [self.photoView addSubview:self.tagLabel];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, self.photoView.bottom+5, MY_ScreenWidth-5*2, 15)];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.textColor = [MY_Util setColorWithInt:0x666666];
    [self.contentView addSubview:self.titleLabel];
}

- (void)setObject:(id)object indexPath:(NSIndexPath *)indexpath {
    MY_LiveModel *model = (MY_LiveModel*)object;
    [self.photoView sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:model.photo]];
    
    self.titleLabel.text = model.title;
    self.tagLabel.text = model.isLive? @"直播":@"点播";
}

@end
