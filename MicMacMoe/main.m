//
//  main.m
//  MicMacMoe
//
//  Created by Poulimenos, Vasileios, Vodafone Greece on 29/10/20.
//  Copyright © 2020 Poulimenos, Vasileios, Vodafone Greece. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}