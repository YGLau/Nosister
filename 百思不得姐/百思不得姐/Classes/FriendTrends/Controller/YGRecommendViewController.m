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


@interface YGRecommendViewController () <UITableViewDelegate, UITableViewDataSource>
/**
 *  左边的类别数据
 */
@property (strong, nonatomic) NSArray *category;
/**
 *  左边的tableView控件
 */
@property (weak, nonatomic) IBOutlet UITableView *leftTableView;

@end

@implementation YGRecommendViewController

static NSString * const YGCategoryID = @"category";

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 注册cell
    [self.leftTableView registerNib:[UINib nibWithNibName:NSStringFromClass([YGRecommendViewCell class]) bundle:nil] forCellReuseIdentifier:YGCategoryID];
    
    self.title = @"推荐关注";
    
    // 设置背景色
    [self.view setBackgroundColor:YGGlobalBg];
    
    // 显示指示器
    [SVProgressHUD showWithMaskType:SVProgressHUDMaskTypeBlack];
    
    // 发送请求
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
    return self.category.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    YGRecommendViewCell *cell = [tableView dequeueReusableCellWithIdentifier:YGCategoryID];
    
    cell.categroy = self.category[indexPath.row];
    
    return cell;
}

@end
