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
#import "UMSocial.h"
#import "UMSocialWechatHandler.h"
#import "UMSocialQQHandler.h"
#import "UMSocialSinaSSOHandler.h"
#import "MY_LoginController.h"
#import "MY_NavigationController.h"
//#import <UMSocialCore/UMSocialCore.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [self createUM];//创建UM分享
    
    [self chooseRootViewController];
    return YES;
}

- (void)createUM{
    //设置友盟社会化组件appkey
    [UMSocialData setAppKey:UMengKey];
    [UMSocialWechatHandler setWXAppId:WechatAppKey appSecret:WechatAppSecret url:@""];
    [UMSocialQQHandler setQQWithAppId:QQAppID appKey:QQAppKey url:@""];
    [UMSocialSinaSSOHandler openNewSinaSSOWithAppKey:WeiboAppKey secret:WeiboAppSecret RedirectURL:@"https://sns.whalecloud.com/sina2/callback"];
    [UMSocialConfig setFinishToastIsHidden:YES position:UMSocialiToastPositionBottom];
}
/**
 这里处理新浪微博SSO授权之后跳转回来，和微信分享完成之后跳转回来
 */
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return  [UMSocialSnsService handleOpenURL:url wxApiDelegate:nil];
}

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
