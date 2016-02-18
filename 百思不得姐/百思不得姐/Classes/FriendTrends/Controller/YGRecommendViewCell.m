//
//  YGRecommendViewCell.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/2/17.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "YGRecommendViewCell.h"
#import "YGRecommendCategroy.h"

@interface YGRecommendViewCell ()
@property (weak, nonatomic) IBOutlet UIView *selectedIndicator;

@end

@implementation YGRecommendViewCell

- (void)setCategroy:(YGRecommendCategroy *)categroy
{
    _categroy = categroy;
    self.textLabel.text = categroy.name;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    // 重新调整内部textlabel的frame
    self.textLabel.y = 2;
    self.textLabel.height = self.contentView.height - 2 * self.textLabel.y;
}

- (void)awakeFromNib {
    
    self.backgroundColor = YGRGBColor(244, 244, 244);
    self.textLabel.font = [UIFont systemFontOfSize:13];
    self.selectedIndicator.backgroundColor = YGRGBColor(219, 21, 26);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    self.selectedIndicator.hidden = !selected;
    self.textLabel.textColor = selected ? self.selectedIndicator.backgroundColor : YGRGBColor(78, 78, 78);
}

@end
