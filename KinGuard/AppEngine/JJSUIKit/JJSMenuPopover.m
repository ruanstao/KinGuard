//
//  JJSMenuPopover.m
//  JJSMenuPopover
//
//  Created by 邱弘宇 on 16/1/15.
//  Copyright © 2016年 JJS. All rights reserved.
//
#define Row_Width 50
#define Row_Height 30
#define Arrow_Aspect 5
#define Line_Width 8.5
#define Arrow_Width 10
#define Arrow_Height 5
#define KScr_W [UIScreen mainScreen].bounds.size.width
#define KScr_H [UIScreen mainScreen].bounds.size.height
#define LineColor [UIColor colorWithWhite:0.25 alpha:1]
#define ItemBackgroundColor [UIColor colorWithRed:0.3451 green:0.6588 blue:0.9725 alpha:0.95]
#define BackgroundColor [UIColor colorWithWhite:0.25 alpha:0.5]
#define CellId @"JJSMenuCollectionCell"
#import "JJSMenuPopover.h"
//MARK:JJSMenuCollectionView
typedef NS_ENUM(NSUInteger,JJSMenuArrowDirection){
    JJSMenuArrowDirectionLeft,//箭头在左
    JJSMenuArrowDirectionRight,//箭头在右
    JJSMenuArrowDirectionUp,//箭头在上
    JJSMenuArrowDirectionDown//箭头在下
};
@interface JJSMenuPopoverBackView : UIView
@property(assign, nonatomic)JJSMenuArrowDirection direction;
@end
@implementation JJSMenuPopoverBackView

- (void)drawRect:(CGRect)rect{
    self.layer.backgroundColor = [UIColor clearColor].CGColor;
    CGFloat width = rect.size.width;
    CGFloat height = rect.size.height;
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetLineWidth(context, Line_Width);
    CGMutablePathRef path = CGPathCreateMutable();
    CGAffineTransform transform = CGAffineTransformMakeTranslation(0, 0);
    switch (_direction) {
        case JJSMenuArrowDirectionLeft:
        {//left
            CGPathMoveToPoint(path, &transform,-Arrow_Width, height/2);
            CGPathAddLineToPoint(path, &transform, 0, height/2 - Arrow_Height);
            CGPathAddLineToPoint(path, &transform, 0, 0);
            CGPathAddLineToPoint(path, &transform, width, 0);
            CGPathAddLineToPoint(path, &transform, width, height);
            CGPathAddLineToPoint(path, &transform, 0, height);
            CGPathAddLineToPoint(path, &transform, 0, height/2 + Arrow_Height);
            CGPathCloseSubpath(path);

        }
            break;
        case JJSMenuArrowDirectionRight:
        {//right
            CGPathMoveToPoint(path, &transform,width + Arrow_Width, height/2);
            CGPathAddLineToPoint(path, &transform, width, height/2 - Arrow_Height);
            CGPathAddLineToPoint(path, &transform, width, 0);
            CGPathAddLineToPoint(path, &transform, 0, 0);
            CGPathAddLineToPoint(path, &transform, 0, height);
            CGPathAddLineToPoint(path, &transform, width, height);
            CGPathAddLineToPoint(path, &transform, width, height/2 + Arrow_Height);
            CGPathCloseSubpath(path);

        }
            break;
        case JJSMenuArrowDirectionUp:
        {//up
            CGPathMoveToPoint(path, &transform,width/2, height + Arrow_Height);
            CGPathAddLineToPoint(path, &transform, width/2 - Arrow_Width, height);
            CGPathAddLineToPoint(path, &transform, 0, height);
            CGPathAddLineToPoint(path, &transform, 0, 0);
            CGPathAddLineToPoint(path, &transform, width, 0);
            CGPathAddLineToPoint(path, &transform, width, height);
            CGPathAddLineToPoint(path, &transform, width/2 + Arrow_Width, height);
            CGPathCloseSubpath(path);
        }
            break;
        default:{//down
        }
            break;
    }
    [LineColor setStroke];
    [BackgroundColor setFill];
    CGContextAddPath(context, path);
    CGContextDrawPath(context,kCGPathFillStroke);
    CGPathRelease(path);
}
@end
//MARK:JJSMenuCollectionCell
@interface JJSMenuCollectionCell : UICollectionViewCell
@property (strong, nonatomic)UIButton * title;
@end
@implementation JJSMenuCollectionCell
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        _title = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        _title.userInteractionEnabled = YES;
        [_title setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        _title.backgroundColor = ItemBackgroundColor;
        _title.titleLabel.font = [UIFont systemFontOfSize:14];
        [self.contentView addSubview:_title];
    }
    return self;
}
@end
//MARK:JJSMenuCollectionLayout
@interface JJSMenuCollectionLayout : UICollectionViewFlowLayout
@end
@implementation JJSMenuCollectionLayout
- (void)prepareLayout{
    [super prepareLayout];
    self.minimumLineSpacing = 0;
    self.minimumInteritemSpacing = 0;
    self.itemSize = CGSizeMake(Row_Width, Row_Height);
}
@end
//MARK:JJSMenuPopover
@interface JJSMenuPopover()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(strong, nonatomic)JJSMenuPopoverBackView *popView;
@property(assign, nonatomic)JJSMenuArrowDirection popDirection;
@property(strong, nonatomic)UICollectionView *collectionView;
@property(strong, nonatomic)NSMutableArray<NSString *> *items;
@end
@implementation JJSMenuPopover
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(dismissMenuPopover)];
        [self addGestureRecognizer:tap];
        self.items = [NSMutableArray array];
    }
    return self;
}
- (void)dismissMenuPopover{
    [self removeFromSuperview];
}
+ (instancetype)showFromView:(nonnull UIView *)view direction:(JJSMenuPopoverDirection)direction menuItems:(nonnull NSArray<NSString *> *)menuItems withCallBack:(JJSMenuPopoverCallback)callback{
    JJSMenuPopover *menu = [[JJSMenuPopover alloc]initWithFrame:CGRectMake(0, 0,KScr_W, KScr_H)];
    [menu showFromView:view direction:direction menuItems:menuItems];
    if (callback != _JJSMenuPopOverCallback && callback != nil) {
        _JJSMenuPopOverCallback = callback;
    }
    return menu;
}
- (void)showFromView:(nonnull UIView *)view direction:(JJSMenuPopoverDirection)direction menuItems:(nonnull NSArray<NSString *> *)menuItems{
    [self removeFromSuperview];
    _JJSMenuPopOverCallback = nil;
    
    [self.items addObjectsFromArray:menuItems];
    
    //pop frame
    CGRect newFrame = [self calculateFrame:view direction:direction];
    
    //pop
    self.popView = [[JJSMenuPopoverBackView alloc]initWithFrame:newFrame];
    self.popView.direction = self.popDirection;
    [self addSubview:self.popView];
    
    //Collection View
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
    layout.minimumInteritemSpacing = 0;
    layout.minimumLineSpacing = 0;
    layout.itemSize = CGSizeMake(Row_Width, Row_Height);
    if (direction == JJSMenuPopoverDirectionVertical) {
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    }
    else{
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    }
    self.collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(Arrow_Aspect, Arrow_Aspect, newFrame.size.width - Arrow_Aspect * 2, newFrame.size.height - Arrow_Aspect * 2) collectionViewLayout:layout];
    [self.collectionView registerClass:NSClassFromString(CellId) forCellWithReuseIdentifier:CellId];
    [self.popView addSubview:self.collectionView];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor clearColor];
    
    //pop animation
    self.collectionView.alpha = 0.2;
    [UIView animateWithDuration:.4 animations:^{
        self.collectionView.alpha = 0.95;
    } completion:nil];
    //show
    for (UIWindow *window in [UIApplication sharedApplication].windows) {
        if (window.windowLevel == UIWindowLevelNormal) {
            [window addSubview:self];
        }
    }
}
/**
 计算坐标
 */
- (CGRect)calculateFrame:(UIView *)view direction:(JJSMenuPopoverDirection)direction{
    CGRect newFrame;
    //坐标
    CGPoint viewRelativityPoint;
    viewRelativityPoint = [view convertPoint:CGPointZero toView:[UIApplication sharedApplication].keyWindow];
        //定义弹出视图
    if (direction == JJSMenuPopoverDirectionVertical) {//竖直
        newFrame.size.height = _items.count * Row_Height + Arrow_Aspect * 2;
        newFrame.size.width = Row_Width + Arrow_Aspect*2 + 2;
        newFrame.origin.x = viewRelativityPoint.x + view.frame.size.width /2 - newFrame.size.width/2;
        if (viewRelativityPoint.y < KScr_H /2) {//竖直向下 箭头向上
            self.popDirection = JJSMenuArrowDirectionUp;
            newFrame.origin.y = viewRelativityPoint.y + view.frame.size.height;
        }
        else{//竖直向上 箭头向下
            self.popDirection = JJSMenuArrowDirectionDown;
            newFrame.origin.y = viewRelativityPoint.y - newFrame.size.height;
        }
    }
    else{//水平
        newFrame.size.width = _items.count * Row_Width + Arrow_Aspect + 5;
        newFrame.size.height = Row_Height + Arrow_Aspect;
        newFrame.origin.y = viewRelativityPoint.y + view.frame.size.height / 2 - newFrame.size.height/2;
        if (viewRelativityPoint.x > KScr_W/2) {//水平向左 箭头向右
            self.popDirection = JJSMenuArrowDirectionRight;
            newFrame.origin.x = viewRelativityPoint.x - newFrame.size.width;
        }
        else{//水平向右 箭头向左
            self.popDirection = JJSMenuArrowDirectionLeft;
            newFrame.origin.x = viewRelativityPoint.x + view.frame.size.width;
        }

    }
    return newFrame;
}
//MARK:CollectionView DataSouce
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.items.count;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    JJSMenuCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:CellId forIndexPath:indexPath];
    [cell.title setTitle:_items[indexPath.row] forState:UIControlStateNormal];
    cell.title.tag = indexPath.row;
    [cell.title addTarget:self action:@selector(didSeletedTitle:) forControlEvents:UIControlEventTouchUpInside];
    return cell;
}
- (void)didSeletedTitle:(UIButton *)sender{
    [self dismissMenuPopover];
    if (_JJSMenuPopOverCallback != nil) {
        _JJSMenuPopOverCallback(sender.tag);
    }
}
//MARK:CollectionView Delegate
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
}
@end




