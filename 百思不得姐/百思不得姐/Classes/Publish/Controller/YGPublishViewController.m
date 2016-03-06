//
//  YGPublishViewController.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/2/27.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "YGPublishViewController.h"
#import "YGOtherLoginButton.h"
#import <POP.h>
#import "YGMeButton.h"

static CGFloat const YGAnimationDelay = 0.05;
static CGFloat const YGSpringfactor = 10;

@interface YGPublishViewController ()

@end

@implementation YGPublishViewController


/**
 *  取消按钮
 */
- (IBAction)close{
    [self canelWithBlock:nil];
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    // 让view不能被点击
    self.view.userInteractionEnabled = NO;
    
    NSArray *btnName = @[@"发视频", @"发图片", @"发段子", @"发声音", @"审帖", @"离线下载"];
    NSArray *picArr = @[@"publish-video", @"publish-picture", @"publish-text", @"publish-audio", @"publish-review", @"publish-offline"];
    
    CGFloat btnW= 72;
    CGFloat btnH= btnW + 30;
    // 按钮间距
    CGFloat btnmarginX =(YGmainScreenW - 3 * btnW) * 0.25;
    CGFloat btnmarginY = 10;
    
    for (NSInteger i = 0; i < btnName.count; i++) {
        YGOtherLoginButton *button = [[YGOtherLoginButton alloc] init];
        [self.view addSubview:button];
        [button setTitle:btnName[i] forState:UIControlStateNormal];
        button.tag = i;
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button setImage:[UIImage imageNamed:picArr[i]] forState:UIControlStateNormal];
        // 添加监听
        [button addTarget:self action:@selector(btnClick:) forControlEvents:UIControlEventTouchUpInside];
        // 计算行号和列号
        CGFloat row = i / 3;
        CGFloat col = i % 3;
        
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

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self canelWithBlock:nil];
}

- (void)btnClick:(YGOtherLoginButton *)button
{
    [self canelWithBlock:^{
        if (button.tag == 0) {
            YGLog(@"发视频");
        }
        
    }];
}

- (void)canelWithBlock:(void (^)())block
{
    self.view.userInteractionEnabled = NO;
    
    NSInteger beginIndex = 1;
    
    for (NSInteger i = beginIndex; i < self.view.subviews.count; i++) {
        UIView *subviews = self.view.subviews[i];
        // 标语动画
        CGFloat centerX = subviews.x;
        CGFloat centerbeginY = YGmainScreenH * 0.2;
        CGFloat centerendY = centerbeginY + YGmainScreenH;
        POPSpringAnimation *anim = [POPSpringAnimation animationWithPropertyNamed:kPOPViewCenter];
        anim.fromValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerbeginY)];
        anim.toValue = [NSValue valueWithCGPoint:CGPointMake(centerX, centerendY)];
        anim.beginTime = CACurrentMediaTime() + (i - beginIndex) * YGAnimationDelay;
        [subviews pop_addAnimation:anim forKey:nil];
        
        //监听最后一个控件的结束
        if (i == self.view.subviews.count - 1) {
            [anim setCompletionBlock:^(POPAnimation *anim, BOOL finished) {
                // 销毁控制
                [self dismissViewControllerAnimated:NO completion:nil];
                if (block == nil) return;
                block();
            }];
        }
    }
    
}
@end
