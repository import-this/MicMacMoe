//
//  TicTacToe.m
//  MicMacMoe
//
//  Created by Poulimenos, Vasileios, Vodafone Greece on 30/10/20.
//

#import "TicTacToe.h"
#import "Minimax.h"
#import "Random.h"

@import GameplayKit;

// The AI is the Maximizing player.
@implementation TicTacToe {
    int boardSize;
    int searchDepth;
    NSMutableArray<NSNumber *>* board;
}

// MARK: - Init
- (instancetype)initWithSize:(int)size searchDepth:(int)depth {
    if (self = [super init]) {
        boardSize = size;
        searchDepth = depth;

        uint squareCount = size * size;
        NSMutableArray<NSNumber *> *temp = [NSMutableArray arrayWithCapacity:squareCount];
        for (int i = 1; i <= squareCount; ++i) {
            [temp addObject:@(-1)];
        }
        board = temp;
    }
    return self;
}

// MARK: - Helpers
- (BOOL)isFirstMove {
    // The first move is when the board is empty (no 0's or 1's).
    return ![board containsObject:@0] || ![board containsObject:@1];
}

- (BOOL)isFull:(NSArray<NSNumber *> *)board {
    return ![board containsObject:@(-1)];
}

- (BOOL)isOver {
    return [self isTerminal:board];  // Full board or win/loss
}

- (BOOL)maxWon {
    return [self wins:Max at:board];
}

- (BOOL)minWon {
    return [self wins:Min at:board];
}

- (BOOL)isEmptyAtIndex:(int)i {
    NSAssert(0 <= i && i < board.count, @"Out of bounds");
    return [board[i] isEqual:@(-1)];
}

- (BOOL)hasPlayer:(NSNumber *)p kInRow:(int)kInRow onBoard:(NSArray *)board i:(int)i j:(int)j di:(int)di dj:(int)dj {
    int k = 0;
    for (; k < kInRow; ++k) {
        if (![board[(i+k*di)*boardSize + j+(k*dj)] isEqualToNumber:p]) break;
    }
    return (k == kInRow);
}

- (BOOL)wins:(MinimaxPlayer)player at:(NSArray<NSNumber *> *)board {
    const int kInRow = 3;

    NSNumber *p = @(player);

    // Horizontal
    for (int i = 0; i < boardSize; ++i) {
        for (int j = 0; j < boardSize - (kInRow - 1); ++j) {
            if ([self hasPlayer:p kInRow:kInRow onBoard:board i:i j:j di:0 dj:1]) return YES;
        }
    }
    // Vertical
    for (int i = 0; i < boardSize - (kInRow - 1); ++i) {
        for (int j = 0; j < boardSize; ++j) {
            if ([self hasPlayer:p kInRow:kInRow onBoard:board i:i j:j di:1 dj:0]) return YES;
        }
    }
    // Diagonal
    for (int i = 0; i < boardSize - (kInRow - 1); ++i) {
        for (int j = 0; j < boardSize - (kInRow - 1); ++j) {
            if ([self hasPlayer:p kInRow:kInRow onBoard:board i:i j:j di:1 dj:1]) return YES;
        }
    }
    // Antidiagonal
    for (int i = kInRow - 1; i < boardSize; ++i) {
        for (int j = 0; j < boardSize - (kInRow - 1); ++j) {
            if ([self hasPlayer:p kInRow:kInRow onBoard:board i:i j:j di:-1 dj:1]) return YES;
        }
    }
    return NO;
}

// MARK: - Game
- (NSArray<NSNumber *> *)initialState {
    return board;
}

/// A state is terminal (the game is over) if it is won or there are no empty squares.
/// @param state The current state in the search tree.
- (BOOL)isTerminal:(NSArray<NSNumber *> *)state {
    return [self isFull:state] || [self wins:Max at:state] || [self wins:Min at:state];
}

/// Returns the value to player; 1 for win, -1 for loss, 0 otherwise.
/// @param state The current state in the search tree.
- (int)evaluate:(NSArray<NSNumber *> *)state forPlayer:(MinimaxPlayer)_ {
    return [self wins:Max at:state] ? 1 : ([self wins:Min at:state] ? -1 : 0);
}

/// Returns a list of legal moves. Legal moves are empty squares.
/// @param state The current state in the search tree.
- (NSArray<NSNumber *> *)actionsAt:(NSArray<NSNumber *> *)state forPlayer:(MinimaxPlayer)_ {
    NSMutableArray<NSNumber *> *actions = [NSMutableArray new];
    for (int i = 0; i < state.count; ++i) {
        if ([state[i] isEqualToNumber:@(-1)]) { // Empty
            [actions addObject:@(i)];
        }
    }
    // Minimax always selects first move between equally favorable actions. Shuffle to avoid repetition.
    return [actions shuffledArray];
}

/// Returns the new board after the move is played.
/// @param state The current state in the search tree.
/// @param player The player that made the move.
/// @param action The move to play.
- (NSArray<NSNumber *> *)resultAt:(NSArray<NSNumber *> *)state forPlayer:(MinimaxPlayer)player fromAction:(NSNumber *)action {
    NSAssert([state[action.intValue] isEqualToNumber:@(-1)], @"Illegal move");
    NSMutableArray<NSNumber *> *newBoard = [state mutableCopy];
    newBoard[action.intValue] = @(player);
    return newBoard;
}

// MARK: - Play
- (Move *)gambit {
    NSAssert([self isFirstMove], @"Gambit in the middle of the game");
    // Make a random choice the first move.
    NSInteger i = [Random integerInRangeMin:0 max:boardSize];
    NSInteger j = [Random integerInRangeMin:0 max:boardSize];
    board[i*boardSize + j] = @(Max);
    return [Move i:i j:j];
}

- (nullable Move *)playMove:(Move *)move {
    NSAssert(!self.isOver, @"Game over");

    // Apply human move.
    board[move.i*boardSize + move.j] = @(Min);
    if (self.isOver) {  // Last square is filled or player won.
        return nil;
    }

    // Apply AI move.
    NSInteger opponentMove = [[Minimax alphabeta:self depth:searchDepth] integerValue];
    board[opponentMove] = @(Max);

    NSInteger i = opponentMove / boardSize;
    NSInteger j = opponentMove % boardSize;
    return [Move i:i j:j];
}

@end
