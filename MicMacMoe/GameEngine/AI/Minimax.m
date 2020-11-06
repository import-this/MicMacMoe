//
//  Minimax.m
//  MicMacMoe
//
//  Created by Poulimenos, Vasileios, Vodafone Greece on 30/10/20.
//

#import <Foundation/Foundation.h>
#import "Minimax.h"

/// Adapted from `Artificial Intelligence: A Modern Approach`.
/// https://github.com/aimacode/aima-python/blob/master/games.py
// TODO: Implement Negamax with Alpha-Beta Pruning
@implementation Minimax {
    id<Game> game;
}

// MARK: - Init
- (instancetype)initWithGame:(id <Game>)game_ {
    if (self = [super init]) {
        game = game_;
    }
    return self;
}

// MARK: - Mutual Recursion Helpers
- (int)max:(id<State>)state depth:(int)depth alpha:(int)alpha beta:(int)beta {
    if (depth == 0 || [game isTerminal:state]) {
        return [game evaluate:state forPlayer:Max];
    }
    int value = INT_MIN;
    for (id action in [game actionsAt:state forPlayer:Max]) {
        value = MAX(value, [self min:[game resultAt:state forPlayer:Max fromAction:action] depth:depth-1 alpha:alpha beta:beta]);
        if (value >= beta) {
            return value;
        }
        alpha = MAX(alpha, value);
    }
    assert(value != INT_MIN);
    return value;
}

- (int)min:(id<State>)state depth:(int)depth alpha:(int)alpha beta:(int)beta {
    if (depth == 0 || [game isTerminal:state]) {
        return [game evaluate:state forPlayer:Max];
    }
    int value = INT_MAX;
    for (id action in [game actionsAt:state forPlayer:Min]) {
        value = MIN(value, [self max:[game resultAt:state forPlayer:Min fromAction:action] depth:depth-1 alpha:alpha beta:beta]);
        if (value <= alpha) {
            return value;
        }
        beta = MIN(beta, value);
    }
    assert(value != INT_MAX);
    return value;
}

// MARK: Alpha-Beta Pruning Algorithm
- (id<Action>)alphabeta:(id<State>)state depth:(int)depth {
    int maxValue = INT_MIN;
    id maxAction = nil;
    for (id action in [game actionsAt:state forPlayer:Max]) {
        int value = [self min:[game resultAt:state forPlayer:Max fromAction:action] depth:depth-1 alpha:maxValue beta:INT_MAX];
        if (value > maxValue) {
            maxValue = value;
            maxAction = action;
        }
    }
    assert(maxAction != nil);
    return maxAction;
}

// MARK: - Class convenience method.
+ (id)alphabeta:(id<Game>)game depth:(int)depth {
    Minimax *minimax = [[Minimax alloc] initWithGame:game];
    return [minimax alphabeta:game.initialState depth:depth];
}

@end
