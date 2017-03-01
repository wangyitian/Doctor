//
//  MY_CourseCell.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/20.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_CourseCell.h"
@interface MY_CourseCell ()
@property (nonatomic, strong) UIImageView *courseImageView;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *roomTypeLabel;
@property (nonatomic, strong) UIScrollView *scrollView;
@property (nonatomic, strong) UILabel *introLabel;

@end

@implementation MY_CourseCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    CGFloat imageH = 140*MY_ScreenWidth/375;
    self.courseImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, imageH)];
    [self.contentView addSubview:self.courseImageView];
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.courseImageView.bottom + 18, 150, 15)];
    self.titleLabel.font = MY_Font(15);
    self.titleLabel.textColor = [MY_Util setColorWithInt:0x333333];
    [self.contentView addSubview:self.titleLabel];
    
    self.roomTypeLabel = [[UILabel alloc] initWithFrame:CGRectMake(MY_ScreenWidth-15-140, self.titleLabel.top, 140, 15)];
    self.roomTypeLabel.font = MY_Font(14);
    self.roomTypeLabel.textColor = [MY_Util setColorWithInt:0x68d6a7];
    self.roomTypeLabel.textAlignment = NSTextAlignmentRight;
    [self.contentView addSubview:self.roomTypeLabel];
    
    self.scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.roomTypeLabel.bottom + 12, MY_ScreenWidth, 20)];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.contentView addSubview:self.scrollView];
    
    self.introLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.scrollView.bottom + 10, MY_ScreenWidth - 15*2, 0)];
    self.introLabel.numberOfLines = 3;
    self.introLabel.font = MY_Font(14);
    self.introLabel.textColor = [MY_Util setColorWithInt:0x666666];
    [self.contentView addSubview:self.introLabel];
    
}

- (void)setObject:(id)object indexPath:(NSIndexPath *)indexpath {
    
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    return 200;
}

@end
