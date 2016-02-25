//
//  YGWordTableViewController.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/2/25.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "YGWordTableViewController.h"
#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import <MJExtension.h>
#import <MJRefresh.h>
#import "YGTopic.h"

@interface YGWordTableViewController ()
/**
 *  帖子数据
 */
@property (strong, nonatomic) NSMutableArray *topics;
/**
 *  当前页码
 */
@property (assign, nonatomic) NSInteger page;
/**
 * 加载下一页数据
 */
@property (copy, nonatomic) NSString *maxtime;
/**
 *  上一次请求的参数
 */
@property (strong, nonatomic) NSDictionary *params;
@end

@implementation YGWordTableViewController


/**
 *  懒加载
 */
-(NSMutableArray *)topics
{
    if (!_topics) {
        _topics = [NSMutableArray array];
    }
    
    return _topics;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    
    //加载新的段子内容
    [self loadNewTopics];
    
    // 添加舒心控件
    [self setupRefresh];
    
}
#pragma mark - 数据处理
/**
 *  加载新的段子内容
 */
- (void)loadNewTopics
{
    // 结束上拉刷新
    [self.tableView.mj_footer endRefreshing];
    
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @"29";
    self.params = params;
    // 发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        if (self.params != params) return;
        
        // 字典 ——> 模型
        self.topics = [YGTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
        
        // 成功后再将页码清空为零
        self.page = 0;
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        // 结束刷新
        [self.tableView.mj_header endRefreshing];
        
    }];
}
/**
 *  加载更多数据
 */
- (void)loadMoreTopics
{
    
    // 结束下拉刷新
    [self.tableView.mj_header endRefreshing];
    
    self.page++;
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"list";
    params[@"c"] = @"data";
    params[@"type"] = @"29";
    params[@"page"] = @(self.page);
    params[@"maxtime"] = self.maxtime;
    self.params = params;
    // 发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        // 请求参数过期，直接返回
        if (self.params != params) return;
        
        // 存储maxtime
        self.maxtime = responseObject[@"info"][@"maxtime"];
        // 字典 ——> 模型
        NSArray *newTopics = [YGTopic mj_objectArrayWithKeyValuesArray:responseObject[@"list"]];
        [self.topics addObjectsFromArray:newTopics];
        // 刷新表格
        [self.tableView reloadData];
        
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (self.params != params) return;
        
        // 结束刷新
        [self.tableView.mj_footer endRefreshing];
        // 恢复页码
        self.page--;
        
    }];
}
#pragma mark - 刷新控件
- (void)setupRefresh
{
    // 头部刷新控件
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewTopics)];
    self.tableView.mj_header.automaticallyChangeAlpha = YES;
    // 一进来就刷新
    [self.tableView.mj_header beginRefreshing];
    
    // 尾部刷新控件
    self.tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreTopics)];
//    self.tableView.mj_footer.hidden = YES;
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    YGTopic *topic = self.topics[indexPath.row];
    cell.textLabel.text = topic.name;
    cell.detailTextLabel.text = topic.text;
    [cell.imageView sd_setImageWithURL:[NSURL URLWithString:topic.profile_image] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    return cell;
}



@end
