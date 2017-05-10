//
//  MY_MyController.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/17.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_MyController.h"
#import "MY_MyHeaderView.h"
#import "MY_MyCell.h"
#import "MY_PersonalDataController.h"
#import "MY_SettingController.h"
#import "MY_FeedbackController.h"
#import "MY_AboutUSController.h"
#import "MY_ServiceScheduleController.h"
#import "MY_PatientListController.h"
#import "MY_RealNameController.h"
#import <UShareUI/UShareUI.h>
@interface MY_MyController ()

@end

@implementation MY_MyController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupUI];
    
    [self initData];
    
    [self addHeaderRefresh:YES footerRefresh:NO];
    
    [self loadData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self refreshUI];
}

#pragma mark - tableview样式
- (UITableViewStyle)getTableViewStyle {
    return UITableViewStyleGrouped;
}

#pragma mark - 状态栏样式
- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleDefault;
}

#pragma mark - 网络请求
- (void)loadData {
    MY_RequestModel *model = [[MY_RequestModel alloc] initWithDelegate:self];
    NSMutableDictionary *paramter = [NSMutableDictionary dictionary];
    [paramter setObject:[MY_Util getUid] forKey:@"uid"];
    [model getDataWithURL:MY_API_REFRESH paramter:paramter success:^(NSURLSessionDataTask *operation, NSDictionary *dic) {
        MY_AccountModel *account = [[MY_AccountModel alloc] initWithDictionary:dic];
        [MY_Util saveAccount:account];
        ((MY_MyHeaderView*)self.tableView.tableHeaderView).object = account;
    }];
}

- (void)refreshUI {
    MY_AccountModel *account = [MY_Util getAccountModel];
    ((MY_MyHeaderView*)self.tableView.tableHeaderView).object = account;
    [self hideLoadingAndMJ];
}

#pragma mark - 刷新
- (void)headerRereshing {
    [self loadData];
}

#pragma mark - UI
- (void)setupUI {
    self.tableView.backgroundColor = [UIColor whiteColor];
    MY_MyHeaderView *tableHeaderView = [[MY_MyHeaderView alloc] initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, 0)];
    tableHeaderView.realNameBlock = ^(){
        MY_RealNameController *realNameVC = [[MY_RealNameController alloc] init];
        [self.navigationController pushViewController:realNameVC animated:YES];
    };
    tableHeaderView.personalDataBlock = ^(){
        MY_PersonalDataController *personalVC = [[MY_PersonalDataController alloc] init];
        [self.navigationController pushViewController:personalVC animated:YES];
    };
    MY_AccountModel *accountModel = [MY_Util getAccountModel];
    tableHeaderView.object = accountModel;
    self.tableView.tableHeaderView = tableHeaderView;
}

#pragma mark - 数据
- (void)initData {
    NSArray *dataArray = [NSArray arrayWithObjects:@"服务进度",@"患者推荐",@"意见反馈",@"关于我们",@"设置",@"邀请", nil];
    [self.dataSource addObject:dataArray];
    [self.tableView reloadData];
}

#pragma mark - tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 5;
    
}

- (UIView*)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MY_ScreenWidth, 5)];
    header.backgroundColor = [MY_Util setColorWithInt:0xf4f4f4];
    return header;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    MY_MyCell *cell = [MY_MyCell cellWithTablebView:tableView index:indexPath];
    tableView.separatorStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        MY_ServiceScheduleController *scheduleVC = [[MY_ServiceScheduleController alloc] init];
        [self.navigationController pushViewController:scheduleVC animated:YES];
    } else if (indexPath.row == 1) {
        MY_PatientListController *patientListVC = [[MY_PatientListController alloc] init];
        [self.navigationController pushViewController:patientListVC animated:YES];
    } else if (indexPath.row == 2) {
        MY_FeedbackController *feedbackVC = [[MY_FeedbackController alloc] init];
        [self.navigationController pushViewController:feedbackVC animated:YES];
    } else if (indexPath.row == 3) {
        MY_AboutUSController *aboutVC = [[MY_AboutUSController alloc] init];
        [self.navigationController pushViewController:aboutVC animated:YES];
    } else if (indexPath.row == 4) {
        MY_SettingController *settingVC = [[MY_SettingController alloc] init];
        [self.navigationController pushViewController:settingVC animated:YES];
    } else if (indexPath.row == 5) {
        [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
            // 根据获取的platformType确定所选平台进行下一步操作
            [self shareWebPageToPlatformType:platformType];
        }];
    }
}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType {
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UIImage *thumbURL = [UIImage imageNamed:@"icon"];
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"美域医疗" descr:@"～～～～～～～～～～～～～～～" thumImage:thumbURL];
    //设置网页地址
    shareObject.webpageUrl = @"https://itunes.apple.com/cn/app/id1208855490";
    
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
    }];
}

- (Class)cellClassForObject:(id)object indexPath:(NSIndexPath *)indexPath {
    return [MY_MyCell class];
}

@end
