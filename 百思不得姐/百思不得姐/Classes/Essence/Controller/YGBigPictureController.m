//
//  YGBigPictureController.m
//  百思不得姐
//
//  Created by 刘勇刚 on 16/2/28.
//  Copyright © 2016年 liu. All rights reserved.
//

#import "YGBigPictureController.h"

@interface YGBigPictureController ()

@end

@implementation YGBigPictureController
/**
 *  关闭
 */
- (IBAction)close:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
