//
//  AppDelegate.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/2/11.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "AppDelegate.h"
#import "YGTabBarController.h"
#import "YGPushGuideView.h"
#import "YGTopWindow.h"

@interface AppDelegate () <UITabBarControllerDelegate>

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // 创建窗口
    self.window = [[UIWindow alloc] init];
    self.window.frame = [UIScreen mainScreen].bounds;
    // 设置窗口的跟控制器
    YGTabBarController *tabBarVc =  [[YGTabBarController alloc] init];
    tabBarVc.delegate = self;
    self.window.rootViewController = tabBarVc;
    // 显示窗口
    [self.window makeKeyAndVisible];
    // 显示推送指南
    [YGPushGuideView show];
    
   
    
    return YES;
}

#pragma mark - UITabBarDelegate代理方法
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    // 发不出一个通知
    [[NSNotificationCenter defaultCenter] postNotificationName:YGTarBarDidSelectedNotification object:nil userInfo:nil];
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    // 显示Window
//    [YGTopWindow show];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
