//
//  Game.h
//  MicMacMoe
//
//  Created by Poulimenos, Vasileios, Vodafone Greece on 31/10/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef NS_ENUM(NSUInteger, MinimaxPlayer) {
    Max = 0,
    Min
};

/// A protocol defining a game state.
@protocol State <NSObject>
@end

/// A protocol defining a game action.
@protocol Action <NSObject>
@end

/// A protocol defining a game that the minimax algorithm will search operate on.
@protocol Game <NSObject>

@required
@property (nonatomic, assign, readonly) id initialState;

- (BOOL)isTerminal:(id<State>)state;
- (int)evaluate:(id<State>)state forPlayer:(MinimaxPlayer)player;
- (NSArray<id<Action>> *)actionsAt:(id<State>)state forPlayer:(MinimaxPlayer)player;
- (id<State>)resultAt:(id<State>)state forPlayer:(MinimaxPlayer)player fromAction:(id<Action>)action;

@end

NS_ASSUME_NONNULL_END
