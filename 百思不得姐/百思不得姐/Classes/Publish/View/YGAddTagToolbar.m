//
//  YGAddTagToolbar.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/3/7.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "YGAddTagToolbar.h"
#import "YGAddTagViewController.h"

@interface YGAddTagToolbar ()
@property (weak, nonatomic) IBOutlet UIView *topView;
/**
 *  装标签的可变数据
 */
@property (strong, nonatomic) NSMutableArray *tagsArray;
/**
 *  添加标签
 */
@property (weak, nonatomic) UIButton *addTagbutton;

@end

@implementation YGAddTagToolbar

- (NSMutableArray *)tagsArray
{
    if (!_tagsArray) {
        _tagsArray = [NSMutableArray array];
    }
    return _tagsArray;
}

- (void)awakeFromNib
{
    UIButton *addBtn = [[UIButton alloc] init];
    [addBtn setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    addBtn.size = addBtn.currentImage.size;
    [self.topView addSubview:addBtn];
    self.addTagbutton = addBtn;
}

- (void)addBtnClick
{
    YGAddTagViewController *addTag = [[YGAddTagViewController alloc] init];
    __weak typeof (self) weakSelf = self;
    [addTag setTagsBlock:^(NSArray *tags) {
        [weakSelf createTags:tags];
    }];
    addTag.tags = [self.tagsArray valueForKeyPath:@"text"];
    UITabBarController *root = (UITabBarController *)[UIApplication sharedApplication].keyWindow.rootViewController;
    UINavigationController *nav = (UINavigationController *)root.presentedViewController;
    [nav pushViewController:addTag animated:YES];
}

/**
 *  创建标签
 */
- (void)createTags:(NSArray *)tags
{
    // 删除数组
    [self.tagsArray makeObjectsPerformSelector:@selector(removeFromSuperview)];
    [self.tagsArray removeAllObjects];
    
    for (int i = 0; i < tags.count; i++) {
        UILabel *label = [[UILabel alloc] init];
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        label.layer.cornerRadius = 5;
        label.layer.masksToBounds = YES;
        label.text = tags[i];
        [label sizeToFit];
        label.backgroundColor = YGTagBg;
        if (i == 0) { // 第一个label
            label.x = YGTagMargin;
        } else { // 其他label
            
            UILabel *lastLabel = self.tagsArray[i - 1];
            CGFloat leftMargin = self.topView.width - CGRectGetMaxX(lastLabel.frame) - YGTagMargin;
            if (leftMargin >= label.width) { // 当前行
                label.x = CGRectGetMaxX(lastLabel.frame) + YGTagMargin;
                label.y = lastLabel.y;
            } else { // 下一行
                label.x = 0;
                label.y = CGRectGetMaxY(lastLabel.frame) +YGTagMargin;
                
            }
            
        }
        label.width += YGTagMargin;
        label.height += YGTagMargin;
        
        [self.tagsArray addObject:label];
        [self.topView addSubview:label];
        
        UILabel *lastLabel = [self.tagsArray lastObject];
        CGFloat leftMargin = self.topView.width - CGRectGetMaxX(lastLabel.frame) - YGTagMargin;
        if (leftMargin >= self.addTagbutton.width) { // 一行够显示
            self.addTagbutton.x = CGRectGetMaxX(lastLabel.frame) + YGTagMargin;
            self.addTagbutton.y = lastLabel.y;
        } else { // 一行不够显示
            self.addTagbutton.x = 0;
            self.addTagbutton.y = CGRectGetMaxY(lastLabel.frame) + YGTagMargin;
        }
    }
    
    
}
@end
