//
//  YGRecommendTagCell.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/2/18.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "YGRecommendTagCell.h"
#import "YGRecommendTag.h"
#import <UIImageView+WebCache.h>

@interface YGRecommendTagCell ()


@property (weak, nonatomic) IBOutlet UIImageView *imageList;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *subCount;

@end

@implementation YGRecommendTagCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setRecommendTag:(YGRecommendTag *)recommendTag
{
    _recommendTag = recommendTag;
    [self.imageList setCircleHeader:recommendTag.image_list];
    self.nameLabel.text = recommendTag.theme_name;
    
    NSString *subNum = nil;
    if (recommendTag.sub_number < 10000) {
        subNum = [NSString stringWithFormat:@"%zd人订阅", recommendTag.sub_number];
    } else {
        subNum = [NSString stringWithFormat:@"%.1f万人订阅", recommendTag.sub_number / 10000.0];
    }
    self.subCount.text = subNum;
    
}

-(void)setFrame:(CGRect)frame
{
    frame.size.height -= 1;
    [super setFrame:frame];
}

@end
