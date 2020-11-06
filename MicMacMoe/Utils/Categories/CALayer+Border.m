//
//  CALayer+Border.m
//  MicMacMoe
//
//  Created by Poulimenos, Vasileios, Vodafone Greece on 1/11/20.
//

#import "CALayer+Border.h"

@implementation CALayer (Border)

- (void)borderWithColor:(UIColor *)color width:(CGFloat)width {
    self.borderColor = color.CGColor;
    self.borderWidth = width;
}

@end
