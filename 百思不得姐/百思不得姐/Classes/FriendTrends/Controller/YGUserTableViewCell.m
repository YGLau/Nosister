//
//  YGUserTableViewCell.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/2/18.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "YGUserTableViewCell.h"
#import "YGRecommendUser.h"
#import <UIImageView+WebCache.h>

@interface YGUserTableViewCell ()
/**
 *  头像图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;
@property (weak, nonatomic) IBOutlet UILabel *screen_nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *fansCountLabel;

@end

@implementation YGUserTableViewCell

-(void)setUserCategory:(YGRecommendUser *)userCategory
{
    _userCategory = userCategory;
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:userCategory.header] placeholderImage:[UIImage imageNamed:@"defaultUserIcon"]];
    self.screen_nameLabel.text = userCategory.screen_name;
    
    self.fansCountLabel.text = [NSString stringWithFormat:@"%zd人关注", userCategory.fans_count];
    
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
