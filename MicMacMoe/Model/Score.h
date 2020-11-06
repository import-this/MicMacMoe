//
//  Score.h
//  MicMacMoe
//
//  Created by Poulimenos, Vasileios, Vodafone Greece on 4/11/20.
//

#ifndef Score_h
#define Score_h

@interface Score : NSObject

@property (nonatomic, assign, readonly) int x;
@property (nonatomic, assign, readonly) int o;

- (void)incX;
- (void)incO;

@end

#endif /* Score_h */
