//
//  YGVideoView.h
//  百思不得姐
//
//  Created by 刘勇刚 on 16/2/28.
//  Copyright © 2016年 liu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YGTopic;

@interface YGVideoView : UIView
/**
 *  帖子模型
 */
@property (strong, nonatomic) YGTopic *topic;

+ (instancetype)videoView;

@end
