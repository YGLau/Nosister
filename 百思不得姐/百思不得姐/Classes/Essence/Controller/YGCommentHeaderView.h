//
//  YGCommentHeaderView.h
//  百思不得姐
//
//  Created by 刘勇刚 on 16/3/3.
//  Copyright © 2016年 liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YGCommentHeaderView : UITableViewHeaderFooterView
/**
 *  文字
 */
@property (copy, nonatomic) NSString *title;
/**
 *  返回一个创建好的headerView
 */
+ (instancetype)headerViewWithTableView:(UITableView *)tableView;

@end
