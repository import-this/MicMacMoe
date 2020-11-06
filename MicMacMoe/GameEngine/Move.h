//
//  Move.h
//  MicMacMoe
//
//  Created by Poulimenos, Vasileios, Vodafone Greece on 31/10/20.
//

#ifndef Move_h
#define Move_h

NS_ASSUME_NONNULL_BEGIN

@interface Move : NSObject

@property (nonatomic, assign, readonly) NSInteger i;
@property (nonatomic, assign, readonly) NSInteger j;

- (instancetype)initWithI:(NSInteger)i j:(NSInteger)j;

+ (instancetype)i:(NSInteger)i j:(NSInteger)j;

@end

NS_ASSUME_NONNULL_END

#endif /* Move_h */
