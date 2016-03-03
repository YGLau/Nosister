//
//  YGCommentViewController.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/3/3.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "YGCommentViewController.h"
#import "YGTopic.h"
#import "YGTopicCell.h"
#import <MJRefresh.h>
#import <AFNetworking.h>
#import "YGComment.h"
#import <MJExtension.h>
#import "YGCommentHeaderView.h"


@interface YGCommentViewController () <UITableViewDelegate, UITableViewDataSource>
/**
 *  底部工具条间距
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLine;
/**
 *  tableView
 */
@property (weak, nonatomic) IBOutlet UITableView *tableView;
/**
 *  最热评论
 */
@property (strong, nonatomic) NSArray *hotComment;
/**
 *  最新评论
 */
@property (strong, nonatomic) NSMutableArray *latestComment;
/**
 *  保存帖子的数据
 */
@property (strong, nonatomic) NSArray *saved_top_cmt;

@end

@implementation YGCommentViewController

- (NSMutableArray *)latestComment
{
    if (!_latestComment) {
        _latestComment = [NSMutableArray array];
    }
    
    return _latestComment;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBasic];
    // 设置头部
    [self setupHeader];
    
    // 刷新控件
    [self setupRefresh];
    
}
/**
 *  设置基本数据
 */
- (void)setupBasic
{
    self.title = @"评论";
    self.navigationItem.rightBarButtonItem = [UIBarButtonItem itemWithImage:@"comment_nav_item_share_icon" highImage:@"comment_nav_item_share_icon_click" target:self action:nil];
    
    // 监听键盘的弹出或隐藏
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    //tableView设置全局色
    self.tableView.backgroundColor = YGGlobalBg;
}
/**
 *  设置头部cell
 */
- (void)setupHeader
{
    UIView *header = [[UIView alloc] init];
    // 清空top_cmt
    if (self.topic.top_cmt.count) {
        self.saved_top_cmt = self.topic.top_cmt;
        self.topic.top_cmt = nil;
        [self.topic setValue:@0 forKey:@"cellHeight"];
    }
    
    
    
    YGTopicCell *cell = [YGTopicCell cell];
    cell.topic = self.topic;
    // Cell的高度
    cell.size = CGSizeMake(YGmainScreenW, self.topic.cellHeight);
    [header addSubview:cell];
    
    //header的高度
    header.height = cell.height + YGTopicCellMargin;
    
    self.tableView.tableHeaderView = header;
    
}
- (void)setupRefresh
{
    self.tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewComment)];
    [self.tableView.mj_header beginRefreshing]; // 一进来自动刷新
}
- (void)loadNewComment
{
    // 参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"a"] = @"dataList";
    params[@"c"] = @"comment";
    params[@"data_id"] = self.topic.ID;
    params[@"hot"] = @"1";
    // 发送请求
    [[AFHTTPSessionManager manager] GET:@"http://api.budejie.com/api/api_open.php" parameters:params success:^(NSURLSessionDataTask *task, id responseObject) {
        // 最热评论
        self.hotComment = [YGComment mj_objectArrayWithKeyValuesArray:responseObject[@"hot"]];
        // 最新评论
        self.latestComment = [YGComment mj_objectArrayWithKeyValuesArray:responseObject[@"data"]];
        
        // 刷新表格
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        [self.tableView.mj_header endRefreshing]; // 结束刷新
        
    }];
}
- (void)keyboardWillChangeFrame:(NSNotification *)note
{
    // 键盘最终显示/隐藏完毕后的frame
    CGRect frame = [note.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    // 修改约束
    self.bottomLine.constant = YGmainScreenH - frame.origin.y;
    
    CGFloat duration = [note.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        [self.view layoutIfNeeded];
    }];
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
    // 恢复帖子的数据
    if (self.saved_top_cmt) {
        self.topic.top_cmt = self.saved_top_cmt;
        [self.topic setValue:@0 forKey:@"cellHeight"];
    }
    
}
- (NSArray *)commentsInSection:(NSInteger)section
{
    if (section == 0) {
        return self.hotComment.count ? self.hotComment : self.latestComment;
    }
    return self.latestComment;
}
#pragma mark - UITableViewDelegate方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark - UITableViewDataSource方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger hotCount = self.hotComment.count;
    NSInteger latestCount = self.latestComment.count;
    if (hotCount) return 2;
    if (latestCount) return 1;
    return 0;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSInteger hotCount = self.hotComment.count;
    NSInteger latestCount = self.latestComment.count;
    if (section == 0) {
        return hotCount ? hotCount : latestCount;
    }
    return latestCount;
}
//- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
//{
//    NSInteger hotCount = self.hotComment.count;
//    if (section == 0) {
//        return hotCount ? @"最热评论" : @"最新评论";
//    }
//    return @"最新评论";
//}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    YGCommentHeaderView *header = [YGCommentHeaderView headerViewWithTableView:tableView];
    
    // 设置文字
    NSInteger hotCount = self.hotComment.count;
    if (section == 0) {
        header.title = hotCount ? @"最热评论" : @"最新评论";
    } else {
        header.title = @"最新评论";
    }
    
    return header;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"comment"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"comment"];
    }
    YGComment *comment = [self commentsInSection:indexPath.section][indexPath.row];
    cell.textLabel.text = comment.content;
    return cell;
}
@end
