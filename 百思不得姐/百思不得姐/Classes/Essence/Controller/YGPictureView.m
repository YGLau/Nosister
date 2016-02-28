//
//  YGPictureView.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/2/26.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "YGPictureView.h"
#import "YGTopic.h"
#import <UIImageView+WebCache.h>
#import "YGBigPictureController.h"

@interface YGPictureView ()
/**
 *  图片
 */
@property (weak, nonatomic) IBOutlet UIImageView *picImageView;
/**
 *  是否会gif
 */
@property (weak, nonatomic) IBOutlet UIImageView *gifView;
/**
 *  查看大图
 */
@property (weak, nonatomic) IBOutlet UIButton *seeBigPicBtn;

@end

@implementation YGPictureView

- (void)showBigPicture
{
    YGBigPictureController *picVc = [[YGBigPictureController alloc] init];
    // 将模型数据传给控制器的topic模型
    picVc.topic = self.topic;
    [[UIApplication sharedApplication].keyWindow.rootViewController presentViewController:picVc animated:YES completion:nil];
}

+ (instancetype)pictureView
{
    return [[[NSBundle mainBundle] loadNibNamed:NSStringFromClass(self) owner:nil options:nil] lastObject];
}

- (void)awakeFromNib
{
    self.autoresizingMask = UIViewAutoresizingNone;
    
    // 给图片添加监听器
    self.picImageView.userInteractionEnabled = YES;
    [self.picImageView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showBigPicture)]];
}

-(void)setTopic:(YGTopic *)topic
{
    _topic = topic;
    [self.picImageView sd_setImageWithURL:[NSURL URLWithString:topic.large_image] placeholderImage:nil options:0 progress:^(NSInteger receivedSize, NSInteger expectedSize) {
        
    } completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        // 开启图形上下文
        UIGraphicsBeginImageContextWithOptions(topic.picFrame.size, YES, 0.0);

        // 大图才需要裁剪
        if (topic.bigPicture == NO) return;

        // 将下载下来的图片绘制到上面
        CGFloat imageW = topic.picFrame.size.width;
        CGFloat imageH = imageW * image.size.height / image.size.width;
        [image drawInRect:CGRectMake(0, 0, imageW, imageH)];

        // 获得图片
        self.picImageView.image = UIGraphicsGetImageFromCurrentImageContext();

        // 结束上下文
        UIGraphicsEndImageContext();
        
    }];
    // 是否为gif
    
    self.gifView.hidden = !topic.isGif;
    
    // 查看大图按钮显示
    self.seeBigPicBtn.hidden = !topic.bigPicture;
    
}
@end
