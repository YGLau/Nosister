//
//  YGTopicCell.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/2/25.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "YGTopicCell.h"
#import "YGTopic.h"


@implementation YGTopicCell

-(void)awakeFromNib
{
    UIImageView *bg = [[UIImageView alloc] init];
    bg.image = [UIImage imageNamed:@"mainCellBackground"];
    self.backgroundView = bg;
}

-(void)setTopic:(YGTopic *)topic
{
    _topic = topic;
    
}

-(void)setFrame:(CGRect)frame
{
    frame.origin.x = 10;
    frame.size.width -= 2 * frame.origin.x;
    frame.size.height -= 10;
    frame.origin.y += 10;
    [super setFrame:frame];
}

@end
