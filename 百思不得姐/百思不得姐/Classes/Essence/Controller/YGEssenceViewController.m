//
//  YGEssenceViewController.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/2/14.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "YGEssenceViewController.h"
#import "YGRecommendTagsController.h"
#import "YGBaseViewController.h"

@interface YGEssenceViewController () <UIScrollViewDelegate>
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
/**
 *  ScrollView
 */
@property (weak, nonatomic) UIScrollView *contentView;
@end

@implementation YGEssenceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // 初始化导航控制器
    [self setupNav];
    
    // 创建自控制器
    [self setupChildVces];
    
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
    titlesView.height = YGTitleViewH;
    titlesView.y = YGTitleViewY;
    [self.view addSubview:titlesView];
    self.titlesView = titlesView;
    
    // 添加红色指示器View
    UIView *indicatorView = [[UIView alloc] init];
    indicatorView.backgroundColor = [UIColor redColor];
    indicatorView.tag = -1;
    indicatorView.height = 2;
    indicatorView.y  = titlesView.height - indicatorView.height;
    self.indicatorView = indicatorView;
    
    // 内部5个按钮
    CGFloat buttonW = titlesView.width / self.childViewControllers.count;
    CGFloat buttonH = titlesView.height;
    for (NSInteger i = 0; i < self.childViewControllers.count; i++) {
        UIButton *button = [[UIButton alloc] init];
        button.tag = i;
        button.width = buttonW;
        button.height = buttonH;
        button.x = i * buttonW;
        UIViewController *vc = self.childViewControllers[i];
        [button setTitle:vc.title forState:UIControlStateNormal];
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
    
    // 放到最后添加，保证按钮是先被添加进去的
    [titlesView addSubview:indicatorView];
    
    
}

/**
 *  按钮点击
 */
- (void)buttonClick:(UIButton *)button
{
    // 修改按钮状态
    self.selectedBtn.enabled = YES;
    button.enabled = NO;
    self.selectedBtn = button;
    
    // 动画
    [UIView animateWithDuration:0.25 animations:^{
        self.indicatorView.width = button.titleLabel.width;
        self.indicatorView.centerX = button.centerX;
    }];
    
    // 滚动
    CGPoint offset = self.contentView.contentOffset;
    offset.x = button.tag * self.contentView.width;
    [self.contentView setContentOffset:offset animated:YES];
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
    [self.view insertSubview:contentView atIndex:0];
    contentView.contentSize = CGSizeMake(contentView.width * self.childViewControllers.count, 0);
    // 分页
    contentView.pagingEnabled = YES;
    self.contentView = contentView;
    contentView.delegate = self;
    
    // 创建第一个控制器view
    [self scrollViewDidEndScrollingAnimation:contentView];
}
/**
 *  创建子控制器
 */
- (void)setupChildVces
{
    
    YGBaseViewController *voice = [[YGBaseViewController alloc] init];
    voice.type = YGBaseTopicTypeVoice;
    voice.title = @"声音";
    [self addChildViewController:voice];
    
    YGBaseViewController *all = [[YGBaseViewController alloc] init];
    all.type = YGBaseTopicTypeAll;
    all.title = @"全部";
    [self addChildViewController:all];
    
    YGBaseViewController *video = [[YGBaseViewController alloc] init];
    video.type = YGBaseTopicTypeVideo;
    video.title = @"视频";
    [self addChildViewController:video];
    
    
    YGBaseViewController *picture = [[YGBaseViewController alloc] init];
    picture.type = YGBaseTopicTypePicture;
    picture.title = @"图片";
    [self addChildViewController:picture];
    
    YGBaseViewController *word = [[YGBaseViewController alloc] init];
    word.type = YGBaseTopicTypeWord;
    word.title = @"段子";
    [self addChildViewController:word];
}

- (void)tagClick
{
    YGRecommendTagsController *RT = [[YGRecommendTagsController alloc] init];
    [self.navigationController pushViewController:RT animated: YES];
}

#pragma mark - tableView一些代理方法
- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    // 添加子控制器的view
    
    // 当前的索引
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    UIViewController *vc = self.childViewControllers[index];
    vc.view.x = scrollView.contentOffset.x;
    vc.view.y = 0;
    vc.view.height = scrollView.height;
    
    
    [scrollView addSubview:vc.view];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self scrollViewDidEndScrollingAnimation:scrollView];
    
    // 点击按钮
    NSInteger index = scrollView.contentOffset.x / scrollView.width;
    [self buttonClick:self.titlesView.subviews[index]];
}
@end
