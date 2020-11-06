//
//  CALayer+Shadow.h
//  MicMacMoe
//
//  Created by Poulimenos, Vasileios, Vodafone Greece on 1/11/20.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CALayer (Shadow)

- (void)shadowWithColor:(UIColor *)color;
- (void)shadowWithColor:(UIColor *)color opacity:(CGFloat)opacity;
- (void)shadowWithColor:(UIColor *)color opacity:(CGFloat)opacity x:(CGFloat)x y:(CGFloat)y radius:(CGFloat)radius;

@end

NS_ASSUME_NONNULL_END
