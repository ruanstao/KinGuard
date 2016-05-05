//
//  ViewController.m
//  KinGuard
//
//  Created by RuanSTao on 16/4/27.
//  Copyright © 2016年 RuanSTao. All rights reserved.
//

#import "ViewController.h"
#import "MainTabBarController.h"
#import "LeftViewController.h"

@interface ViewController ()

@property (nonatomic,strong)MainTabBarController *mainTabBarController;

// 主界面点击手势，用于在菜单划出状态下点击主页后自动关闭菜单
@property (nonatomic,strong)UIPanGestureRecognizer *tapGesture;

@property (nonatomic,strong)LeftViewController *leftViewController;

@property (nonatomic,strong) UIView *mainView;
@property (nonatomic,strong) UIView *blackCover; // 侧滑菜单黑色半透明遮罩层
// 侧滑所需参数
@property (nonatomic,assign) CGFloat distance;
@property (nonatomic,assign) CGFloat fullDistance;
@property (nonatomic,assign) CGFloat proportion;
@property (nonatomic,assign) CGPoint centerOfLeftViewAtBeginning;
@property (nonatomic,assign) CGFloat proportionOfLeftView;
@property (nonatomic,assign) CGFloat distanceOfLeftView;

@property (nonatomic,assign) BOOL isOpen;

@end

@implementation ViewController

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:Show_LeftMenu object:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self setLeftAnimation];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openAction) name:Show_LeftMenu object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(showHome) name:Show_MainView object:nil];

}


- (void)setLeftAnimation{
    self.distance = 0;
    self.fullDistance = 0.78;
    self.proportion = 0.77;
    self.centerOfLeftViewAtBeginning = CGPointZero;
    self.proportionOfLeftView = 1;
    self.distanceOfLeftView = 0;

    // 通过 StoryBoard 取出左侧侧滑菜单视图
    self.leftViewController = [LeftViewController creatByNib];

    self.leftViewController.view.center = CGPointMake(self.leftViewController.view.center.x , self.leftViewController.view.center.y);
    self.leftViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, 0.8, 0.8);
    //
    // 动画参数初始化
    self.centerOfLeftViewAtBeginning = self.leftViewController.view.center;
    // 把侧滑菜单视图加入根容器
    [self.view addSubview:self.leftViewController.view];

    // 在侧滑菜单之上增加黑色遮罩层，目的是实现视差特效
    self.blackCover = [[UIView alloc] initWithFrame:CGRectOffset(self.view.frame, 0, 0)];//UIView(frame: CGRectOffset(self.view.frame, 0, 0))
    self.blackCover.backgroundColor = [UIColor blackColor];
    [self.view addSubview:self.blackCover];

    // 初始化主视图，即包含 TabBar、NavigationBar和首页的总视图
    self.mainView = [[UIView alloc] initWithFrame:self.view.frame];
    // 初始化 TabBar
    self.mainTabBarController = [MainTabBarController creatByNib];
    // 取出 TabBar Controller 的视图加入主视图
    //    let tabBarView = mainTabBarController.view
    [self.mainView addSubview:self.mainTabBarController.view];

    // 生成单击收起菜单手势
    self.tapGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pan:)];
    [self.mainView addGestureRecognizer:self.tapGesture];
    // 将主视图加入容器
    [self.view addSubview:self.mainView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 响应 UIPanGestureRecognizer 事件
- (void)pan:(UIPanGestureRecognizer *)recongnizer
{

    CGFloat x = [recongnizer translationInView:self.view].x;

    CGFloat trueDistance = _distance + x;
    CGFloat trueProportion = trueDistance / (mScreenWidth * self.fullDistance);
    // 如果 UIPanGestureRecognizer 结束，则激活自动停靠
    if (recongnizer.state == UIGestureRecognizerStateEnded) {
        
        if (trueDistance > mScreenWidth * (self.proportion / 3)) {
            [self showLeft];
//        } else if (trueDistance < mScreenWidth * -(self.proportion / 3)) {
//            [self showRight];
        } else {
            [self showHome];
        }
        return;
    }
    if (trueDistance < 0) {
        return;
    }
    // 计算缩放比例
    CGFloat proportion = recongnizer.view.frame.origin.x >= 0?-1:1;
    proportion *= trueDistance / mScreenWidth;
    proportion *= 1 - self.proportion;
    proportion /= self.fullDistance + self.proportion/2 - 0.5;
    proportion += 1;
    if (proportion <= self.proportion ){ // 若比例已经达到最小，则不再继续动画
        return;
    }
    // 执行视差特效
    self.blackCover.alpha = (proportion - self.proportion) / (1 - self.proportion);
    // 执行平移和缩放动画
    recongnizer.view.center = CGPointMake(self.view.center.x + trueDistance, self.view.center.y);
    recongnizer.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, proportion, proportion);
    
    // 执行左视图动画
    CGFloat pro = 0.8 + (self.proportionOfLeftView - 0.8) * trueProportion;
    self.leftViewController.view.center = CGPointMake(self.centerOfLeftViewAtBeginning.x + self.distanceOfLeftView * trueProportion, self.centerOfLeftViewAtBeginning.y - (self.proportionOfLeftView - 1) * self.leftViewController.view.frame.size.height * trueProportion / 2 );
    self.leftViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, pro, pro);
}

// 封装三个方法，便于后期调用

- (void)openAction
{
    if (self.isOpen) {
        [self showHome];
    }else{
        [self showLeft];
    }
}
// 展示左视图
- (void)showLeft {
    // 给首页 加入 点击自动关闭侧滑菜单功能
    [self.mainView addGestureRecognizer:self.tapGesture];
    // 计算距离，执行菜单自动滑动动画
    self.distance = self.view.center.x * (self.fullDistance*2 + self.proportion - 1);
    [self doTheAnimateWithProportion:self.proportion andshowWhat:@"left"];
    self.isOpen = YES;
//    homeNavigationController.popToRootViewControllerAnimated(true)
}
// 展示主视图
- (void) showHome {
    // 从首页 删除 点击自动关闭侧滑菜单功能
    [self.mainView addGestureRecognizer:self.tapGesture];
    // 计算距离，执行菜单自动滑动动画
    self.distance = 0;
    [self doTheAnimateWithProportion:1 andshowWhat:@"home"];
    self.isOpen = NO;
}
// 展示右视图
- (void)showRight {
    // 给首页 加入 点击自动关闭侧滑菜单功能
    [self.mainView addGestureRecognizer:self.tapGesture];
    // 计算距离，执行菜单自动滑动动画
    self.distance = self.view.center.x * -(self.fullDistance*2 + self.proportion - 1);
    [self doTheAnimateWithProportion:self.proportion andshowWhat:@"right"];
}

// 执行三种动画：显示左侧菜单、显示主页、显示右侧菜单
-(void)doTheAnimateWithProportion:(CGFloat)proportion andshowWhat:(NSString *)showWhat {


    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        self.mainView.center = CGPointMake(self.view.center.x + self.distance, self.view.center.y);
        // 缩放首页
        self.mainView.transform = CGAffineTransformScale(CGAffineTransformIdentity, proportion, proportion);
        self.blackCover.alpha = ([showWhat isEqualToString: @"home"]) ? 1 : 0;
        
        if ([showWhat isEqualToString: @"left"]) {
            // 移动左侧菜单的中心
            self.leftViewController.view.center = CGPointMake(self.centerOfLeftViewAtBeginning.x + self.distanceOfLeftView, self.leftViewController.view.center.y);
            // 缩放左侧菜单
            self.leftViewController.view.transform = CGAffineTransformScale(CGAffineTransformIdentity, self.proportionOfLeftView, self.proportionOfLeftView);
        }

    } completion:^(BOOL finished) {
        // 改变黑色遮罩层的透明度，实现视差效果
//        self.blackCover.alpha = ([showWhat isEqualToString: @"home"]) ? 1 : 0;

//        self.leftViewController.view.alpha = ([showWhat isEqualToString: @"right" ])? 0 : 1;
    }];
}


@end
