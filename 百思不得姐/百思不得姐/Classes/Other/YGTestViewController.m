//
//  YGTestViewController.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/2/15.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "YGTestViewController.h"

@interface YGTestViewController ()

@end

@implementation YGTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor greenColor];
}



- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    YGTestViewController *vc = [[YGTestViewController alloc] init];
    vc.view.backgroundColor = [UIColor redColor];
    [self.navigationController pushViewController:vc animated:YES];
}

@end
