//
//  YGPublishController.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/2/27.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "YGPublishController.h"
#import "YGOtherLoginButton.h"
#import <POP.h>

static CGFloat const YGAnimationDelay = 0.05;
static CGFloat const YGSpringfactor = 10;

@interface YGPublishController ()

@end

@implementation YGPublishController
/**
 *  取消按钮
 */
- (IBAction)close:(id)sender {
    
    [self dismissViewControllerAnimated:NO completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // 让view不能被点击
    self.view.userInteractionEnabled = NO;
    
    NSArray *btnName = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    NSArray *picArr = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    for (NSInteger i = 0; i < btnName.count; i++) {
        YGOtherLoginButton *button = [[YGOtherLoginButton alloc] init];
        [self.view addSubview:button];
        [button setTitle:btnName[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:picArr[i]] forState:UIControlStateNormal];
        // 计算行号和列号
        CGFloat row = i / 3;
        CGFloat col = i % 3;
        
        CGFloat btnW= 72;
        CGFloat btnH= btnW + 30;
        // 按钮间距
        CGFloat btnmarginX =(YGmainScreenW - 3 * btnW) * 0.25;
        CGFloat btnmarginY = 10;
        CGFloat btnX= (btnmarginX + btnW) * col + btnmarginX;
        CGFloat btnY= (YGmainScreenH - 2 * btnH - btnmarginY) * 0.5 + row * (btnH + btnmarginY);
        
        // 添加动画
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewFrame];
        anim.fromValue = [NSValue valueWithCGRect:CGRectMake(btnX, btnY - YGmainScreenH, btnW, btnH)];
        anim.toValue = [NSValue valueWithCGRect:CGRectMake(btnX, btnY, btnW, btnH)];
        anim.springBounciness = YGSpringfactor;
        anim.springSpeed = YGSpringfactor;
        anim.beginTime = CACurrentMediaTime() + YGAnimationDelay * i;
        [button pop_addAnimation:anim forKey:nil];
        
    }
    
    // 添加标语
    UIImageView *sloganView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"app_slogan"]];
    [self.view addSubview:sloganView];
    // 标语动画
    CGFloat centerX = YGmainScreenW * 0.5;
    CGFloat centerendY = YGmainScreenH * 0.2;
    CGFloat centerbeginY = centerendY - YGmainScreenH;
    POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
    anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerbeginY)];
    anim.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerendY)];
    anim.beginTime = CACurrentMediaTime() + picArr.count * YGAnimationDelay;
    anim.springBounciness = YGSpringfactor;
    anim.springSpeed = YGSpringfactor;
    [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
        // 恢复能点击
        self.view.userInteractionEnabled = YES;
    }];
    [sloganView pop_addAnimation:anim forKey:nil];
    
    
}




@end
