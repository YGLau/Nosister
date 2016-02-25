//
//  YGEssenceViewController.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/2/14.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "YGEssenceViewController.h"
#import "YGTestViewController.h"
#import "YGRecommendTagsController.h"

@interface YGEssenceViewController ()
/**
 *  红色指示器View
 */
@property (weak, nonatomic) UIView *indicatorView;
/**
 *  当前选中按钮
 */
@property (weak, nonatomic) UIButton *selectedBtn;
/**
 *  导航栏
 */
@property (weak, nonatomic) UIView *titlesView;
@end

@implementation YGEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化导航控制器
    [self setupNav];
    // 初始化导航栏
    [self setupTitlesView];
    
    // 创建底部的scrollView
    [self setupContentView];
    
}

/**
 *  导航栏
 */
- (void)setupTitlesView
{
    UIView *titlesView = [[UIView alloc] init];
    titlesView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.7];
    titlesView.width = self.view.width;
    titlesView.height = 35;
    titlesView.y = 64;
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    // 添加红色指示器View
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.height = 2;
    indicatorView.y  = titlesView.height - indicatorView.height;
    [titlesView addSubview:indicatorView];
    self.indicatorView = indicatorView;
    
    // 内部5个按钮
    NSArray *titles = @[@"全部", @"视频", @"声音", @"图片", @"段子"];
    CGFloat buttonW = titlesView.width / titles.count;
    CGFloat buttonH = titlesView.height;
    for (NSInteger i = 0; i < titles.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.width = buttonW;
        button.height = buttonH;
        button.x = i * buttonW;
        
        [button setTitle:titles[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateDisabled];
        button.titleLabel.font = [UIFont systemFontOfSize:14];
        
        // 给按钮添加点击事件
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        [titlesView addSubview:button];
        
        if (i == 0) {
            button.enabled = NO;
            self.selectedBtn = button;
            [button.titleLabel sizeToFit];
            self.indicatorView.width = button.titleLabel.width;
            self.indicatorView.centerX = button.centerX;
        }
    }
    
    
}

/**
 *  按钮点击
 */
- (void)buttonClick:(UIButton *)button
{
    self.selectedBtn.enabled = YES;
    button.enabled = NO;
    self.selectedBtn = button;
    
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
    
}
/**
 *  初始化导航栏
 */
- (void)setupNav
{
    // 设置导航栏标题
    self.navigationItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"MainTitle"]];
    
    // 设置导航栏左边的按钮
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem itemWithImage:@"MainTagSubIcon" highImage:@"MainTagSubIconClick" target:self action:@selector(tagClick)];
    self.view.backgroundColor = YGGlobalBg;
    
}
/**
 *  滚动ScrollView
 */
- (void)setupContentView
{
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    UIScrollView *contentView = [[UIScrollView alloc] init];
    
    contentView.frame = self.view.bounds;
    CGFloat bottom = self.tabBarController.tabBar.height;
    CGFloat top = CGRectGetMaxY(self.titlesView.frame);
    contentView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    [self.view insertSubview:contentView atIndex:0];
    
    [contentView addSubview:[UIButton buttonWithType:UIButtonTypeContactAdd]];
    
//    UISwitch *s = [[UISwitch alloc] init];
//    s.y = 800 - s.height;
//    [contentView addSubview:s];
////    [self.view addSubview:contentView];
    
//    contentView.contentSize = CGSizeMake(0, 800);
}

- (void)tagClick
{
    YGRecommendTagsController *RT = [[YGRecommendTagsController alloc] init];
    [self.navigationController pushViewController:RT animated: YES];
}


@end
