//
//  YGWebViewController.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/3/5.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "YGWebViewController.h"
#import <NJKWebViewProgress.h>

@interface YGWebViewController () <UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goback;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *goforward;
/**
 *  进度条
 */
@property (strong, nonatomic) NJKWebViewProgress *progress;
@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@end

@implementation YGWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.progress = [[NJKWebViewProgress alloc] init];
    
    self.webView.delegate = self.progress;
    __weak typeof (self) weakself = self;
    self.progress.progressBlock = ^(float progress) {
        weakself.progressView.progress = progress;
        weakself.progressView.hidden = (progress == 1.0);
    };
    
    self.progress.webViewProxyDelegate = self;
    
    [self.webView loadRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:self.url]]];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
/**
 *  刷新
 */
- (IBAction)refresh:(id)sender {
    [self.webView reload];
}
/**
 *  返回
 */
- (IBAction)goback:(id)sender {
    [self.webView goBack];
}
/**
 *  前进
 */
- (IBAction)goforward:(id)sender {
    [self.webView goForward];
}

#pragma mark - UIWebViewDelegate代理方法
- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    self.goback.enabled = webView.canGoBack;
    self.goforward.enabled = webView.canGoForward;
}
@end
