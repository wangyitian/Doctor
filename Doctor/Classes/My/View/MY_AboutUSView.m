//
//  MY_AboutUSView.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/22.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_AboutUSView.h"
#define DetailText @"美域国际健康管理（北京）有限公司（以下简称“美域健康”）由哈佛医学院资深医生、学者、教授共同创建，致力于为中国客户搭建直通哈佛医学院教学附属医院的国际化、专业化海外医疗服务机构，专注为国内客户提供美国专家会诊、赴美就医、高端体检、精准医疗、医护培训等一站式海外医疗咨询服务。"

#define VersionText @"美域医疗v1.0"
@implementation MY_AboutUSView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UIImageView *logoView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 20, 75, 75)];
    logoView.centerX = self.centerX;
    logoView.image = [UIImage imageNamed:@"icon"];
    logoView.layer.masksToBounds = YES;
    [self addSubview:logoView];
    
    UILabel *versonLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, logoView.bottom+15, 200, 13)];
    versonLabel.centerX = logoView.centerX;
    versonLabel.text = VersionText;
    versonLabel.textColor = [MY_Util setColorWithInt:0x666666];
    versonLabel.font = MY_Font(13);
    versonLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:versonLabel];

    UILabel *detailLabel = [[UILabel alloc] initWithFrame:CGRectMake(40, versonLabel.bottom+23, MY_ScreenWidth-40*2, 0)];
    CGSize size = [DetailText sizeWithFont:MY_Font(14) andSize:CGSizeMake(MY_ScreenWidth - 40*2, MAXFLOAT)];
    detailLabel.text = DetailText;
    detailLabel.textColor = [MY_Util setColorWithInt:0x666666];
    detailLabel.numberOfLines = 0;
    detailLabel.font = MY_Font(14);
    detailLabel.height = size.height;
    [self addSubview:detailLabel];
    
    UIImageView *wechatImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wechat"]];
    wechatImageView.frame = CGRectMake(75, detailLabel.bottom+38, 80, 80);
    [self addSubview:wechatImageView];
    
    UILabel *wechatLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, wechatImageView.bottom+10, 80, 15)];
    wechatLabel.centerX = wechatImageView.centerX;
    wechatLabel.text = @"官方微信";
    wechatLabel.textAlignment = NSTextAlignmentCenter;
    wechatLabel.font = MY_Font(14);
    wechatLabel.textColor = [MY_Util setColorWithInt:0x666666];
    [self addSubview:wechatLabel];
    
    UIImageView *weiboImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"weibo"]];
    weiboImageView.frame = CGRectMake(MY_ScreenWidth-75-wechatImageView.width, wechatImageView.top, wechatImageView.width, wechatImageView.height);
    [self addSubview:weiboImageView];
    
    UILabel *weiboLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, wechatLabel.top, wechatLabel.width, wechatLabel.height)];
    weiboLabel.centerX = weiboImageView.centerX;
    weiboLabel.text = @"官方微博";
    weiboLabel.textAlignment = NSTextAlignmentCenter;
    weiboLabel.font = MY_Font(14);
    weiboLabel.textColor = [MY_Util setColorWithInt:0x666666];
    [self addSubview:weiboLabel];

    self.height = wechatLabel.bottom + 30;
}
@end
