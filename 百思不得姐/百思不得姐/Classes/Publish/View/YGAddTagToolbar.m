//
//  YGAddTagToolbar.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/3/7.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "YGAddTagToolbar.h"

@interface YGAddTagToolbar ()
@property (weak, nonatomic) IBOutlet UIView *topView;

@end

@implementation YGAddTagToolbar

- (void)awakeFromNib
{
    UIButton *addBtn = [[UIButton alloc] init];
    [addBtn setImage:[UIImage imageNamed:@"tag_add_icon"] forState:UIControlStateNormal];
    [addBtn addTarget:self action:@selector(addBtnClick) forControlEvents:UIControlEventTouchUpInside];
    addBtn.size = addBtn.currentImage.size;
    [self.topView addSubview:addBtn];
}

- (void)addBtnClick
{
    
}

@end
