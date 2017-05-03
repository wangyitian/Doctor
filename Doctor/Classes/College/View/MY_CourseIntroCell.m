//
//  MY_CourseIntroCell.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/27.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_CourseIntroCell.h"
#import "MY_CourseIntroModel.h"
@interface MY_CourseIntroCell ()
@property (nonatomic, strong) UIImageView *imgView;
@end
@implementation MY_CourseIntroCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UIView *space = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, 10)];
    space.backgroundColor = [MY_Util setColorWithInt:0xf4f4f4];
    [self.contentView addSubview:space];
    
    self.imgView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imgView];
    
}

- (void)setObject:(id)object indexPath:(NSIndexPath *)indexpath {
    MY_CourseIntroModel *model = (MY_CourseIntroModel*)object;
    
    self.imgView.frame = CGRectMake(0, 10, MY_ScreenWidth, MY_ScreenWidth*model.height/model.width);
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.adurl] placeholderImage:nil];
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    MY_CourseIntroModel *model = (MY_CourseIntroModel*)object;
    return MY_ScreenWidth*model.height/model.width + 10;
}
@end
