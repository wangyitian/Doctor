//
//  MY_AboutUSView.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/22.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_AboutUSView.h"
#define DetailText @"美域国际健康管理（北京）有限公司（以下简称“美域健康”）由哈佛医学院资深医生、学者、教授共同创建，致力于为中国客户搭建直通哈佛医学院教学附属医院的国际化、专业化海外医疗服务机构，专注为国内客户提供美国专家会诊、赴美就医、高端体检、精准医疗、医护培训等一站式海外医疗咨询服务。"
@implementation MY_AboutUSView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self setupUI];
    }
    return self;
}

- (void)setupUI {
    UIImageView *logoView = [[UIImageView alloc] init];
    logoView.image = [UIImage imageNamed:@""];
    logoView.backgroundColor = [UIColor lightGrayColor];
    logoView.layer.masksToBounds = YES;
    logoView.layer.cornerRadius = 13;
    logoView.layer.borderWidth = 1;
    logoView.layer.borderColor = [MY_Util setColorWithInt:0x666666].CGColor;
    [self addSubview:logoView];
    [logoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(@20);
        make.size.mas_equalTo(CGSizeMake(75, 75));
        make.centerX.mas_equalTo(self);
    }];
    
    UILabel *versonLabel = [[UILabel alloc] init];
    versonLabel.text = @"国际进修v1.0";
    versonLabel.textColor = [MY_Util setColorWithInt:0x666666];
    versonLabel.font = MY_Font(13);
    versonLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:versonLabel];
    [versonLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(logoView.mas_bottom).with.offset(15);
        make.size.mas_equalTo(CGSizeMake(200, 13));
        make.centerX.mas_equalTo(self);
    }];
    
    UILabel *detailLabel = [[UILabel alloc] init];
    CGSize size = [DetailText sizeWithFont:MY_Font(14) andSize:CGSizeMake(MY_ScreenWidth - 40*2, MAXFLOAT)];
    detailLabel.text = DetailText;
    detailLabel.textColor = [MY_Util setColorWithInt:0x666666];
    detailLabel.numberOfLines = 0;
    detailLabel.font = MY_Font(14);
    [self addSubview:detailLabel];
    [detailLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(MY_ScreenWidth - 40*2, size.height));
        make.top.mas_equalTo(versonLabel.mas_bottom).with.offset(23);
        make.left.mas_equalTo(@40);
    }];
    
    UIImageView *wechatImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"wechat"]];
    [self addSubview:wechatImageView];
    [wechatImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 80));
        make.left.mas_equalTo(@75);
        make.top.mas_equalTo(detailLabel.mas_bottom).with.offset(38);
    }];
    
    UILabel *wechatLabel = [[UILabel alloc] init];
    wechatLabel.text = @"官方微信";
    wechatLabel.textAlignment = NSTextAlignmentCenter;
    wechatLabel.font = MY_Font(14);
    wechatLabel.textColor = [MY_Util setColorWithInt:0x666666];
    [self addSubview:wechatLabel];
    [wechatLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(80, 15));
        make.top.mas_equalTo(wechatImageView.mas_bottom).with.offset(10);
        make.centerX.mas_equalTo(wechatImageView);
    }];
    
    UIImageView *weiboImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"weibo"]];
    [self addSubview:weiboImageView];
    [weiboImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(wechatImageView);
        make.top.mas_equalTo(wechatImageView);
        make.right.mas_equalTo(self).with.offset(-75);
    }];
    
    UILabel *weiboLabel = [[UILabel alloc] init];
    weiboLabel.text = @"官方微博";
    weiboLabel.textAlignment = NSTextAlignmentCenter;
    weiboLabel.font = MY_Font(14);
    weiboLabel.textColor = [MY_Util setColorWithInt:0x666666];
    [self addSubview:weiboLabel];
    [weiboLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(wechatLabel);
        make.size.mas_equalTo(wechatLabel);
        make.centerX.mas_equalTo(weiboImageView);
    }];
    
    [self layoutIfNeeded];
    self.height = wechatLabel.bottom + 30;
}
@end
