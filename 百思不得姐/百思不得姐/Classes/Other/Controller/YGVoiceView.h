//
//  YGVoiceView.h
//  百思不得姐
//
//  Created by 刘勇刚 on 16/2/27.
//  Copyright © 2016年 liu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YGTopic.h"

@interface YGVoiceView : UIView
/**
 *  段子模型
 */
@property (strong, nonatomic) YGTopic *topic;
/**
 *  返回一个创建好的声音xib
 */
+ (instancetype)voiceView;

@end
