//
//  YGTopic.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/2/25.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "YGTopic.h"
#import <MJExtension.h>
#import "YGComment.h"
#import "YGUser.h"

@implementation YGTopic

{
    CGFloat _cellHeight;
}

+ (NSDictionary *)mj_replacedKeyFromPropertyName
{
    return @{
             @"large_image" : @"image1",
             @"meddle_image" : @"image2",
             @"small_image" : @"image0",
             @"ID" : @"id"
             };
}

+ (NSDictionary *)mj_objectClassInArray
{
    return @{@"top_cmt" : @"YGComment"};
}

/**
 *  时间处理
 */
- (NSString *)create_time
{
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    NSDate *createTime = [fmt dateFromString:_create_time];
    if (createTime.isThisYear) { // 今年
        NSDateComponents *cmps = [[NSDate date] deltaFrom:createTime];
        if (createTime.isToday) { // 今天
            if (cmps.hour >= 1) { // 至少间隔1小时
                return [NSString stringWithFormat:@"%zd小时前", cmps.hour];
            } else if (cmps.minute >= 1){ //至少间隔1分钟
                return [NSString stringWithFormat:@"%zd分钟前", cmps.minute];
            } else {
                return @"刚刚";
            }
            
        } else if(createTime.isYesterday) { // 昨天
            fmt.dateFormat = @"昨天 HH:mm";
            return [fmt stringFromDate:createTime];
        } else {
            fmt.dateFormat = @"MM-dd HH:mm";
            return [fmt stringFromDate:createTime];
        }
    } else { // 去年
        return _create_time;
    }
}

-(CGFloat)cellHeight
{
    
    if (!_cellHeight) { //计算Cell的高度
        //文字最大Y值
        CGFloat textY = 2 * YGTopicCellMargin + YGTopicCellIconH;
        CGFloat textW = [UIScreen mainScreen].bounds.size.width - 4 * YGTopicCellMargin;
        CGSize maxSize = CGSizeMake(textW, MAXFLOAT);
        CGFloat textH = [self.text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:14]} context:nil].size.height;
        
        // 文字的高度
        _cellHeight = textY + textH + YGTopicCellMargin;
            
        if (self.type == YGBaseTopicTypePicture) { // 图片
            
            CGFloat pictureW = textW;
            CGFloat pictureH = pictureW * self.height / self.width;
            
            // 计算图片控件的frame
            CGFloat pictureY = textY + textH + YGTopicCellMargin;
            if (pictureH >= YGTopicPictureMaxH) {  // 大图
                pictureH = YGTopicPictureClipH;
                self.bigPicture = YES; // 标记为大图
                
            }
            _picFrame = CGRectMake(YGTopicCellMargin, pictureY, pictureW, pictureH);
            
            // 图片的高度
            _cellHeight += pictureH + YGTopicCellMargin;
            
        } else if (self.type == YGBaseTopicTypeVoice){ // 声音
            CGFloat voiceW = textW;
            CGFloat voiceH = voiceW * self.height / self.width;
            
            // 计算图片控件的frame
            CGFloat voiceY = textY + textH + YGTopicCellMargin;
            _voiceF = CGRectMake(YGTopicCellMargin, voiceY, voiceW, voiceH);
            
            // 图片的高度
            _cellHeight += voiceH + YGTopicCellMargin;
            
        } else if (self.type == YGBaseTopicTypeVideo) { // 视频
            CGFloat videoW = textW;
            CGFloat videoH = videoW * self.height / self.width;
            
            // 计算图片控件的frame
            CGFloat videoY = textY + textH + YGTopicCellMargin;
            _videoF = CGRectMake(YGTopicCellMargin, videoY, videoW, videoH);
            
            // 图片的高度
            _cellHeight += videoH + YGTopicCellMargin;
        }
        
        
        YGComment *cmt = [self.top_cmt firstObject];
        if (cmt) {
            NSString *content = [NSString stringWithFormat:@"%@ : %@",cmt.user.username, cmt.content];
            CGFloat contentH = [content boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:13]} context:nil].size.height;
            _cellHeight += YGTopicCellCommentTitleH + contentH +YGTopicCellMargin;
        }
        
        
        // 底部按钮的高度
        _cellHeight += YGTopicCellBottomToolH + YGTopicCellMargin;
    }
    
    return _cellHeight;
}

@end
