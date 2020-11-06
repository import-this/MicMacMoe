//
//  Score.m
//  MicMacMoe
//
//  Created by Poulimenos, Vasileios, Vodafone Greece on 31/10/20.
//

#import <Foundation/Foundation.h>
#import "Score.h"

@interface Score ()

@property (nonatomic, assign, readwrite) int x;
@property (nonatomic, assign, readwrite) int o;

@end

@implementation Score

- (void)incX {
    ++self.x;
}

- (void)incO {
    ++self.o;
}

@end
