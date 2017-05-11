//
//  MY_HomePageHeaderView.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/27.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_HomePageHeaderView.h"
#import "SDCycleScrollView.h"
#import "MY_BaseWebController.h"
#define TAG_FOR_BUTTON  2000
#define TAG_FOR_SECTION 3000
@interface MY_HomePageHeaderView () <SDCycleScrollViewDelegate>
@property (nonatomic, strong) SDCycleScrollView *imageScrollView;
@property (nonatomic, strong) NSMutableArray *bannerUrlArray;
@property (nonatomic, strong) UIView *buttonView;
@property (nonatomic, strong) NSMutableArray *sectionButtons;
@property (nonatomic, strong) UIView *selectedLineView;
@end
@implementation MY_HomePageHeaderView
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.sectionButtons = [NSMutableArray array];
        self.backgroundColor = [UIColor whiteColor];
        self.bannerUrlArray = [NSMutableArray array];
        [self setupUI];
    }
    return self;
}

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index {
    NSString *url = self.bannerUrlArray[index];
    if (url.length) {
        MY_BaseWebController *webVC = [[MY_BaseWebController alloc] init];
        webVC.url = url;
        [[self findController].navigationController pushViewController:webVC animated:YES];
    }
}

- (void)setupUI {
    self.imageScrollView = [[SDCycleScrollView alloc] initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, 140*MY_ScreenWidth/375)];
    self.imageScrollView.delegate = self;
    [self addSubview:self.imageScrollView];
    
    self.buttonView = [[UIView alloc] initWithFrame:CGRectMake(0, self.imageScrollView.bottom, MY_ScreenWidth, 100)];
    self.buttonView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.buttonView];
    
    NSArray *buttonTitles = [NSArray arrayWithObjects:@"管理培训",@"临床培训",@"专题培训",@"科研培训", nil];
    NSArray *buttonImages = [NSArray arrayWithObjects:@"homePage_button1",@"homePage_button4",@"homePage_button2",@"homePage_button3", nil];
    CGFloat buttonW = 44;
    CGFloat buttonH = 44;
    CGFloat buttonY = 20;
    CGFloat space = (MY_ScreenWidth-buttonW*buttonTitles.count-30*2)/(buttonTitles.count-1);
    for (int i = 0; i < buttonTitles.count; i++) {
        CGFloat buttonX = 30 + (buttonW+space)*i;
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setImage:[UIImage imageNamed:buttonImages[i]] forState:UIControlStateNormal];
        button.frame = CGRectMake(buttonX, buttonY, buttonW, buttonH);
        button.tag = TAG_FOR_BUTTON + i;
        [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self.buttonView addSubview:button];
        
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, button.bottom+10, 60, 12)];
        titleLabel.centerX = button.centerX;
        titleLabel.textColor = [MY_Util setColorWithInt:0x666666];
        titleLabel.font = MY_Font(12);
        titleLabel.text = buttonTitles[i];
        titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.buttonView addSubview:titleLabel];
    }
    
    UIView *spaceView = [[UIView alloc] initWithFrame:CGRectMake(0, self.buttonView.bottom, MY_ScreenWidth, 5)];
    spaceView.backgroundColor = [MY_Util setColorWithInt:0xf4f4f4];
    [self addSubview:spaceView];
    
    NSArray *sections = [NSArray arrayWithObjects:@"最新课程",@"培训实录",@"学习心得", nil];
    for (int i = 0; i < sections.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(100*i, spaceView.bottom, 100, 43);
        button.titleLabel.font = MY_Font(15);
        [button setTitle:sections[i] forState:UIControlStateNormal];
        [button setTitleColor:[MY_Util setColorWithInt:0x666666] forState:UIControlStateNormal];
        [button setTitleColor:[MY_Util setColorWithInt:0x68d6a7] forState:UIControlStateSelected];
        button.tag = TAG_FOR_SECTION + i;
        [button addTarget:sections action:@selector(sectionButtonAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        [self.sectionButtons addObject:button];
        
        if (i == 0) {
            [self sectionButtonAction:button];
        }
        if (i == sections.count - 1) {
            button.hidden = (((MY_AccountModel*)[MY_Util getAccountModel]).type.integerValue != 1);
        }
    }
    
    self.height = spaceView.bottom + 44;
}

- (void)loadButtonStatus {
    if (((MY_AccountModel*)[MY_Util getAccountModel]).type.integerValue == 1) {
        for (UIButton *btn in self.sectionButtons) {
            btn.hidden = NO;
        }
    }
}

- (void)setImageArray:(NSArray *)imageArray {
    _imageArray = imageArray;
    NSMutableArray *images = [NSMutableArray array];
    NSMutableArray *urls = [NSMutableArray array];
    if ([imageArray isKindOfClass:[NSArray class]]) {
        for (NSDictionary *dic in imageArray) {
            [images addObject:dic[@"adurl"]];
            [urls addObject:[dic stringWithKey:@"url"]];
        }
    }
    self.bannerUrlArray = urls;
    self.imageScrollView.imageURLStringsGroup = images;
}

- (void)sectionButtonAction:(UIButton*)button {
    if (button.selected) {
        return;
    }
    if (!self.selectedLineView) {
        self.selectedLineView = [[UIView alloc] initWithFrame:CGRectMake(0, button.bottom, 100, 1)];
        self.selectedLineView.backgroundColor = [MY_Util setColorWithInt:0x68d6a7];
        [self addSubview:self.selectedLineView];
    }
    
    for (UIButton *btn in self.sectionButtons) {
        btn.selected = NO;
    }
    button.selected = YES;
    self.selectedLineView.left = button.left;
    
    if (self.sectionBlock) {
        self.sectionBlock(button.tag - TAG_FOR_SECTION);
    }
}

- (void)buttonAction:(UIButton*)button {
    if (self.buttonBlock) {
        self.buttonBlock(button.tag-TAG_FOR_BUTTON+1);
    }
}

@end
