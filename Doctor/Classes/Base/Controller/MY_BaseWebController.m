//
//  MY_BaseWebController.m
//  Doctor
//
//  Created by 王翼天 on 2017/3/7.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "MY_BaseWebController.h"
#import <UShareUI/UShareUI.h>
@interface MY_BaseWebController ()
@property (nonatomic, strong) UIActivityIndicatorView* activityView;

@end

@implementation MY_BaseWebController

#pragma mark - 生命周期
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}

#pragma mark - UI
- (void)setupUI {
    [self setTitle:@" " isBackButton:YES rightBttonName:@"分享" rightImageName:nil];
    
    self.webView = [[UIWebView alloc] initWithFrame:CGRectMake(0, MY_APP_STATUS_NAVBAR_HEIGHT, MY_ScreenWidth, MY_ScreenHeight - MY_APP_STATUS_NAVBAR_HEIGHT)];
    self.webView.delegate = self;
    self.webView.scalesPageToFit = YES;
    self.webView.mediaPlaybackAllowsAirPlay = NO;
    self.webView.mediaPlaybackRequiresUserAction = NO;
    [self.view addSubview:self.webView];
    
    NSMutableURLRequest *request  = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:self.url]];
    [self.webView loadRequest:request];
}

#pragma mark - UIWebViewDelegate 方法
- (void)webViewDidStartLoad:(UIWebView *)webView {
    self.activityView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake((MY_ScreenWidth - 30)/2, (MY_ScreenHeight - MY_APP_STATUS_NAVBAR_HEIGHT- 30)/2, 30, 30)];
    self.activityView.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    [self.activityView startAnimating];
    [self.view addSubview:self.activityView];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    [self.activityView stopAnimating];
    [self.activityView removeFromSuperview];
    self.navLabel.text = [webView stringByEvaluatingJavaScriptFromString:@"document.title"];
}
- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error {
    [self.activityView stopAnimating];
    [self.activityView removeFromSuperview];
}

#pragma mark - 返回按钮方法
- (void)back {
    if (self.webView.canGoBack) {
        [self.webView goBack];
    } else {
        [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:@"about:blank"]]];
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark - 分享
- (void)rightButtonAction {
    //分享
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        // 根据获取的platformType确定所选平台进行下一步操作
        [self shareWebPageToPlatformType:platformType];
    }];
}

- (void)shareWebPageToPlatformType:(UMSocialPlatformType)platformType {
    //创建分享消息对象
    UMSocialMessageObject *messageObject = [UMSocialMessageObject messageObject];
    
    //创建网页内容对象
    UIImage *thumbURL = [UIImage imageNamed:@"icon"];
    UMShareWebpageObject *shareObject = [UMShareWebpageObject shareObjectWithTitle:@"测试" descr:@"～～～～～～～～～～～～～～～" thumImage:thumbURL];
    //设置网页地址
    shareObject.webpageUrl = @"https://itunes.apple.com/cn/app/sago-mini-故事城/id1192489542?mt=8";
    
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

@end
