//
//  YGUserTableViewCell.h
//  百思不得姐
//
//  Created by 刘勇刚 on 16/2/18.
//  Copyright © 2016年 liu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YGRecommendUser;

@interface YGUserTableViewCell : UITableViewCell
/**
 *  用户模型
 */
@property (strong, nonatomic) YGRecommendUser *userCategory;

@end
