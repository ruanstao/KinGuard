//
//  DeviceInfoView.m
//  KinGuard
//
//  Created by RuanSTao on 16/5/11.
//  Copyright © 2016年 RuanSTao. All rights reserved.
//

#import "DeviceInfoView.h"

@interface DeviceInfoView()

@property (strong, nonatomic) IBOutlet UILabel *time;

@property (strong, nonatomic) IBOutlet UILabel *accuracy;//精度

@property (strong, nonatomic) IBOutlet UILabel *address;
@property (strong, nonatomic) IBOutlet UILabel *power;
@property (strong, nonatomic) IBOutlet UIImageView *powerImage;

@end

@implementation DeviceInfoView

+ (instancetype)creatByNib
{
    NSArray * nib = [[NSBundle mainBundle]loadNibNamed:@"DeviceInfoView" owner:self options:nil] ;
    return [nib lastObject];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)initWithLocationModel:(LocationInfo *)info{
    self.power.text =[NSString stringWithFormat:@"%@", @(info.battery)];;
    self.time.text = [JJSUtil timeDateFormatter:[NSDate dateWithTimeIntervalSince1970:info.timestamp] type:10];
    self.accuracy.text = [NSString stringWithFormat:@"%@",@(info.range)];
    self.address.text = [NSString stringWithFormat:@"%@",info.addr];
    
}
@end
