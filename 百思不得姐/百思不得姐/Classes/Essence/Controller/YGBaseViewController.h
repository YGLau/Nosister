//
//  YGBaseViewController.h
//  百思不得姐
//
//  Created by 刘勇刚 on 16/2/25.
//  Copyright © 2016年 liu. All rights reserved.
//

// 	1为全部，10为图片，29为段子，31为音频，41为视频，默认为1

#import <UIKit/UIKit.h>


@interface YGBaseViewController : UITableViewController

@property (assign, nonatomic) YGBaseTopicType type;

@end
