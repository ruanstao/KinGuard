//
//  LeftViewController.m
//  KinGuard
//
//  Created by RuanSTao on 16/4/28.
//  Copyright © 2016年 RuanSTao. All rights reserved.
//

#import "LeftViewController.h"
#import "LeftTableViewCell.h"
#import "UserInfoModel.h"

@interface LeftViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic,strong) NSMutableArray *tableViewContent;

@property (nonatomic,strong) UserInfoModel *userModel;

@end

@implementation LeftViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initTableViewContent];
    [self requestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (instancetype)creatByNib
{
    return [[UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]] instantiateViewControllerWithIdentifier:@"LeftViewController"];
}

- (void)requestData
{
    [[KinGuartApi sharedKinGuard] getUserInfoSuccess:^(NSDictionary *data) {
        NSLog(@"success:%@",data);
        if (data) {
            self.userModel = [UserInfoModel mj_objectWithKeyValues:data];
            [self.tableView reloadData];
        }
    } fail:^(NSString *error) {
        NSLog(@"error :%@",error);
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)initTableViewContent
{
    self.tableViewContent = [NSMutableArray array];
    NSMutableArray *array = [NSMutableArray array];
    [array addObject:@(LeftType_JianKongLog)];
    [array addObject:@(LeftType_JianKongMember)];
    [array addObject:@(LeftType_AddDevice)];
    [array addObject:@(LeftType_Setting)];
    [array addObject:@(LeftType_Login)];

    [self.tableViewContent addObject:array];

}
#pragma mark - <UITableViewDelegate,UITableViewDataSource>

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if (section ==0) {
        return 0;
    }
    return 15;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *clearView = [[UIView alloc] init];
    clearView.backgroundColor = [UIColor clearColor];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, -0.5, CGRectGetWidth(tableView.frame), 0.5)];
    view.backgroundColor = HexRGB(0xB7B7B7);
    [clearView addSubview:view];
    return clearView;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    [JJSUtil setExtraCellLineHidden:tableView];
    return self.tableViewContent.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [[self.tableViewContent objectAtIndex:section] count];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LeftType type = [[[self.tableViewContent objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] integerValue];
        LeftTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"LeftTableViewCell"];
    switch (type) {
        case LeftType_JianKongLog:{
            cell.title.text = @"监控日志";
        }
            break;
        case LeftType_JianKongMember:{
            cell.title.text = @"监控成员";

        }
            break;
        case LeftType_AddDevice:{

            cell.title.text = @"增加成员";
        }
            break;
        case LeftType_Setting:{
            cell.title.text = @"设置";
        }
            break;
        case LeftType_Login:{
            cell.title.text = @"登入";
        }
            break;
        default:
            break;
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LeftType type = [[[self.tableViewContent objectAtIndex:indexPath.section] objectAtIndex:indexPath.row] integerValue];

    switch (type) {
        case LeftType_JianKongLog:{
        }
            break;
        case LeftType_JianKongMember:{

        }
            break;
        case LeftType_AddDevice:{
        }
            break;
        case LeftType_Setting:{

        }
            break;
        case LeftType_Login:{

        }
            break;
        default:
            break;
    }
}

@end
