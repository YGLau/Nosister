//
//  YGBigPictureController.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/2/28.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "YGBigPictureController.h"
#import "YGTopic.h"
#import <UIImageView+WebCache.h>
#import <SVProgressHUD.h>

@interface YGBigPictureController ()
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) UIImageView *imageView;

@end

@implementation YGBigPictureController
/**
 *  关闭
 */
- (IBAction)close
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 添加图片view
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.userInteractionEnabled = YES;
    [imageView addGestureRecognizer:[[UIGestureRecognizer alloc] initWithTarget:self action:@selector(close)]];
    [self.scrollView addSubview:imageView];
    self.imageView = imageView;
    
    // 图片尺寸
    CGFloat pictureW = YGmainScreenW;
    CGFloat pictureH = YGmainScreenW * self.topic.height / self.topic.width;
    if (pictureH > YGmainScreenH) { // 需要滚动显示
        imageView.frame = CGRectMake(0, 0, pictureW, pictureH);
        self.scrollView.contentSize = CGSizeMake(0, pictureH);
    } else {
        imageView.size = CGSizeMake(pictureW, pictureH);
        imageView.centerY = YGmainScreenH * 0.5;
    }
    
    // 填充图片
    [imageView sd_setImageWithURL:[NSURL URLWithString:self.topic.large_image]];
}

- (IBAction)save {
    
    if (self.imageView.image == nil) {
        [SVProgressHUD showErrorWithStatus:@"图片没有下载完毕！"];
        return;
    }
    
    // 将图片写进相册
    UIImageWriteToSavedPhotosAlbum(self.imageView.image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
}
- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo{
    
    if (error) {
        [SVProgressHUD showErrorWithStatus:@"保存失败!"];
    } else {
        [SVProgressHUD showErrorWithStatus:@"保存成功!"];
    }
    
}

@end
