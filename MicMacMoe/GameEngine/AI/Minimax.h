//
//  Minimax.h
//  MicMacMoe
//
//  Created by Poulimenos, Vasileios, Vodafone Greece on 30/10/20.
//

#ifndef Minimax_h
#define Minimax_h

#import <Foundation/Foundation.h>
#import "Game.h"

NS_ASSUME_NONNULL_BEGIN

/// Adversarial search algorithms.
@interface Minimax : NSObject

/// Searches the game state to determine the best action using alpha-beta pruning.
/// @param state The current game state.
/// @param depth The maximum depth to search in the search tree.
+(id)alphabeta:(id<Game>)state depth:(int)depth;

@end

NS_ASSUME_NONNULL_END

#endif /* Minimax_h */
