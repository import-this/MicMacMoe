//
//  CALayer+Border.h
//  MicMacMoe
//
//  Created by Poulimenos, Vasileios, Vodafone Greece on 1/11/20.
//

#import <QuartzCore/QuartzCore.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface CALayer (Border)

- (void)borderWithColor:(UIColor *)color width:(CGFloat)width;

@end

NS_ASSUME_NONNULL_END
