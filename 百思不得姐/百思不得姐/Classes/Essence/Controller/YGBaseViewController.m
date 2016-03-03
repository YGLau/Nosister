//
//  YGBaseViewController.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/2/25.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "YGBaseViewController.h"

#import <AFNetworking.h>
#import <UIImageView+WebCache.h>
#import <MJExtension.h>
#import <MJRefresh.h>
#import "YGTopic.h"
#import "YGTopicCell.h"
#import "YGCommentViewController.h"

@interface YGBaseViewController ()
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

@implementation YGBaseViewController


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
    
    // 初始化表格
    [self setupTableView];
    
    // 添加舒心控件
    [self setupRefresh];
    
}

static NSString * const YGTopicCellID = @"topic";
- (void)setupTableView
{
    // 设置内边距
    CGFloat top = YGTitleViewH +YGTitleViewY;
    CGFloat bottom = self.tabBarController.tabBar.height;
    self.tableView.contentInset = UIEdgeInsetsMake(top, 0, bottom, 0);
    // 滚动条的内边距
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    // 去除分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 清除表格颜色
    self.tableView.backgroundColor = [UIColor clearColor];
    
    // 注册
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YGTopicCell class]) bundle:nil] forCellReuseIdentifier:YGTopicCellID];
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
    params[@"type"] = @(self.type);
    self.params = params;
    // 发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        [responseObject writeToFile:@"/Users/liuyonggang/Desktop/a.plist" atomically:YES];
        
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
    params[@"type"] = @(self.type);
    params[@"page"] = @(self.page);
    params[@"maxtime"] = self.maxtime;
    self.params = params;
    // 发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, NSDictionary *responseObject) {
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
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    self.tableView.mj_footer.hidden = (self.topics.count == 0);
    return self.topics.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YGTopicCell *cell = [tableView dequeueReusableCellWithIdentifier:YGTopicCellID];
    
    cell.topic = self.topics[indexPath.row];
    return cell;
}

#pragma mark - 代理方法
/**
 *  返回Cell的高度
 */
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    // 取出模型
    YGTopic *topic = self.topics[indexPath.row];
    // 返回cell的高度
    return topic.cellHeight;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    YGCommentViewController *cmtVc = [[YGCommentViewController alloc] init];
    cmtVc.topic = self.topics[indexPath.row]; // 将数据传递到下一个控制器
    [self.navigationController pushViewController:cmtVc animated:YES];
}
@end