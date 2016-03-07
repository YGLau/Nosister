//
//  YGPostWordViewController.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/3/6.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "YGPostWordViewController.h"
#import "YGPlaceholderView.h"
#import "YGAddTagToolbar.h"

@interface YGPostWordViewController () <UITextViewDelegate>

/**
 *  textView控件
 */
@property (weak, nonatomic) YGPlaceholderView *textView;
/**
 *  工具条
 */
@property (weak, nonatomic) YGAddTagToolbar *toolBar;

@end

@implementation YGPostWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupTextView];
    
    [self setupToolbar];
    
}
/**
 *  设置导航栏
 */
- (void)setupNav
{
    self.title = @"发表文字";
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发表" style:UIBarButtonItemStyleDone target:self action:@selector(post)];
    
    self.navigationItem.rightBarButtonItem.enabled = NO;
    [self.navigationController.navigationBar layoutIfNeeded]; // 强制刷新
}

- (void)setupTextView
{
    YGPlaceholderView *textView = [[YGPlaceholderView alloc] init];
    textView.frame = self.view.bounds;
    textView.placeholder = @"把好玩的图片、好笑的段子或糗事发到这里，接受万千网友的膜拜吧！发布违法反国家内容的，我们将依法提交给有关部门处理";
    [self.view addSubview:textView];
    textView.delegate = self;
    self.textView = textView;
    
}

- (void)setupToolbar
{
    YGAddTagToolbar *toolBar = [YGAddTagToolbar viewFromXib];
    toolBar.width = self.view.width;
    toolBar.y = self.view.height - toolBar.height;
    [self.view addSubview:toolBar];
    self.toolBar = toolBar;
    
    // 监听键盘的改变
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    // 键盘弹出后的最终的frame
    CGRect keyboardF = [notification.userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    CGFloat duration = [notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        self.toolBar.transform = CGAffineTransformMakeTranslation(0, keyboardF.origin.y - YGmainScreenH);
    }];
    
    
}

#pragma mark - 导航控制器的取消和完成方法
/**
 *  取消
 */
- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)post
{
    
}

#pragma mark - UITextViewDelegate代理方法
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
    
    
}

@end
