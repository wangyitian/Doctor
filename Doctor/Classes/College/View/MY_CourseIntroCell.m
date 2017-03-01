//
//  MY_CourseIntroCell.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/27.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_CourseIntroCell.h"
@interface MY_CourseIntroCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIImageView *dotView;
@property (nonatomic, strong) UILabel *secondLabel;
@property (nonatomic, strong) UILabel *detailLabel;
@property (nonatomic, strong) UIView *detailView;
@end
@implementation MY_CourseIntroCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15, 0, 15)];
    self.titleLabel.font = MY_Font(15);
    self.titleLabel.textColor = [MY_Util setColorWithInt:0x333333];
    [self.contentView addSubview:self.titleLabel];
    
    self.dotView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 4, 4)];
    self.dotView.image = [UIImage imageNamed:@"dot"];
    [self.contentView addSubview:self.dotView];
    
    self.secondLabel = [[UILabel alloc] init];
    self.secondLabel.font = MY_Font(15);
    self.secondLabel.textColor = [MY_Util setColorWithInt:0x333333];
    [self.contentView addSubview:self.secondLabel];
    
    self.detailView = [[UIView alloc] init];
    [self.contentView addSubview:self.detailView];
    
    self.detailLabel = [[UILabel alloc] init];
    self.detailLabel.textColor = [MY_Util setColorWithInt:0x666666];
    self.detailLabel.numberOfLines = 0;
    self.detailLabel.font = MY_Font(14);
    [self.contentView addSubview:self.detailLabel];
    
}

- (void)setObject:(id)object indexPath:(NSIndexPath *)indexpath {
    NSArray *colorArray = [NSArray arrayWithObjects:[MY_Util setColorWithInt:0xffffff],[MY_Util setColorWithInt:0xfffde4],[MY_Util setColorWithInt:0xeee8ff],[MY_Util setColorWithInt:0xe9f3ff],[MY_Util setColorWithInt:0xe2fae1], nil];
    self.contentView.backgroundColor = colorArray[indexpath.section];
    if (indexpath.section == 0) {
        
    } else {
        
    }
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    return 200;
}
@end
