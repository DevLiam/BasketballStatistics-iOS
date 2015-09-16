//
//  Team.m
//  BasketballStats
//
//  Created by Liam Andrew on 13/07/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import "Team.h"
#import "Game.h"
#import "Player.h"


@implementation Team

@dynamic teamName;
@dynamic game;
@dynamic players;
@dynamic topAssists;
@dynamic topBlocks;
@dynamic topRebounder;
@dynamic topScorer;
@dynamic topSteals;
@dynamic topTurnovers;



- (void)addPlayersObject:(Player *)value {
    
    if ([value isValidPlayer]) {
        NSLog(@"Player: %@ %@ added to team: %@", value.firstName, value.lastName, value.team.teamName);
        
        NSMutableOrderedSet *tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:self.players];
        [tempSet addObject:value];
        
        NSSortDescriptor *numberDescriptor = [[NSSortDescriptor alloc] initWithKey:@"playerNumber" ascending:YES];
        NSArray *sortDescriptors = @[numberDescriptor];
        
        NSArray *tempArray = [tempSet sortedArrayUsingDescriptors:sortDescriptors];
        
        tempSet = [NSMutableOrderedSet orderedSetWithArray:tempArray];
        
        self.players = tempSet;
    }
}

- (NSNumber *) getTeamPointsForPeriod:(int)index {
    NSNumber *n = [NSNumber numberWithInt:0];
    for (Player *p in self.players) {
        n = [NSNumber numberWithInt: [n intValue] + [[p getPlayerPointsForPeriod:index] intValue]];
    }
    return n;
}

- (NSNumber *) getTeamFieldGoalsMadeForPeriod:(int)index {
    NSNumber *n = [NSNumber numberWithInt:0];
    for (Player *p in self.players) {
        n = [NSNumber numberWithInt: [n intValue] + [[p getPlayerFieldGoalsMadeForPeriod:index] intValue]];
    }
    return n;
}

- (NSNumber *) getTeamFieldGoalsAttemptedForPeriod:(int)index {
    NSNumber *n = [NSNumber numberWithInt:0];
    for (Player *p in self.players) {
        n = [NSNumber numberWithInt: [n intValue] + [[p getPlayerFieldGoalsAttemptedForPeriod:index] intValue]];
    }
    return n;
}

- (NSNumber *) getTeamThreeGoalsMadeForPeriod:(int)index {
    NSNumber *n = [NSNumber numberWithInt:0];
    for (Player *p in self.players) {
        n = [NSNumber numberWithInt: [n intValue] + [[p getPlayerThreeGoalsMadeForPeriod:index] intValue]];
    }
    return n;
}

- (NSNumber *) getTeamThreeGoalsAttemptedForPeriod:(int)index {
    NSNumber *n = [NSNumber numberWithInt:0];
    for (Player *p in self.players) {
        n = [NSNumber numberWithInt: [n intValue] + [[p getPlayerThreeGoalsAttemptedForPeriod:index] intValue]];
    }
    return n;
}

- (NSNumber *) getTeamFreeThrowsMadeForPeriod:(int)index {
    NSNumber *n = [NSNumber numberWithInt:0];
    for (Player *p in self.players) {
        n = [NSNumber numberWithInt: [n intValue] + [[p getPlayerFreeThrowsMadeForPeriod:index] intValue]];
    }
    return n;
}

- (NSNumber *) getTeamFreeThrowsAttemptedForPeriod:(int)index {
    NSNumber *n = [NSNumber numberWithInt:0];
    for (Player *p in self.players) {
        n = [NSNumber numberWithInt: [n intValue] + [[p getPlayerFreeThrowsAttemptedForPeriod:index] intValue]];
    }
    return n;
}

- (NSNumber *) getTeamOffensiveReboundsForPeriod:(int)index {
    NSNumber *n = [NSNumber numberWithInt:0];
    for (Player *p in self.players) {
        n = [NSNumber numberWithInt: [n intValue] + [[p getPlayerOffensiveReboundsForPeriod:index] intValue]];
    }
    return n;
}

- (NSNumber *) getTeamDefensiveReboundsForPeriod:(int)index {
    NSNumber *n = [NSNumber numberWithInt:0];
    for (Player *p in self.players) {
        n = [NSNumber numberWithInt: [n intValue] + [[p getPlayerDefensiveReboundsForPeriod:index] intValue]];
    }
    return n;
}

- (NSNumber *) getTeamTotalReboundsForPeriod:(int)index {
    NSNumber *n = [NSNumber numberWithInt:0];
    for (Player *p in self.players) {
        n = [NSNumber numberWithInt: [n intValue] + [[p getPlayerTotalReboundsForPeriod:index] intValue]];
    }
    return n;
}

- (NSNumber *) getTeamAssistsForPeriod:(int)index {
    NSNumber *n = [NSNumber numberWithInt:0];
    for (Player *p in self.players) {
        n = [NSNumber numberWithInt: [n intValue] + [[p getPlayerAssistsForPeriod:index] intValue]];
    }
    return n;
}

- (NSNumber *) getTeamBlocksForPeriod:(int)index {
    NSNumber *n = [NSNumber numberWithInt:0];
    for (Player *p in self.players) {
        n = [NSNumber numberWithInt: [n intValue] + [[p getPlayerBlocksForPeriod:index] intValue]];
    }
    return n;
}

- (NSNumber *) getTeamStealsForPeriod:(int)index {
    NSNumber *n = [NSNumber numberWithInt:0];
    for (Player *p in self.players) {
        n = [NSNumber numberWithInt: [n intValue] + [[p getPlayerStealsForPeriod:index] intValue]];
    }
    return n;
}

- (NSNumber *) getTeamTurnoversForPeriod:(int)index {
    NSNumber *n = [NSNumber numberWithInt:0];
    for (Player *p in self.players) {
        n = [NSNumber numberWithInt: [n intValue] + [[p getPlayerTurnoversForPeriod:index] intValue]];
    }
    return n;
}

- (NSNumber *) getTeamFoulsForPeriod:(int)index {
    NSNumber *n = [NSNumber numberWithInt:0];
    for (Player *p in self.players) {
        n = [NSNumber numberWithInt: [n intValue] + [[p getPlayerFoulsForPeriod:index] intValue]];
    }
    return n;
}




- (NSNumber *) getTeamTotalPoints {
    NSNumber *n = [NSNumber numberWithInt:0];
    for (int i = 0; i < [self.game.numberOfPeriods intValue]; i++) {
        n = [NSNumber numberWithInt: [n intValue] + [[self getTeamPointsForPeriod:i] intValue]];
    }
    return n;
}

- (NSNumber *) getTeamTotalFieldGoalsMade {
    NSNumber *n = [NSNumber numberWithInt:0];
    for (int i = 0; i < [self.game.numberOfPeriods intValue]; i++) {
        n = [NSNumber numberWithInt: [n intValue] + [[self getTeamFieldGoalsMadeForPeriod:i] intValue]];
    }
    return n;
}

- (NSNumber *) getTeamTotalFieldGoalsAttempted {
    NSNumber *n = [NSNumber numberWithInt:0];
    for (int i = 0; i < [self.game.numberOfPeriods intValue]; i++) {
        n = [NSNumber numberWithInt: [n intValue] + [[self getTeamFieldGoalsAttemptedForPeriod:i] intValue]];
    }
    return n;
}

- (NSNumber *) getTeamTotalThreeGoalsMade {
    NSNumber *n = [NSNumber numberWithInt:0];
    for (int i = 0; i < [self.game.numberOfPeriods intValue]; i++) {
        n = [NSNumber numberWithInt: [n intValue] + [[self getTeamThreeGoalsMadeForPeriod:i] intValue]];
    }
    return n;
}

- (NSNumber *) getTeamTotalThreeGoalsAttempted {
    NSNumber *n = [NSNumber numberWithInt:0];
    for (int i = 0; i < [self.game.numberOfPeriods intValue]; i++) {
        n = [NSNumber numberWithInt: [n intValue] + [[self getTeamThreeGoalsAttemptedForPeriod:i] intValue]];
    }
    return n;
}

- (NSNumber *) getTeamTotalFreeThrowsMade {
    NSNumber *n = [NSNumber numberWithInt:0];
    for (int i = 0; i < [self.game.numberOfPeriods intValue]; i++) {
        n = [NSNumber numberWithInt: [n intValue] + [[self getTeamFreeThrowsMadeForPeriod:i] intValue]];
    }
    return n;
}

- (NSNumber *) getTeamTotalFreeThrowsAttempted {
    NSNumber *n = [NSNumber numberWithInt:0];
    for (int i = 0; i < [self.game.numberOfPeriods intValue]; i++) {
        n = [NSNumber numberWithInt: [n intValue] + [[self getTeamFreeThrowsAttemptedForPeriod:i] intValue]];
    }
    return n;
}

- (NSNumber *) getTeamTotalOffensiveRebounds {
    NSNumber *n = [NSNumber numberWithInt:0];
    for (int i = 0; i < [self.game.numberOfPeriods intValue]; i++) {
        n = [NSNumber numberWithInt: [n intValue] + [[self getTeamOffensiveReboundsForPeriod:i] intValue]];
    }
    return n;
}

- (NSNumber *) getTeamTotalDefensiveRebounds {
    NSNumber *n = [NSNumber numberWithInt:0];
    for (int i = 0; i < [self.game.numberOfPeriods intValue]; i++) {
        n = [NSNumber numberWithInt: [n intValue] + [[self getTeamDefensiveReboundsForPeriod:i] intValue]];
    }
    return n;
}

- (NSNumber *) getTeamTotalTotalRebounds {
    NSNumber *n = [NSNumber numberWithInt:0];
    for (int i = 0; i < [self.game.numberOfPeriods intValue]; i++) {
        n = [NSNumber numberWithInt: [n intValue] + [[self getTeamTotalReboundsForPeriod:i] intValue]];
    }
    return n;
}

- (NSNumber *) getTeamTotalAssists {
    NSNumber *n = [NSNumber numberWithInt:0];
    for (int i = 0; i < [self.game.numberOfPeriods intValue]; i++) {
        n = [NSNumber numberWithInt: [n intValue] + [[self getTeamAssistsForPeriod:i] intValue]];
    }
    return n;
}

- (NSNumber *) getTeamTotalBlocks {
    NSNumber *n = [NSNumber numberWithInt:0];
    for (int i = 0; i < [self.game.numberOfPeriods intValue]; i++) {
        n = [NSNumber numberWithInt: [n intValue] + [[self getTeamBlocksForPeriod:i] intValue]];
    }
    return n;
}

- (NSNumber *) getTeamTotalSteals {
    NSNumber *n = [NSNumber numberWithInt:0];
    for (int i = 0; i < [self.game.numberOfPeriods intValue]; i++) {
        n = [NSNumber numberWithInt: [n intValue] + [[self getTeamStealsForPeriod:i] intValue]];
    }
    return n;
}

- (NSNumber *) getTeamTotalTurnovers {
    NSNumber *n = [NSNumber numberWithInt:0];
    for (int i = 0; i < [self.game.numberOfPeriods intValue]; i++) {
        n = [NSNumber numberWithInt: [n intValue] + [[self getTeamTurnoversForPeriod:i] intValue]];
    }
    return n;
}

- (NSNumber *) getTeamTotalFouls {
    NSNumber *n = [NSNumber numberWithInt:0];
    for (int i = 0; i < [self.game.numberOfPeriods intValue]; i++) {
        n = [NSNumber numberWithInt: [n intValue] + [[self getTeamFoulsForPeriod:i] intValue]];
    }
    return n;
}

- (float)getTeamFGPerc {
    if ([[self getTeamTotalFieldGoalsAttempted] intValue] == 0) {
        return 0;
    }
    float f = ([[self getTeamTotalFieldGoalsMade] floatValue] / [[self getTeamTotalFieldGoalsAttempted] floatValue]) * 100;
    return f;
}

- (float)getTeamTPPerc {
    if ([[self getTeamTotalThreeGoalsAttempted] intValue] == 0) {
        return 0;
    }
    float f = ([[self getTeamTotalThreeGoalsMade] floatValue] / [[self getTeamTotalThreeGoalsAttempted] floatValue]) * 100;
    return f;
}

- (float)getTeamFTPerc {
    if ([[self getTeamTotalFreeThrowsAttempted] intValue] == 0) {
        return 0;
    }
    float f = ([[self getTeamTotalFreeThrowsMade] floatValue] / [[self getTeamTotalFreeThrowsAttempted] floatValue]) * 100;
    return f;
}

- (void)comparePlayerToTopScorer:(Player *)player {
    if (!self.topScorer) {
        self.topScorer = player;
        
    } else if ([[player getTotalPlayerPoints] intValue] > [[self.topScorer getTotalPlayerPoints] intValue])  {
        self.topScorer = player;
    }
}

- (void)comparePlayerToTopRebounder:(Player *)player {
    if (!self.topRebounder) {
        self.topRebounder = player;
        
    } else if ([[player getTotalPlayerTotalRebounds] intValue] > [[self.topScorer getTotalPlayerTotalRebounds] intValue])  {
        self.topRebounder = player;
    }
}

- (void)comparePlayerToTopAssists:(Player *)player {
    if (!self.topAssists) {
        self.topAssists = player;
        
    } else if ([[player getTotalPlayerAssists] intValue] > [[self.topScorer getTotalPlayerAssists] intValue])  {
        self.topAssists = player;
    }
}

- (void)comparePlayerToTopBlocks:(Player *)player {
    if (!self.topBlocks) {
        self.topBlocks = player;
        
    } else if ([[player getTotalPlayerBlocks] intValue] > [[self.topScorer getTotalPlayerBlocks] intValue])  {
        self.topBlocks = player;
    }
}

- (void)comparePlayerToTopSteals:(Player *)player {
    if (!self.topSteals) {
        self.topSteals = player;
        
    } else if ([[player getTotalPlayerSteals] intValue] > [[self.topScorer getTotalPlayerSteals] intValue])  {
        self.topSteals = player;
    }
}

- (void)comparePlayerToTopTurnover:(Player *)player {
    if (!self.topTurnovers) {
        self.topTurnovers = player;
        
    } else if ([[player getTotalPlayerTurnovers] intValue] > [[self.topScorer getTotalPlayerTurnovers] intValue])  {
        self.topTurnovers = player;
    }
}


@end
