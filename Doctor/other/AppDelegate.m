//
//  AppDelegate.m
//  Doctor
//
//  Created by 王翼天 on 2017/2/9.
//  Copyright © 2017年 王翼天. All rights reserved.
//

#import "AppDelegate.h"
#import "MY_TabController.h"
#import "MY_GuideController.h"
#import "MY_LoginController.h"
#import "MY_NavigationController.h"
#import <UMSocialCore/UMSocialCore.h>
@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    //友盟分享相关
    [[UMSocialManager defaultManager] openLog:YES];
    [[UMSocialManager defaultManager] setUmSocialAppkey:UMengKey];
    [self configUSharePlatforms];
    
    //rootController
    [self chooseRootViewController];
    return YES;
}

#pragma mark - 友盟配置
- (void)configUSharePlatforms {
    /* 设置微信的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_WechatSession appKey:WechatAppKey appSecret:WechatAppSecret redirectURL:@"http://mobile.umeng.com/social"];
    [[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_WechatFavorite)]];

    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_QQ appKey:QQAppID/*设置QQ平台的appID*/  appSecret:nil redirectURL:@"http://mobile.umeng.com/social"];
    [[UMSocialManager defaultManager] removePlatformProviderWithPlatformTypes:@[@(UMSocialPlatformType_Qzone)]];
    /* 设置新浪的appKey和appSecret */
    [[UMSocialManager defaultManager] setPlaform:UMSocialPlatformType_Sina appKey:WeiboAppKey  appSecret:WeiboAppSecret redirectURL:@"https://sns.whalecloud.com/sina2/callback"];
}

#pragma mark - 分享回调app
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    //6.3的新的API调用，是为了兼容国外平台(例如:新版facebookSDK,VK等)的调用[如果用6.2的api调用会没有回调],对国内平台没有影响
    BOOL result = [[UMSocialManager defaultManager] handleOpenURL:url sourceApplication:sourceApplication annotation:annotation];
    if (!result) {
        // 其他如支付等SDK的回调
    }
    return result;
}

#pragma mark - 选择rootController
- (void)chooseRootViewController {
    // 如何知道第一次使用这个版本？比较上次的使用情况
    NSString *versionKey = @"CFBundleShortVersionString";
    // 从沙盒中取出上次存储的软件版本号(取出用户上次的使用记录)
    NSString *lastVersion = [[NSUserDefaults standardUserDefaults] objectForKey:versionKey];
    // 获得当前打开软件的版本号
    NSString *currentVersion = [NSBundle mainBundle].infoDictionary[versionKey];
    UIWindow *window = [UIApplication sharedApplication].keyWindow;
    if ([currentVersion isEqualToString:lastVersion]) {
        // 当前版本号 == 上次使用的版本：显示HMTabBarViewController
        [UIApplication sharedApplication].statusBarHidden = NO;
        if ([MY_Util isLogin]) {
            window.rootViewController = [[MY_TabController alloc] init];
        } else {
            window.rootViewController = [[MY_NavigationController alloc] initWithRootViewController:[[MY_LoginController alloc] init]];
        }
    } else { // 当前版本号 != 上次使用的版本：显示版本新特性
        window.rootViewController = [[MY_GuideController alloc] init];
    }
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end
