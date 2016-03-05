//
//  YGTabBarController.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/2/14.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "YGTabBarController.h"
#import "YGEssenceViewController.h"
#import "YGNewViewController.h"
#import "YGFriendTrendsViewController.h"
#import "YGMeViewController.h"
#import "YGTabBar.h"
#import "YGNavigationViewController.h"

@interface YGTabBarController ()

@end

@implementation YGTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [UINavigationBar appearance];
    // 通过appearance统一设置所有UITabBarItem的文字属性
    // 后面带有UI_APPEARANCE_SELECTOR的方法, 都可以通过appearance对象来统一设置
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttr = [NSMutableDictionary dictionary];
    selectedAttr[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selectedAttr[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    UITabBarItem *item = [UITabBarItem appearance];
    [item setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [item setTitleTextAttributes:selectedAttr forState:UIControlStateSelected];
    
    // 添加自控制器
    [self setupChildVc:[[YGEssenceViewController alloc] init] title:@"精华" image:@"tabBar_essence_icon" selectedImage:@"tabBar_essence_click_icon"];
    [self setupChildVc:[[YGNewViewController alloc] init] title:@"新帖" image:@"tabBar_new_icon" selectedImage:@"tabBar_new_click_icon"];
    [self setupChildVc:[[YGFriendTrendsViewController alloc] init] title:@"关注" image:@"tabBar_friendTrends_icon" selectedImage:@"tabBar_friendTrends_click_icon"];
    // 改成分组样式
    [self setupChildVc:[[YGMeViewController alloc] initWithStyle:UITableViewStyleGrouped] title:@"我" image:@"tabBar_me_icon" selectedImage:@"tabBar_me_click_icon"];
    
    [self setValue:[[YGTabBar alloc] init] forKey:@"tabBar"];
    

}

/**
 *  初始化自控制器
 */
- (void)setupChildVc:(UIViewController *)vc title:(NSString *)title image:(NSString *)image selectedImage:(NSString *)selectedImage
{
    // 设置图片和文字
    vc.tabBarItem.title = title;
    vc.tabBarItem.image = [UIImage imageNamed:image];
    vc.tabBarItem.selectedImage = [UIImage imageNamed:selectedImage];
    // 包装一个导航控制器，添加导航控制器为tabBarController的子控制器
    YGNavigationViewController *nav = [[YGNavigationViewController alloc] initWithRootViewController:vc];
    // 添加为子控制器
    [self addChildViewController:nav];
}


@end
