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
    self.imgView = [[UIImageView alloc] init];
    [self.contentView addSubview:self.imgView];
    
}

- (void)setObject:(id)object indexPath:(NSIndexPath *)indexpath {
    MY_CourseIntroModel *model = (MY_CourseIntroModel*)object;
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:model.adurl] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        self.imgView.frame = CGRectMake(0, 0, image.size.width, image.size.height);
    }];
    
    self.imgView.backgroundColor = [UIColor redColor];
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    MY_CourseIntroModel *model = (MY_CourseIntroModel*)object;
    UIImageView *images = [[UIImageView alloc] init];
    [images sd_setImageWithURL:[NSURL URLWithString:model.adurl] placeholderImage:nil completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
//        return image.size.height + 10;
        
    }];
    return images.image.size.height + 10;
}
@end
