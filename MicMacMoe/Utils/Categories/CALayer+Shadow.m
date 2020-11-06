//
//  CALayer+Shadow.m
//  MicMacMoe
//
//  Created by Poulimenos, Vasileios, Vodafone Greece on 1/11/20.
//

#import "CALayer+Shadow.h"

@implementation CALayer (Shadow)

- (void)shadowWithColor:(UIColor *)color {
    [self shadowWithColor:color opacity:0.25 x:0 y:0 radius:5];
}

- (void)shadowWithColor:(UIColor *)color opacity:(CGFloat)opacity {
    [self shadowWithColor:color opacity:opacity x:0 y:0 radius:5];
}

- (void)shadowWithColor:(UIColor *)color opacity:(CGFloat)opacity x:(CGFloat)x y:(CGFloat)y radius:(CGFloat)radius {
    NSAssert(self.masksToBounds == NO, @"masksToBounds crops shadow");
    self.shadowColor = color.CGColor;
    self.shadowOpacity = opacity;
    self.shadowOffset = CGSizeMake(x, y);
    self.shadowRadius = radius;

    self.shouldRasterize = YES;
    self.rasterizationScale = UIScreen.mainScreen.scale;
}

@end
