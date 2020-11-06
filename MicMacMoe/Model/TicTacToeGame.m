//
//  TicTacToeGame.m
//  MicMacMoe
//
//  Created by Poulimenos, Vasileios, Vodafone Greece on 31/10/20.
//

#import <Foundation/Foundation.h>
#import "TicTacToeGame.h"
#import "TicTacToe.h"

@interface TicTacToeGame ()

@property (nonatomic, strong) TicTacToe* engine;

@end

@implementation TicTacToeGame {
    int size;
}

// MARK: - Static Helpers
+ (int)depthFromLevel:(Difficulty)level boardSize:(int)size {
    // For 3x3: Easy: 1 - Medium: 3 - Impossible: 8
    int sizeFactor = size - 3;
    assert(sizeFactor >= 0);
    switch (level) {
        case Easy:
            return 1 + sizeFactor;
        case Medium:
            return 3 + sizeFactor;
        case Impossible:
            return 8 + sizeFactor;
        default:
            NSAssert(false, @"Switch should be exhaustive");
            break;
    }
}

// MARK: - Init
- (instancetype)initForPlayer:(Player)player atDifficulty:(Difficulty)level boardSize:(int)boardSize {
    if (self = [super init]) {
        int depth = [TicTacToeGame depthFromLevel:level boardSize:boardSize];
        size = boardSize;
        _player = player;
        _difficulty = level;
        _score = [Score new];
        _engine = [[TicTacToe alloc] initWithSize:size searchDepth:depth];
    }
    return self;
}

// MARK: - Accessors
- (void)setPlayer:(Player)player {
    if (_player == player) { return; }
    _player = player;
    [self restart];
}

- (void)setDifficulty:(Difficulty)difficulty {
    if (_difficulty == difficulty) { return; }
    _difficulty = difficulty;
    [self restart];
}

// MARK: - Game Methods
- (Move *)gambit {
    return [self.engine gambit];
}

- (nullable Move *)playMove:(Move *)move {
    Move *aiMove = [self.engine playMove:move];
    if (self.engine.isOver) {
        if (self.engine.maxWon) {   // The AI is the Maximizing player.
            if (self.player == PlayerX) {
                [self.score incO];
            } else {
                [self.score incX];
            }
        } else if (self.engine.minWon) {
            if (self.player == PlayerX) {
                [self.score incX];
            } else {
                [self.score incO];
            }
        }
    }
    return aiMove;
}

- (void)restart {
    int depth = [TicTacToeGame depthFromLevel:self.difficulty boardSize:size];
    self.engine = [[TicTacToe alloc] initWithSize:size searchDepth:depth];
}

// MARK: - Helpers
- (BOOL)isOver {
    return [self.engine isOver];
}

- (BOOL)isEmptyAtPos:(Move *)pos {
    int index = (int)(pos.i*size + pos.j);
    return [self.engine isEmptyAtIndex:index];
}

@end
