//
//  Player.m
//  BasketballStats
//
//  Created by Liam Andrew on 13/07/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import "Player.h"
#import "Period.h"
#import "Team.h"
#import "Game.h"
#import "Statistics.h"


@implementation Player

@dynamic firstName;
@dynamic lastName;
@dynamic playerNumber;
@dynamic isPlaying;
@dynamic periods;
@dynamic team;
@dynamic scorerTop;
@dynamic reboundsTop;
@dynamic assistsTop;
@dynamic turnoversTop;
@dynamic blocksTop;
@dynamic stealsTop;


- (void)addPeriodsObject:(Period *)value {
    NSMutableOrderedSet *tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:self.periods];
    [tempSet addObject:value];
    self.periods = tempSet;
}

- (NSNumber *) getPlayerPointsForPeriod:(int)index {
    if (index > [self.team.game.currentPeriod intValue] || [self.periods count] == 0) {
        return [NSNumber numberWithInt:0];
    }
    Period *p = [self.periods objectAtIndex:index];
    Statistics *s = p.statistics;
    
    int twoPoints;
    if ([s.fieldGoalsMade intValue] > [s.threeGoalsMade intValue]) {
        twoPoints = [s.fieldGoalsMade intValue] - [s.threeGoalsMade intValue];
    } else {
        twoPoints = 0;
    }
    
    NSNumber *points = [NSNumber numberWithInt: (twoPoints * 2) + ( [s.threeGoalsMade intValue] * 3) + [s.freeThrowsMade intValue]];
    return points;
}

- (NSNumber *) getPlayerFieldGoalsMadeForPeriod:(int)index {
    if (index > [self.team.game.currentPeriod intValue]|| [self.periods count] == 0) {
        return [NSNumber numberWithInt:0];
    }
    Period *p = [self.periods objectAtIndex:index];
    Statistics *s = p.statistics;
    
    return s.fieldGoalsMade;
}

- (NSNumber *) getPlayerFieldGoalsAttemptedForPeriod:(int)index {
    if (index > [self.team.game.currentPeriod intValue]|| [self.periods count] == 0) {
        return [NSNumber numberWithInt:0];
    }
    Period *p = [self.periods objectAtIndex:index];
    Statistics *s = p.statistics;
    
    return s.fieldGoalsAttempted;
}

- (NSNumber *) getPlayerThreeGoalsMadeForPeriod:(int)index {
    if (index > [self.team.game.currentPeriod intValue]|| [self.periods count] == 0) {
        return [NSNumber numberWithInt:0];
    }
    Period *p = [self.periods objectAtIndex:index];
    Statistics *s = p.statistics;
    
    return s.threeGoalsMade;
}

- (NSNumber *) getPlayerThreeGoalsAttemptedForPeriod:(int)index {
    if (index > [self.team.game.currentPeriod intValue]|| [self.periods count] == 0) {
        return [NSNumber numberWithInt:0];
    }
    Period *p = [self.periods objectAtIndex:index];
    Statistics *s = p.statistics;
    
    return s.threeGoalsAttempted;
}

- (NSNumber *) getPlayerFreeThrowsMadeForPeriod:(int)index {
    if (index > [self.team.game.currentPeriod intValue]|| [self.periods count] == 0) {
        return [NSNumber numberWithInt:0];
    }
    Period *p = [self.periods objectAtIndex:index];
    Statistics *s = p.statistics;
    
    return s.freeThrowsMade;
}

- (NSNumber *) getPlayerFreeThrowsAttemptedForPeriod:(int)index {
    if (index > [self.team.game.currentPeriod intValue]|| [self.periods count] == 0) {
        return [NSNumber numberWithInt:0];
    }
    Period *p = [self.periods objectAtIndex:index];
    Statistics *s = p.statistics;
    
    return s.freeThrowsAttempted;
}

- (NSNumber *) getPlayerOffensiveReboundsForPeriod:(int)index {
    if (index > [self.team.game.currentPeriod intValue]|| [self.periods count] == 0) {
        return [NSNumber numberWithInt:0];
    }
    Period *p = [self.periods objectAtIndex:index];
    Statistics *s = p.statistics;
    
    return s.offensiveRebounds;
}

- (NSNumber *) getPlayerDefensiveReboundsForPeriod:(int)index {
    if (index > [self.team.game.currentPeriod intValue]|| [self.periods count] == 0) {
        return [NSNumber numberWithInt:0];
    }
    Period *p = [self.periods objectAtIndex:index];
    Statistics *s = p.statistics;
    
    return s.defensiveRebounds;
}

- (NSNumber *) getPlayerTotalReboundsForPeriod:(int)index {
    NSNumber *n = [NSNumber numberWithFloat:[[self getPlayerOffensiveReboundsForPeriod:index] intValue] + [[self getPlayerDefensiveReboundsForPeriod:index] intValue]];
    
    return n;
}

- (NSNumber *) getPlayerAssistsForPeriod:(int)index {
    if (index > [self.team.game.currentPeriod intValue]|| [self.periods count] == 0) {
        return [NSNumber numberWithInt:0];
    }
    Period *p = [self.periods objectAtIndex:index];
    Statistics *s = p.statistics;
    return s.assists;
}

- (NSNumber *) getPlayerBlocksForPeriod:(int)index {
    if (index > [self.team.game.currentPeriod intValue]|| [self.periods count] == 0) {
        return [NSNumber numberWithInt:0];
    }
    Period *p = [self.periods objectAtIndex:index];
    Statistics *s = p.statistics;
    
    return s.blocks;
}

- (NSNumber *) getPlayerStealsForPeriod:(int)index {
    if (index > [self.team.game.currentPeriod intValue]|| [self.periods count] == 0) {
        return [NSNumber numberWithInt:0];
    }
    Period *p = [self.periods objectAtIndex:index];
    Statistics *s = p.statistics;
    
    return s.steals;
}

- (NSNumber *) getPlayerTurnoversForPeriod:(int)index {
    if (index > [self.team.game.currentPeriod intValue]|| [self.periods count] == 0) {
        return [NSNumber numberWithInt:0];
    }
    Period *p = [self.periods objectAtIndex:index];
    Statistics *s = p.statistics;
    
    return s.turnovers;
}

- (NSNumber *) getPlayerFoulsForPeriod:(int)index {
    if (index > [self.team.game.currentPeriod intValue]|| [self.periods count] == 0) {
        return [NSNumber numberWithInt:0];
    }
    Period *p = [self.periods objectAtIndex:index];
    Statistics *s = p.statistics;
    
    return s.fouls;
}

- (NSNumber *) getTotalPlayerPoints {
    int twoPoints;
    if ([[self getTotalPlayerFieldGoalsMade] intValue] > [[self getTotalPlayerThreeGoalsMade] intValue]) {
        twoPoints = [[self getTotalPlayerFieldGoalsMade] intValue] - [[self getTotalPlayerThreeGoalsMade] intValue];
    } else {
        twoPoints = 0;
    }
    NSNumber *points = [NSNumber numberWithInt:twoPoints * 2 + [[self getTotalPlayerThreeGoalsMade] intValue] * 3 + [[self getTotalPlayerFreeThrowsMade] intValue]];
    //    NSLog(@"Player: %@ points: %d", self.firstName, [points intValue]);
    return points;
}

- (NSNumber *) getTotalPlayerFieldGoalsMade {
    NSNumber *n = [[NSNumber alloc] initWithFloat:0];
    for (int i = 0; i < [self.periods count]; i++) {
        n = [NSNumber numberWithInt: [n intValue] + [[self getPlayerFieldGoalsMadeForPeriod:i] intValue]];
    }
    return n;
}

- (NSNumber *) getTotalPlayerFieldGoalsAttempted {
    NSNumber *n = [[NSNumber alloc] initWithFloat:0];
    for (int i = 0; i < [self.periods count]; i++) {
        n = [NSNumber numberWithInt: [n intValue] + [[self getPlayerFieldGoalsAttemptedForPeriod:i] intValue]];
    }
    return n;
}

- (NSNumber *) getTotalPlayerThreeGoalsMade {
    NSNumber *n = [[NSNumber alloc] initWithFloat:0];
    for (int i = 0; i < [self.periods count]; i++) {
        n = [NSNumber numberWithInt: [n intValue] + [[self getPlayerThreeGoalsMadeForPeriod:i] intValue]];
    }
    return n;
}

- (NSNumber *) getTotalPlayerThreeGoalsAttempted {
    NSNumber *n = [[NSNumber alloc] initWithFloat:0];
    for (int i = 0; i < [self.periods count]; i++) {
        n = [NSNumber numberWithInt: [n intValue] + [[self getPlayerThreeGoalsAttemptedForPeriod:i] intValue]];
    }
    return n;
}

- (NSNumber *) getTotalPlayerFreeThrowsMade {
    NSNumber *n = [[NSNumber alloc] initWithFloat:0];
    for (int i = 0; i < [self.periods count]; i++) {
        n = [NSNumber numberWithInt: [n intValue] + [[self getPlayerFreeThrowsMadeForPeriod:i] intValue]];
    }
    return n;
}

- (NSNumber *) getTotalPlayerFreeThrowsAttempted {
    NSNumber *n = [[NSNumber alloc] initWithFloat:0];
    for (int i = 0; i < [self.periods count]; i++) {
        n = [NSNumber numberWithInt: [n intValue] + [[self getPlayerFreeThrowsAttemptedForPeriod:i] intValue]];
    }
    return n;
}

- (NSNumber *) getTotalPlayerOffensiveRebounds {
    NSNumber *n = [[NSNumber alloc] initWithFloat:0];
    for (int i = 0; i < [self.periods count]; i++) {
        n = [NSNumber numberWithInt: [n intValue] + [[self getPlayerOffensiveReboundsForPeriod:i] intValue]];
    }
    return n;
}

- (NSNumber *) getTotalPlayerDefensiveRebounds {
    NSNumber *n = [[NSNumber alloc] initWithFloat:0];
    for (int i = 0; i < [self.periods count]; i++) {
        n = [NSNumber numberWithInt: [n intValue] + [[self getPlayerDefensiveReboundsForPeriod:i] intValue]];
    }
    return n;
}

- (NSNumber *) getTotalPlayerTotalRebounds {
    NSNumber *n = [[NSNumber alloc] initWithFloat:0];
    for (int i = 0; i < [self.periods count]; i++) {
        n = [NSNumber numberWithInt: [n intValue] + [[self getPlayerTotalReboundsForPeriod:i] intValue]];
    }
    return n;
}

- (NSNumber *) getTotalPlayerAssists {
    NSNumber *n = [[NSNumber alloc] initWithFloat:0];
    for (int i = 0; i < [self.periods count]; i++) {
        n =[NSNumber numberWithInt: ([n intValue] + [[self getPlayerAssistsForPeriod:i] intValue])];
    }
    return n;
}

- (NSNumber *) getTotalPlayerBlocks {
    NSNumber *n = [[NSNumber alloc] initWithFloat:0];
    for (int i = 0; i < [self.periods count]; i++) {
        n = [NSNumber numberWithInt: [n intValue] + [[self getPlayerBlocksForPeriod:i] intValue]];
    }
    return n;
}

- (NSNumber *) getTotalPlayerSteals {
    NSNumber *n = [[NSNumber alloc] initWithFloat:0];
    for (int i = 0; i < [self.periods count]; i++) {
        n = [NSNumber numberWithInt: [n intValue] + [[self getPlayerStealsForPeriod:i] intValue]];
    }
    return n;
}

- (NSNumber *) getTotalPlayerTurnovers {
    NSNumber *n = [[NSNumber alloc] initWithFloat:0];
    for (int i = 0; i < [self.periods count]; i++) {
        n = [NSNumber numberWithInt: [n intValue] + [[self getPlayerTurnoversForPeriod:i] intValue]];
    }
    return n;
}

- (NSNumber *) getTotalPlayerFouls {
    NSNumber *n = [[NSNumber alloc] initWithFloat:0];
    for (int i = 0; i < [self.periods count]; i++) {
        n = [NSNumber numberWithInt: [n intValue] + [[self getPlayerFoulsForPeriod:i] intValue]];
    }
    return n;
}

- (BOOL) isValidPlayer {
    if (!self.team || !self.firstName || !self.lastName || !self.playerNumber) {
        NSLog(@"Not a valid player");
        return NO;
    } else if ([self.firstName isEqualToString:@""] || [self.lastName isEqualToString:@""]) {
        NSLog(@"Not a valid player");
        return NO;
    }
    return YES;
}


@end
