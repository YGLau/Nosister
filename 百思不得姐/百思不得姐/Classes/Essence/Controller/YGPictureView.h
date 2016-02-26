//
//  YGPictureView.h
//  百思不得姐
//
//  Created by 刘勇刚 on 16/2/26.
//  Copyright © 2016年 liu. All rights reserved.
//

#import <UIKit/UIKit.h>
@class YGTopic;

@interface YGPictureView : UIView

@property (strong, nonatomic) YGTopic *topic;
/**
 *  快速返回一个创建好的picture
 */
+ (instancetype)pictureView;

@end
