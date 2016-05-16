//
//  MemberListViewController.m
//  KinGuard
//
//  Created by Rainer on 16/5/11.
//  Copyright © 2016年 RuanSTao. All rights reserved.
//

#import "MemberListViewController.h"

@interface MemberListViewController ()

@end

@implementation MemberListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"监护成员";
    UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"topbtn_back"] style:UIBarButtonItemStylePlain target:self action:@selector(back)];
    self. navigationItem.leftBarButtonItem = leftItem;
}

- (void)back
{
    [self.navigationController popViewControllerAnimated:YES];
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
