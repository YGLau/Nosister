//
//  YGTabBarController.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/2/14.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "YGTabBarController.h"

@interface YGTabBarController ()

@end

@implementation YGTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    attrs[NSForegroundColorAttributeName] = [UIColor grayColor];
    
    NSMutableDictionary *selectedAttr = [NSMutableDictionary dictionary];
    selectedAttr[NSFontAttributeName] = [UIFont systemFontOfSize:12];
    selectedAttr[NSForegroundColorAttributeName] = [UIColor darkGrayColor];
    
    
    
    // 添加自控制器
    UIViewController *vc01 = [[UIViewController alloc] init];
    vc01.tabBarItem.title = @"精华";
    vc01.tabBarItem.image =[UIImage imageNamed:@"tabBar_essence_icon"];
    vc01.tabBarItem.selectedImage =[UIImage imageNamed:@"tabBar_essence_click_icon"];
    [vc01.tabBarItem setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [vc01.tabBarItem setTitleTextAttributes:selectedAttr forState:UIControlStateSelected];
//    UIImage *image = [UIImage imageNamed:@"tabBar_essence_icon"];
//    image = [image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal];
//    vc01.tabBarItem.selectedImage = image;
    [self addChildViewController:vc01];
    
    UIViewController *vc02 = [[UIViewController alloc] init];
    vc02.tabBarItem.title = @"新帖";
    vc02.tabBarItem.image = [UIImage imageNamed:@"tabBar_new_icon"];
    vc02.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_new_click_icon"];
    vc02.view.backgroundColor = [UIColor grayColor];
    [vc02.tabBarItem setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [vc02.tabBarItem setTitleTextAttributes:selectedAttr forState:UIControlStateSelected];
    [self addChildViewController:vc02];
    
    UIViewController *vc03 = [[UIViewController alloc] init];
    vc03.tabBarItem.title = @"关注";
    vc03.tabBarItem.image = [UIImage imageNamed:@"tabBar_friendTrends_icon"];
    vc03.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_friendTrends_click_icon"];
    vc03.view.backgroundColor = [UIColor redColor];
    [vc03.tabBarItem setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [vc03.tabBarItem setTitleTextAttributes:selectedAttr forState:UIControlStateSelected];
    [self addChildViewController:vc03];

    UIViewController *vc04 = [[UIViewController alloc] init];
    vc04.tabBarItem.title = @"我";
    vc04.tabBarItem.image = [UIImage imageNamed:@"tabBar_me_icon"];
    vc04.tabBarItem.selectedImage = [UIImage imageNamed:@"tabBar_me_click_icon"];
    vc04.view.backgroundColor = [UIColor greenColor];
    [vc04.tabBarItem setTitleTextAttributes:attrs forState:UIControlStateNormal];
    [vc04.tabBarItem setTitleTextAttributes:selectedAttr forState:UIControlStateSelected];
    [self addChildViewController:vc04];
}



@end
