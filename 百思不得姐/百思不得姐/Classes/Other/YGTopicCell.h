//
//  YGTopicCell.h
//  百思不得姐
//
//  Created by 刘勇刚 on 16/2/25.
//  Copyright © 2016年 liu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YGTopic;
@class YGComment;

@interface YGTopicCell : UITableViewCell
/**
 *  topic模型
 */
@property (strong, nonatomic) YGTopic *topic;
@end
