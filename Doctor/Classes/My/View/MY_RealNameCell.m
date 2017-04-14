//
//  MY_RealNameCell.m
//  Doctor
//
//  Created by 王翼天 on 2017/4/14.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_RealNameCell.h"
#import "MY_RealNameModel.h"
@interface MY_RealNameCell ()
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *requiredLabel;
@property (nonatomic, strong) UILabel *descLabel;
@property (nonatomic, strong) UIButton *imageButton;
@property (nonatomic, strong) NSIndexPath *indexPath;
@end

@implementation MY_RealNameCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = [UIColor whiteColor];
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, 15, 50, 15)];
    self.titleLabel.font = MY_Font(15);
    self.titleLabel.textColor = [MY_Util setColorWithInt:0x333333];
    [self.contentView addSubview:self.titleLabel];
    
    self.requiredLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLabel.right+15, 15, 55, 15)];
    self.requiredLabel.textColor = [MY_Util setColorWithInt:0xbbbbbb];
    self.requiredLabel.text = @"(必填)";
    self.requiredLabel.font = MY_Font(12);
    [self.contentView addSubview:self.requiredLabel];
    
    self.descLabel = [[UILabel alloc] initWithFrame:CGRectMake(20, self.titleLabel.bottom+15, 180, 50)];
    self.descLabel.numberOfLines = 2;
    self.descLabel.textColor = [MY_Util setColorWithInt:0x999999];
    [self.contentView addSubview:self.descLabel];
    
    self.imageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    self.imageButton.frame = CGRectMake(MY_ScreenWidth-20-50, 22, 50, 50);
    [self.contentView addSubview:self.imageButton];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, 100-5, MY_ScreenWidth, 5)];
    line.backgroundColor = [MY_Util setColorWithInt:0xf4f4f4];
    [self.contentView addSubview:line];
}

- (void)setObject:(id)object indexPath:(NSIndexPath *)indexpath {
    
    MY_RealNameModel *model = (MY_RealNameModel*)object;
    
    self.titleLabel.text = model.title;
    self.descLabel.text = model.desc;
    
    self.descLabel.height = [self.descLabel getLabelHeightWithSpaceHeight:10 withFont:13 withStr:model.desc withTextColor:[MY_Util setColorWithInt:0x999999] withLabelWidth:180];
    
    self.indexPath = indexpath;
    
    
    if (model.image) {
        NSData *decodedImageData = [[NSData alloc] initWithBase64EncodedString:model.image options:NSDataBase64DecodingIgnoreUnknownCharacters];
        UIImage *decodedImage = [UIImage imageWithData:decodedImageData];
        [self.imageButton setImage:decodedImage forState:UIControlStateNormal];
    } else {
        [self.imageButton setImage:[UIImage imageNamed:@"add_photo"] forState:UIControlStateNormal];
    }
    
    
    
    [self.imageButton addTarget:self action:@selector(imageButtonAction) forControlEvents:UIControlEventTouchUpInside];
}

- (void)imageButtonAction {
    if ([self.delegate respondsToSelector:@selector(uploadPhotoWithIndex:)]) {
        [self.delegate uploadPhotoWithIndex:self.indexPath];
    }
}

+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object {
    return 100;
}

@end
