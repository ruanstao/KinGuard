//
//  MainTabBarController.m
//  KinGuard
//
//  Created by RuanSTao on 16/4/28.
//  Copyright © 2016年 RuanSTao. All rights reserved.
//

#import "MainTabBarController.h"

@interface MainTabBarController ()

@property (nonatomic,strong) UIView *touchView;

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (instancetype)creatByNib
{
    return [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"MainTabBarController"];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)setTouchEnbel:(BOOL)touchEnbel
{
    if (touchEnbel) {
        self.touchView.hidden = YES;
    }else{
        if (self.touchView == nil) {
            self.touchView = [[UIView alloc] initWithFrame:self.view.bounds];
            self.touchView.backgroundColor = [UIColor blackColor];
            self.touchView.alpha = 0.3;
            [self.touchView setTapActionWithBlock:^{
                [[NSNotificationCenter defaultCenter] postNotificationName:Show_LeftMenu object:nil];
            }];
            [self.view addSubview:self.touchView];
        }
        self.touchView.hidden = NO;
    }
}
@end
