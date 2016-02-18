//
//  YGRecommendViewCell.h
//  百思不得姐
//
//  Created by 刘勇刚 on 16/2/17.
//  Copyright © 2016年 liu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YGRecommendCategroy;

@interface YGRecommendViewCell : UITableViewCell

/**
 *  模型对象
 */
@property (strong, nonatomic) YGRecommendCategroy *categroy;

@end
