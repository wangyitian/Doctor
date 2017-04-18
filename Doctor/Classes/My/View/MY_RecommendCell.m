//
//  MY_RecommendCell.m
//  Doctor
//
//  Created by 王翼天 on 2017/4/18.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_RecommendCell.h"
#import "MY_RecommendModel.h"
@interface MY_RecommendCell ()
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) UIView *lineView;
@end


@implementation MY_RecommendCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 200, 14)];
    self.nameLabel.font = MY_Font(14);
    self.nameLabel.textColor = [MY_Util setColorWithInt:0x333333];
    [self.contentView addSubview:self.nameLabel];
    
    UIImageView *arrowView = [[UIImageView alloc] initWithFrame:CGRectMake(MY_ScreenWidth-20-6, (44-12)/2, 6, 12)];
    arrowView.image = [UIImage imageNamed:@"arrow"];
    [self.contentView addSubview:arrowView];
    
    self.lineView = [[UIView alloc] initWithFrame:CGRectMake(6, 0, MY_ScreenWidth-6*2, 0.5)];
    self.lineView.backgroundColor = [MY_Util setColorWithInt:0xbbbbbb];
    [self.contentView addSubview:self.lineView];
}

- (void)setObject:(id)object indexPath:(NSIndexPath *)indexpath {
    MY_RecommendModel *model = (MY_RecommendModel*)object;
    if (model.isFirst) {
        self.lineView.hidden = YES;
    } else {
        self.lineView.hidden = NO;
    }
    self.nameLabel.text = model.name;
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    return 44;
}

@end
