//
//  YGCommentViewController.h
//  百思不得姐
//
//  Created by 刘勇刚 on 16/3/3.
//  Copyright © 2016年 liu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YGTopic;

@interface YGCommentViewController : UIViewController
/**
 *  帖子模型
 */
@property (strong, nonatomic) YGTopic *topic;

@end
