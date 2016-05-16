//
//  RtOutputView.h
//  KinGuard
//
//  Created by RuanSTao on 16/5/9.
//  Copyright © 2016年 RuanSTao. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSUInteger, RtOutputViewDirection) {
    kRtOutputViewDirection_Left = 1,
    kRtOutputViewDirection_Middle,
    kRtOutputViewDirection_Right
};


@interface RtCellModel : NSObject

@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *imageName;

- (instancetype)initWithTitle:(NSString *)title imageName:(NSString *)imageName;

@end

@interface RtOutputView : UIView
@property (nonatomic, copy) void(^didSelectedAtIndexPath)(NSIndexPath *indexPath);
@property (nonatomic, copy) void(^dismissWithOperation)();

//初始化方法
//传入参数：模型数组，弹出原点，宽度，高度（每个cell的高度）
- (instancetype)initWithDataArray:(NSArray *)dataArray
                           origin:(CGPoint)origin
                            width:(CGFloat)width
                           height:(CGFloat)height
                        direction:(RtOutputViewDirection)direction;

//弹出
- (void)pop;
//消失
- (void)dismiss;

@end
