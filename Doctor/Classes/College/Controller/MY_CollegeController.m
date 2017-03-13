//
//  MY_CollegeController.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/17.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_CollegeController.h"
#import "MY_CollegeHeaderView.h"
#import "MY_CourseIntroCell.h"
#import "MY_EnrollController.h"
#import "MY_SegmentController.h"
#import "MY_CourseListController.h"
#import "MY_CourseSegmentController.h"
#import "MY_CourseCustomedController.h"
//#import "UMSocialData.h"
//#import "UMSocialSnsService.h"
//#import "UMSocialSnsPlatformManager.h"
//<UMSocialUIDelegate>

#import <UShareUI/UShareUI.h>
@interface MY_CollegeController ()

@end

@implementation MY_CollegeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
    [self falseData];
}

- (void)falseData {
    NSArray *array = [NSArray arrayWithObjects:@"", nil];
    for (int i = 0; i < 5; i++) {
        [self.dataSource addObject:array];
    }
    [self.tableView reloadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

- (UITableViewStyle)getTableViewStyle {
    return UITableViewStyleGrouped;
}

- (void)setupUI {
    UIView *statusView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, MY_STATUS_HEIGHT)];
    statusView.backgroundColor = [MY_Util setColorWithInt:0x68d6a7];
    [self.view addSubview:statusView];
    self.tableView.contentInset = UIEdgeInsetsMake(MY_STATUS_HEIGHT, 0, 50, 0);
    
    MY_CollegeHeaderView *tableHeaderView = [[MY_CollegeHeaderView alloc] initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, 90)];
    tableHeaderView.headerButtonBlock = ^(NSInteger index) {
       NSMutableArray *vcArray = [NSMutableArray array];
        if (index == 4) {
            MY_CourseCustomedController *vc = [[MY_CourseCustomedController alloc] init];
            [self.navigationController pushViewController:vc animated:YES];
        } else {
            NSArray *types = nil;
            if (index == 1) {
                types = [NSArray arrayWithObjects:@"全部",@"临床研修",@"医技培训",@"专科特训", nil];
            } else if (index == 2) {
                types = [NSArray arrayWithObjects:@"全部",@"美国",@"台湾",@"新加坡", nil];
            } else if (index == 3) {
                types = [NSArray arrayWithObjects:@"实验室访学", nil];
            }
            for (NSString *type in types) {
                MY_CourseListController *rdVC = [[MY_CourseListController alloc] init];
                rdVC.listType = type;
                [vcArray addObject:rdVC];
            }
            MY_CourseSegmentController *vc = [[MY_CourseSegmentController alloc] initWithViewControllers:vcArray segmentViewHeight:45 + MY_APP_STATUS_NAVBAR_HEIGHT];
            vc.typeIndex = index;
            vc.types = types;
            [self.navigationController pushViewController:vc animated:YES];
        }
    };
    self.tableView.tableHeaderView = tableHeaderView;
    self.tableView.height -= 50;
    
    UIButton *phoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    phoneButton.backgroundColor = [UIColor whiteColor];
    [phoneButton setTitle:@"电话咨询" forState:UIControlStateNormal];
    [phoneButton setTitleColor:[MY_Util setColorWithInt:0x68d6a7] forState:UIControlStateNormal];
    phoneButton.titleLabel.font = MY_Font(15);
    phoneButton.frame = CGRectMake(0, self.view.height-49-50, MY_ScreenWidth/2, 50);
    [phoneButton addTarget:self action:@selector(phoneButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:phoneButton];
    
    UIButton *enrollButton = [UIButton buttonWithType:UIButtonTypeCustom];
    enrollButton.backgroundColor = [MY_Util setColorWithInt:0x68d6a7];
    [enrollButton setTitle:@"立即报名" forState:UIControlStateNormal];
    [enrollButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    enrollButton.titleLabel.font = MY_Font(15);
    enrollButton.frame = CGRectMake(MY_ScreenWidth/2, self.view.height-49-50, MY_ScreenWidth/2, 50);
    [enrollButton addTarget:self action:@selector(enrollButtonAction) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:enrollButton];
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.height-49-50, MY_ScreenWidth, 0.5)];
    line.backgroundColor = [MY_Util setColorWithInt:0xdddddd];
    [self.view addSubview:line];
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, 10)];
    header.backgroundColor = [MY_Util setColorWithInt:0xf4f4f4];
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section { return 0.1; }
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section { return 10; }

- (Class)cellClassForObject:(id)object indexPath:(NSIndexPath *)indexPath {
    return [MY_CourseIntroCell class];
}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType {
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UIImage *thumbURL = [UIImage imageNamed:@"icon"];
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"测试" descr:@"～～～～～～～～～～～～～～～" thumImage:thumbURL];
    //设置网页地址
    shareObject.webpageUrl = @"http://news.sina.com.cn/s/wh/2017-03-13/doc-ifychhuq4168858.shtml";
    
    //分享消息对象设置分享内容对象
    messageObject.shareObject = shareObject;
    
    //调用分享接口
    [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:messageObject currentViewController:self completion:^(id data, NSError *error) {
        if (error) {
            UMSocialLogInfo(@"************Share fail with error %@*********",error);
        }else{
            if ([data isKindOfClass:[UMSocialShareResponse class]]) {
                UMSocialShareResponse *resp = data;
                //分享结果消息
                UMSocialLogInfo(@"response message is %@",resp.message);
                //第三方原始返回的数据
                UMSocialLogInfo(@"response originalResponse data is %@",resp.originalResponse);
                
            }else{
                UMSocialLogInfo(@"response data is %@",data);
            }
        }
//        [self alertWithError:error];
    }];
}

- (void)phoneButtonAction {
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        [self shareWebPageToPlatformType:platformType];
    }];
    
    
    
    
//    [UMSocialData defaultData].extConfig.wechatTimelineData.title = @"测试";
//    [UMSocialData defaultData].extConfig.wechatTimelineData.url = @"http://k.sina.cn/article_1750935105_685d26410190023we.html?cre=sinaw&mod=b&loc=2&r=0&doct=9&rfunc=75&tj=hrt&s=0&from=news&subch=zx&vt=4&pos=108";
//    
//    [UMSocialData defaultData].extConfig.wechatSessionData.title = @"测试";
//    [UMSocialData defaultData].extConfig.wechatSessionData.url = @"http://k.sina.cn/article_1750935105_685d26410190023we.html?cre=sinaw&mod=b&loc=2&r=0&doct=9&rfunc=75&tj=hrt&s=0&from=news&subch=zx&vt=4&pos=108";
//    
//    [UMSocialData defaultData].extConfig.qqData.title = @"测试";
//    [UMSocialData defaultData].extConfig.qqData.url = @"http://k.sina.cn/article_1750935105_685d26410190023we.html?cre=sinaw&mod=b&loc=2&r=0&doct=9&rfunc=75&tj=hrt&s=0&from=news&subch=zx&vt=4&pos=108";
//    
//    UMSocialUrlResource *resource = [[UMSocialUrlResource alloc] initWithSnsResourceType:UMSocialUrlResourceTypeDefault url:@"http://k.sina.cn/article_1750935105_685d26410190023we.html?cre=sinaw&mod=b&loc=2&r=0&doct=9&rfunc=75&tj=hrt&s=0&from=news&subch=zx&vt=4&pos=108"];
//    [UMSocialData defaultData].extConfig.sinaData.urlResource = resource;
//    
//    
//    [UMSocialSnsService presentSnsIconSheetView:self
//                                         appKey:UMengKey
//                                      shareText:@"测试一下，我好帅啊，帅超和帅永也挺帅"
//                                     shareImage:[UIImage imageNamed:@"icon"]
//                                shareToSnsNames:[NSArray arrayWithObjects:UMShareToWechatTimeline,UMShareToWechatSession,UMShareToQQ,UMShareToSina,nil]
//                                       delegate:self];
}


- (void)enrollButtonAction {
    MY_EnrollController *enrollVC = [[MY_EnrollController alloc] init];
    [self.navigationController pushViewController:enrollVC animated:YES];
}

@end
