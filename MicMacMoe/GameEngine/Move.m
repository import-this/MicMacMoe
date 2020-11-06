//
//  Move.m
//  MicMacMoe
//
//  Created by Poulimenos, Vasileios, Vodafone Greece on 31/10/20.
//

#import <Foundation/Foundation.h>
#import "Move.h"

@implementation Move

- (instancetype)initWithI:(NSInteger)i j:(NSInteger)j {
    if (self = [super init]) {
        _i = i;
        _j = j;
    }
    return self;
}

+ (instancetype)i:(NSInteger)i j:(NSInteger)j {
    return [[Move alloc] initWithI:i j:j];
}

@end
