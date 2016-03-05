//
//  YGMeCell.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/3/5.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "YGMeCell.h"


@implementation YGMeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        // 设置背景图片
        UIImageView *bg = [[UIImageView alloc] init];
        bg.image = [UIImage imageNamed:@"mainCellBackground"];
        self.backgroundView = bg;
        
        self.textLabel.textColor = [UIColor darkGrayColor];
        self.textLabel.font = [UIFont systemFontOfSize:15];
    }
    return self;
    
    
}

- (void)layoutSubviews
{
    
    [super layoutSubviews];
    
    if (self.imageView.image == nil) return;

    self.imageView.width = 30;
    self.imageView.height = self.imageView.width;
    self.imageView.centerY = self.contentView.height * 0.5;
    self.textLabel.x = CGRectGetMaxX(self.imageView.frame) + YGTopicCellMargin;
    
}

//- (void)setFrame:(CGRect)frame
//{
//    
//    YGLog(@"%@", NSStringFromCGRect(frame));
//    [super setFrame:frame];
//}
@end
