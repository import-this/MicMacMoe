//
//  TicTacToe.h
//  MicMacMoe
//
//  Created by Poulimenos, Vasileios, Vodafone Greece on 30/10/20.
//

#ifndef TicTacToe_h
#define TicTacToe_h

#import <Foundation/Foundation.h>
#import "Game.h"
#import "Player.h"
#import "Move.h"

NS_ASSUME_NONNULL_BEGIN

// Protocol conformance
@interface NSArray (State) <State>
@end

// Protocol conformance
@interface NSNumber (Action) <Action>
@end


/// A TicTacToe game, along with all the necessary state.
@interface TicTacToe : NSObject <Game>

// MARK: Init
- (instancetype)initWithSize:(int)size searchDepth:(int)depth;

// MARK: Helpers
- (BOOL)isOver;
- (BOOL)maxWon;
- (BOOL)minWon;
- (BOOL)isEmptyAtIndex:(int)i;

// MARK: Play
/// Plays the first move of the game.
- (Move *)gambit;
/// Plays the move specified and returns the move made by the opponent or `nil` if the game ended.
/// @param move The move to play.
- (nullable Move *)playMove:(Move *)move;

@end

NS_ASSUME_NONNULL_END

#endif /* GameState_h */
