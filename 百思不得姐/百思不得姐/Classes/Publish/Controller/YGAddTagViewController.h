//
//  YGAddTagViewController.h
//  百思不得姐
//
//  Created by 刘勇刚 on 16/3/8.
//  Copyright © 2016年 liu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YGAddTagViewController : UIViewController

@property (copy, nonatomic) void (^tagsBlock) (NSArray *);
/**
 *  所有的标签属性
 */
@property (strong, nonatomic) NSArray *tags;

@end
