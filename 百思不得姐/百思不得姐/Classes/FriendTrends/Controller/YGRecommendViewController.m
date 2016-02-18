//
//  YGRecommendViewController.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/2/17.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "YGRecommendViewController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import "YGRecommendViewCell.h"
#import "YGRecommendCategroy.h"
#import <MJExtension.h>
#import "YGUserTableViewCell.h"
#import "YGRecommendUser.h"
#import <MJRefresh.h>

#define YGSelectedCategory self.category[self.leftTableView.indexPathForSelectedRow.row]

@interface YGRecommendViewController () <UITableViewDelegate, UITableViewDataSource>
/**
 *  左边的类别数据
 */
@property (strong, nonatomic) NSArray *category;

/**
 *  左边的tableView控件
 */
@property (weak, nonatomic) IBOutlet UITableView *leftTableView;
/**
 *  右侧的tableView控件
 */
@property (weak, nonatomic) IBOutlet UITableView *rightTableView;

@end

@implementation YGRecommendViewController

static NSString * const YGCategoryID = @"category";
static NSString * const YGUserID = @"user";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self setupRefresh];
    
    // 注册左边cell
    [self.leftTableView registerNib:[UINib nibWithNibName:NSStringFromClass([YGRecommendViewCell class]) bundle:nil] forCellReuseIdentifier:YGCategoryID];
    // 注册右边cell
    [self.rightTableView registerNib:[UINib nibWithNibName:NSStringFromClass([YGUserTableViewCell class]) bundle:nil] forCellReuseIdentifier:YGUserID];
    
    // 设置inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.leftTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.rightTableView.contentInset = self.leftTableView.contentInset;
    self.rightTableView.rowHeight = 70;
    
    self.title = @"推荐关注";
    
    // 设置背景色
    [self.view setBackgroundColor:YGGlobalBg];
    
    // 显示指示器
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    // 发送左边网络请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"category";
    params[@"c"] = @"subscribe";
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        // 隐藏指示器
        [SVProgressHUD dismiss];

        
        // 服务器返回的JSON数据
        self.category = [YGRecommendCategroy mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        
        
        // 刷新表格
        [self.leftTableView reloadData];
        
        // 默认选中首行
        [self.leftTableView selectRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] animated:NO scrollPosition:UITableViewScrollPositionTop];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        // 显示失败信息
        [SVProgressHUD showErrorWithStatus:@"加载推荐信息失败！"];
    }];
}

/**
 *  初始化tableView的一些信息
 */
-(void)setupTableView
{
    // 注册左边cell
    [self.leftTableView registerNib:[UINib nibWithNibName:NSStringFromClass([YGRecommendViewCell class]) bundle:nil] forCellReuseIdentifier:YGCategoryID];
    // 注册右边cell
    [self.rightTableView registerNib:[UINib nibWithNibName:NSStringFromClass([YGUserTableViewCell class]) bundle:nil] forCellReuseIdentifier:YGUserID];
    
    // 设置inset
    self.automaticallyAdjustsScrollViewInsets = NO;
    self.leftTableView.contentInset = UIEdgeInsetsMake(64, 0, 0, 0);
    self.rightTableView.contentInset = self.leftTableView.contentInset;
    self.rightTableView.rowHeight = 70;
    
    self.title = @"推荐关注";
    
    // 设置背景色
    [self.view setBackgroundColor:YGGlobalBg];
}

/**
 *  添加刷新控件
 */
- (void)setupRefresh
{
    self.rightTableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreUsers)];
    self.rightTableView.mj_footer.hidden = YES;
}

/**
 *  加载更多数据
 */
- (void)loadMoreUsers
{
    YGRecommendCategroy *category = YGSelectedCategory;
    
    // 发送右边网络请求
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"subscribe";
    params[@"category_id"] = @(category.id);
    params[@"page"] = @(++category.current_page);
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        // 字典 -> 模型
        NSArray *user = [YGRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        // 添加到当前对应的用户数据中
        [category.users addObjectsFromArray:user];
        
        [self.rightTableView reloadData];
        
        // 让底部控件结束刷新
        [self.rightTableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        YGLog(@"%@", error);
        
        
    }];
    
}
#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.leftTableView) {
        return self.category.count;
    } else { // 右边的用户表格
        
        NSInteger count = [YGSelectedCategory users].count;
        
        // 每次刷新右边的数据时，都控制footer显示或者隐藏
        self.rightTableView.mj_footer.hidden = (count == 0);
        return count;
        
        
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView == self.leftTableView) { // 左边的类别表格
        YGRecommendViewCell *cell = [tableView dequeueReusableCellWithIdentifier:YGCategoryID];
        
        cell.categroy = self.category[indexPath.row];
        
        return cell;
    } else {  // 右边的类别表格
        YGUserTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:YGUserID];
        cell.userCategory = [YGSelectedCategory users][indexPath.row];

        return cell;
    }
    
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YGRecommendCategroy *c = self.category[indexPath.row];
    
    [self.rightTableView.mj_footer endRefreshingWithNoMoreData];
    
    if (c.users.count) {
        // 显示曾经的数据
        [self.rightTableView reloadData];
    } else {
        // 刷新表格 目的是解决网络延迟带来的切换表格上次的数据还在
        [self.rightTableView reloadData];
        
        
        // 设置当前页码为1
        c.current_page = 1;
        
        // 发送右边网络请求
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"list";
        params[@"c"] = @"subscribe";
        params[@"category_id"] = @(c.id);
        params[@"page"] = @(c.current_page);
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            // 字典 -> 模型
            NSArray *user = [YGRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            
            // 添加到当前对应的用户数据中
            [c.users addObjectsFromArray:user];
            
            // 保存总数
            c.total = [responseObject[@"total"] integerValue];
            
            [self.rightTableView reloadData];
            if (c.users.count == c.total) {
                [self.rightTableView.mj_footer endRefreshingWithNoMoreData];
            }
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            YGLog(@"%@", error);
            
            
        }];
    }
    
}

@end
