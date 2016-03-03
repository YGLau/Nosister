//
//  YGCommentHeaderView.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/3/3.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "YGCommentHeaderView.h"
@interface YGCommentHeaderView ()
/**
 *  文字标签
 */
@property (weak, nonatomic) UILabel *label;
@end

@implementation YGCommentHeaderView
+ (instancetype)headerViewWithTableView:(UITableView *)tableView
{
    static NSString * const ID = @"header";
    // 先从缓存池中找
    YGCommentHeaderView *header = [tableView dequeueReusableHeaderFooterViewWithIdentifier:ID];
    if (header == nil) { // 如果没有
        header = [[YGCommentHeaderView alloc] initWithReuseIdentifier:ID];
    }
    
    return header;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        self.contentView.backgroundColor = YGGlobalBg;
        UILabel *label = [[UILabel alloc] init];
        label.textColor = YGRGBColor(67, 67, 67);
        label.width = 200;
        label.x = YGTopicCellMargin;
        label.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        [self.contentView addSubview:label];
        self.label = label;
        
    }
    
    return self;
}

- (void)setTitle:(NSString *)title
{
    _title = [title copy];
    self.label.text = title;
}
@end
