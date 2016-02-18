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

#pragma mark - <UITableViewDataSource>

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (tableView == self.leftTableView) {
        return self.category.count;
    } else {
        // 左边被选中的类别
        YGRecommendCategroy *c = self.category[self.leftTableView.indexPathForSelectedRow.row];
        return c.users.count;
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
        YGRecommendCategroy *c = self.category[self.leftTableView.indexPathForSelectedRow.row];
        cell.userCategory = c.users[indexPath.row];

        return cell;
    }
    
}

#pragma mark - <UITableViewDelegate>

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YGRecommendCategroy *c = self.category[indexPath.row];
    if (c.users.count) {
        // 显示曾经的数据
        [self.rightTableView reloadData];
    } else {
        // 发送右边网络请求
        NSMutableDictionary *params = [NSMutableDictionary dictionary];
        params[@"a"] = @"list";
        params[@"c"] = @"subscribe";
        params[@"category_id"] = @(c.id);
        [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
            // 字典 -> 模型
            NSArray *user = [YGRecommendUser mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
            // 添加到当前对应的用户数据中
            [c.users addObjectsFromArray:user];
            
            [self.rightTableView reloadData];
            
        } failure:^(NSURLSessionDataTask *task, NSError *error) {
            YGLog(@"%@", error);
            
            
        }];
    }
    
}

@end
