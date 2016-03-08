//
//  YGAddTagViewController.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/3/8.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "YGAddTagViewController.h"

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

@end

@implementation YGAddTagViewController

- (UIButton *)txtRemindBtn
{
    if (!_txtRemindBtn) {
        UIButton *txtRemindBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        txtRemindBtn.width = self.contentView.width;
        txtRemindBtn.height = 30;
        txtRemindBtn.y = 100;
        txtRemindBtn.backgroundColor = YGRGBColor(74, 139, 209);
        [txtRemindBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [txtRemindBtn addTarget:self action:@selector(txtRemindBtnClick) forControlEvents:UIControlEventTouchUpInside];
        txtRemindBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        txtRemindBtn.contentEdgeInsets = UIEdgeInsetsMake(0, YGTopicCellMargin, 0, YGTopicCellMargin);
        [self.contentView addSubview:txtRemindBtn];
        self.txtRemindBtn = txtRemindBtn;
    }
    
    return _txtRemindBtn;
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
    contentView.x = YGTopicCellMargin;
    contentView.y = YGTitleViewY + YGTopicCellMargin;
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
        self.txtRemindBtn.y = CGRectGetMaxY(self.txtFiled.frame) + YGTopicCellMargin;
        [self.txtRemindBtn setTitle:[NSString stringWithFormat:@"添加标签：%@", self.txtFiled.text] forState:UIControlStateNormal];
        [self.contentView becomeFirstResponder];
    } else {
        self.txtRemindBtn.hidden = YES;
    }
    
}

/**
 *  标签文字的提示按钮
 */
- (void)txtRemindBtnClick
{
    
}
@end
