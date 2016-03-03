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

@interface YGCommentViewController () <UITableViewDelegate, UITableViewDataSource>
/**
 *  底部工具条间距
 */
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomLine;
/**
 *  tableView
 */
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation YGCommentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupBasic];
    // 设置头部
    [self setupHeader];
    
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
    
    YGTopicCell *cell = [YGTopicCell cell];
    cell.topic = self.topic;
    // Cell的高度
    cell.size = CGSizeMake(YGmainScreenW, self.topic.cellHeight);
    [header addSubview:cell];
    
    //header的高度
    header.height = cell.height + YGTopicCellMargin;
    
    self.tableView.tableHeaderView = header;
    
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
}

#pragma mark - UITableViewDelegate方法
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark - UITableViewDataSource方法
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 10;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return @"评论";
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"comment"];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"comment"];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%zd -- %zd", indexPath.section, indexPath.row];
    return cell;
}
@end
