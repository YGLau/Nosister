//
//  YGAddTagViewController.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/3/8.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "YGAddTagViewController.h"
#import "YGTagButton.h"

@interface YGAddTagViewController ()

@property (weak, nonatomic) UIView *contentView;
/**
 *  文本输入框
 */
@property (weak, nonatomic) UITextField *txtFiled;
/**
 *  文字提示按钮
 */
@property (weak, nonatomic) UIButton *txtRemindBtn;

@property (strong, nonatomic) NSMutableArray *tagBtnArr;

@end

@implementation YGAddTagViewController

#pragma mark - 懒加载

- (UIButton *)txtRemindBtn
{
    if (!_txtRemindBtn) {
        UIButton *txtRemindBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        txtRemindBtn.layer.cornerRadius = 5;
        txtRemindBtn.layer.masksToBounds = YES;
        txtRemindBtn.width = self.contentView.width;
        txtRemindBtn.height = 30;
        txtRemindBtn.y = 100;
        txtRemindBtn.backgroundColor = YGTagBg;
        [txtRemindBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [txtRemindBtn addTarget:self action:@selector(txtRemindBtnClick) forControlEvents:UIControlEventTouchUpInside];
        txtRemindBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        txtRemindBtn.contentEdgeInsets = UIEdgeInsetsMake(0, YGTagMargin, 0, YGTagMargin);
        [self.contentView addSubview:txtRemindBtn];
        self.txtRemindBtn = txtRemindBtn;
    }
    
    return _txtRemindBtn;
}

- (NSMutableArray *)tagBtnArr
{
    if (!_tagBtnArr) {
        _tagBtnArr = [NSMutableArray array];
    }
    
    return _tagBtnArr;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // 设置导航属性
    [self setupNav];
    // 设置中间的容器
    [self setupContentView];
    // 设置输入框
    [self setupTextFiled];
    
    
    
}

- (void)setupContentView
{
    UIView *contentView = [[UIView alloc] init];
    contentView.x = YGTagMargin;
    contentView.y = YGTitleViewY + YGTagMargin;
    contentView.width = YGmainScreenW - 2 * contentView.x;
    contentView.height = 200;
    [self.view addSubview:contentView];
    self.contentView = contentView;
    
}
- (void)setupNav
{
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"添加标签";
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
}

- (void)setupTextFiled
{
    UITextField *txtFiled = [[UITextField alloc] init];
    txtFiled.width = self.contentView.width;
    txtFiled.height = 25;
    txtFiled.placeholder = @"多个标签逗号或回车分隔";
    txtFiled.font = [UIFont systemFontOfSize:15];
    [txtFiled addTarget:self action:@selector(textDidChange) forControlEvents:UIControlEventEditingChanged];
    [self.contentView addSubview:txtFiled];
    self.txtFiled = txtFiled;
    [txtFiled becomeFirstResponder];
}

- (void)done
{
    
}
/**
 *  监听textFiled的文字改变
 */
- (void)textDidChange
{
    if (self.txtFiled.hasText) {
        self.txtRemindBtn.hidden = NO;
        self.txtRemindBtn.titleLabel.text = self.txtFiled.text;
        self.txtRemindBtn.y = CGRectGetMaxY(self.txtFiled.frame) + YGTagMargin;
        [self.txtRemindBtn setTitle:[NSString stringWithFormat:@"添加标签：%@", self.txtFiled.text] forState:UIControlStateNormal];
        
    } else {
        self.txtRemindBtn.hidden = YES;
    }
    
    // 更新frame
    [self updateTagBtnFrame];
}

/**
 *  标签文字的提示按钮
 */
- (void)txtRemindBtnClick
{
    // 1.添加标签按钮
    YGTagButton *tagBtn = [YGTagButton buttonWithType:UIButtonTypeCustom];
    [tagBtn setTitle:self.txtFiled.text forState:UIControlStateNormal];
    [tagBtn addTarget:self action:@selector(tagBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    tagBtn.height = 25;
    [self.contentView addSubview:tagBtn];
    [self.tagBtnArr addObject:tagBtn];
    
    // 更新按钮的frame
    [self updateTagBtnFrame];
    // 2.清空文字
    self.txtFiled.text = nil;
    // 隐藏添加按钮
    self.txtRemindBtn.hidden = YES;
}

- (void)tagBtnClick:(YGTagButton *)button
{
    // 删除按钮
    [button removeFromSuperview];
    
    // 从数组中移除
    [self.tagBtnArr removeObject:button];
    [UIView animateWithDuration:0.25 animations:^{
        // 更新frame
        [self updateTagBtnFrame];
    }];
    
}
/**
 *  用来更新按钮的frame
 */
- (void)updateTagBtnFrame
{
    // 更新标签按钮的frame
    for (int i = 0; i < self.tagBtnArr.count; i++) {
        YGTagButton *tagBtn = self.tagBtnArr[i];
        if (i == 0) { // 第一个按钮
            tagBtn.x = 0;
            tagBtn.y = 0;
        } else { // 其他按钮
            UIButton *lastTagBtn = self.tagBtnArr[i - 1];
            CGFloat leftMargin = self.contentView.width - CGRectGetMaxX(lastTagBtn.frame) - YGTagMargin;
            if (leftMargin >= tagBtn.width) { //当前行
                tagBtn.x = CGRectGetMaxX(lastTagBtn.frame) + YGTagMargin;
                tagBtn.y = lastTagBtn.y;
            } else { // 下一行
                tagBtn.x = 0;
                tagBtn.y = CGRectGetMaxY(lastTagBtn.frame) + YGTagMargin;
            }
        }
    }
    
    // 更新textFiled的frame
    YGTagButton *lastBtn = [self.tagBtnArr lastObject];
    CGFloat leftMargin = self.contentView.width - CGRectGetMaxX(lastBtn.frame) - YGTagMargin;
    if (leftMargin >= [self textFiledWidth]) { // 一行够显示
        self.txtFiled.x = CGRectGetMaxX(lastBtn.frame) + YGTagMargin;
        self.txtFiled.y = lastBtn.y;
    } else { // 一行不够显示
        self.txtFiled.x = 0;
        self.txtFiled.y = CGRectGetMaxY(lastBtn.frame) + YGTagMargin;
    }
}
/**
 *  根据文字计算textFiled输入框的宽度
 */
- (CGFloat)textFiledWidth
{
    CGFloat text = [self.txtFiled.text sizeWithAttributes:@{NSFontAttributeName : self.txtFiled.font}].width;
    
    return MAX(100, text);
}
@end
