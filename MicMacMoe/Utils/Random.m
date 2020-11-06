//
//  random.m
//  MicMacMoe
//
//  Created by Poulimenos, Vasileios, Vodafone Greece on 2/11/20.
//

#import <Foundation/Foundation.h>
#import "Random.h"

@implementation Random

/// Returns an `NSUInteger` in range [min, max) (upper bound in excluded).
/// @param min The minimum number.
/// @param max The maximum number.
+ (NSUInteger)integerInRangeMin:(NSInteger)min max:(NSInteger)max {
    return min + arc4random_uniform((uint32_t)(max - min));
}

@end
