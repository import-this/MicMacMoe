//
//  TicTacToeGame.h
//  MicMacMoe
//
//  Created by Poulimenos, Vasileios, Vodafone Greece on 31/10/20.
//

#ifndef TicTacToeGame_h
#define TicTacToeGame_h

#import <Foundation/Foundation.h>
#import "Player.h"
#import "Difficulty.h"
#import "Move.h"
#import "Score.h"

NS_ASSUME_NONNULL_BEGIN

@interface TicTacToeGame : NSObject

/// Selecting a player different than the currently selected, restarts the game.
@property (nonatomic, assign) Player player;
/// Seleting a difficulty different than the currently selected, restarts the game.
@property (nonatomic, assign) Difficulty difficulty;

@property (nonatomic, strong, readonly) Score *score;

// MARK: Init
- (instancetype)initForPlayer:(Player)player atDifficulty:(Difficulty)level boardSize:(int)boardSize;

// MARK: Game Methods
// Requests the AI opponent to make the first move.
- (Move *)gambit;
/// Playes the human move specified and returns the move played by the AI opponent.
/// @param move The move to play.
- (nullable Move *)playMove:(Move *)move;
- (void)restart;

// MARK: Helpers
- (BOOL)isOver;
- (BOOL)isEmptyAtPos:(Move *)pos;

@end

NS_ASSUME_NONNULL_END

#endif /* TicTacToeGame_h */
