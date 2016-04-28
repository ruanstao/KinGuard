//
//  UIImageEffects.h
//  BlurEffect
//
//  Created by RuanSTao on 15/7/29.
//  Copyright (c) 2015年 JJS-iMac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIImageEffects : NSObject

/**
 *  截图
 *
 *  @param rect 截图范围
 *
 *  @return 截图图片
 */
+ (UIImage *)captureWithFrame:(CGRect)rect;

/**
 *  对传入图片做毛玻璃效果
 *
 *  @param inputImage 正常图片
 *
 *  @return 毛玻璃效果图片
 */
+ (UIImage*)imageByApplyingLightEffectToImage:(UIImage*)inputImage;
+ (UIImage*)imageByApplyingExtraLightEffectToImage:(UIImage*)inputImage;
+ (UIImage*)imageByApplyingDarkEffectToImage:(UIImage*)inputImage;
+ (UIImage*)imageByApplyingTintEffectWithColor:(UIColor *)tintColor toImage:(UIImage*)inputImage;

/**
 *  对当前所显示内容做毛玻璃效果
 *
 *  @return 毛玻璃效果图片
 */
+ (UIImage*)currentImageByApplyingLightEffectToImage;
+ (UIImage*)currentImageByApplyingExtraLightEffectToImage;
+ (UIImage*)currentImageByApplyingDarkEffectToImage;
+ (UIImage*)currentImageByApplyingTintEffectWithColor:(UIColor *)tintColor;


//| ----------------------------------------------------------------------------
//! Applies a blur, tint color, and saturation adjustment to @a inputImage,
//! optionally within the area specified by @a maskImage.
//!
//! @param  inputImage
//!         The source image.  A modified copy of this image will be returned.
//! @param  blurRadius
//!         The radius of the blur in points.
//! @param  tintColor
//!         An optional UIColor object that is uniformly blended with the
//!         result of the blur and saturation operations.  The alpha channel
//!         of this color determines how strong the tint is.
//! @param  saturationDeltaFactor
//!         A value of 1.0 produces no change in the resulting image.  Values
//!         less than 1.0 will desaturation the resulting image while values
//!         greater than 1.0 will have the opposite effect.
//! @param  maskImage
//!         If specified, @a inputImage is only modified in the area(s) defined
//!         by this mask.  This must be an image mask or it must meet the
//!         requirements of the mask parameter of CGContextClipToMask.
+ (UIImage*)imageByApplyingBlurToImage:(UIImage*)inputImage withRadius:(CGFloat)blurRadius tintColor:(UIColor *)tintColor saturationDeltaFactor:(CGFloat)saturationDeltaFactor maskImage:(UIImage *)maskImage;

@end
