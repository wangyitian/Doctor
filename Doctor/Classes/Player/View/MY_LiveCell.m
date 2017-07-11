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
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(5, self.photoView.bottom+5, MY_ScreenWidth-5*2, 15)];
    self.titleLabel.font = [UIFont systemFontOfSize:14];
    self.titleLabel.textColor = [MY_Util setColorWithInt:0x666666];
    [self.contentView addSubview:self.titleLabel];
}

- (void)setObject:(id)object indexPath:(NSIndexPath *)indexpath {
    MY_LiveModel *model = (MY_LiveModel*)object;
    [self.photoView sd_setImageWithURL:nil placeholderImage:[UIImage imageNamed:model.photo]];
    
    self.titleLabel.text = model.title;
}

@end
