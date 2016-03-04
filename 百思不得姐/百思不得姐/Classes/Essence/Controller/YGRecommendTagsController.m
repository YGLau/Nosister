//
//  YGRecommendTagsController.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/2/18.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "YGRecommendTagsController.h"
#import <AFNetworking.h>
#import <SVProgressHUD.h>
#import <MJExtension.h>
#import "YGRecommendTag.h"
#import "YGRecommendTagCell.h"

@interface YGRecommendTagsController ()

@property (strong, nonatomic) NSArray *tags;

@end

@implementation YGRecommendTagsController

static NSString * const YGTagID = @"tag";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupTableView];
    
    [self loadData];
}
/**
 *  初始化tableView
 */
- (void)setupTableView
{
    self.title = @"推荐标签";
    self.tableView.rowHeight = 70;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    // 清除背景色
    self.tableView.backgroundColor = YGGlobalBg;
    
    // 注册Cell
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([YGRecommendTagCell class]) bundle:nil] forCellReuseIdentifier:YGTagID];
    
}
/**
 *  加载数据
 */
- (void)loadData
{
    // 发送请求
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"tag_recommend";
    params[@"action"] = @"sub";
    params[@"c"] = @"topic";
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        
        self.tags = [YGRecommendTag mj_objectArrayWithKeyValuesArray:responseObject];
        [self.tableView reloadData];
        
        // 取消遮盖
        [SVProgressHUD dismiss];
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        [SVProgressHUD showErrorWithStatus:@"加载请求失败"];
        
        
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source



- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.tags.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    YGRecommendTagCell *cell = [tableView dequeueReusableCellWithIdentifier:YGTagID];
    cell.recommendTag = self.tags[indexPath.row];
    return cell;
}




@end
