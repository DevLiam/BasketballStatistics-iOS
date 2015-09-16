//
//  Statistics.m
//  BasketballStats
//
//  Created by Liam Andrew on 13/07/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import "Statistics.h"
#import "Period.h"
#import "Team.h"
#import "Player.h"


@implementation Statistics

@dynamic assists;
@dynamic blocks;
@dynamic defensiveRebounds;
@dynamic fieldGoalsAttempted;
@dynamic fieldGoalsMade;
@dynamic fouls;
@dynamic freeThrowsAttempted;
@dynamic freeThrowsMade;
@dynamic offensiveRebounds;
@dynamic steals;
@dynamic threeGoalsAttempted;
@dynamic threeGoalsMade;
@dynamic turnovers;
@dynamic minutesPlayed;
@dynamic efficiency;
@dynamic period;

- (void) addFieldGoalMiss {
    self.fieldGoalsAttempted = [NSNumber numberWithInt: [self.fieldGoalsAttempted intValue] + 1];
}

- (void) addFieldGoalMade {
    self.fieldGoalsAttempted = [NSNumber numberWithInt: [self.fieldGoalsAttempted intValue] + 1];
    
    self.fieldGoalsMade = [NSNumber numberWithInt: [self.fieldGoalsMade intValue] + 1];
    
    [self.period.player.team comparePlayerToTopScorer:self.period.player];
}

- (void) addThreeGoalMiss {
    self.threeGoalsAttempted = [NSNumber numberWithInt: [self.threeGoalsAttempted intValue] + 1];
    self.fieldGoalsAttempted = [NSNumber numberWithInt: [self.fieldGoalsAttempted intValue] + 1];
}

- (void) addThreeGoalMade {
    self.threeGoalsAttempted = [NSNumber numberWithInt: [self.threeGoalsAttempted intValue] + 1];
    self.fieldGoalsAttempted = [NSNumber numberWithInt: [self.fieldGoalsAttempted intValue] + 1];
    
    self.fieldGoalsMade = [NSNumber numberWithInt: [self.fieldGoalsMade intValue] + 1];
    self.threeGoalsMade = [NSNumber numberWithInt: [self.threeGoalsMade intValue] + 1];
    
    [self.period.player.team comparePlayerToTopScorer:self.period.player];
}

- (void) addFreeThrowMiss {
    self.freeThrowsAttempted = [NSNumber numberWithInt: [self.freeThrowsAttempted intValue] + 1];
}

- (void) addFreeThrowMade {
    self.freeThrowsAttempted = [NSNumber numberWithInt: [self.freeThrowsAttempted intValue] + 1];
    
    self.freeThrowsMade = [NSNumber numberWithInt: [self.freeThrowsMade intValue] + 1];
    
    [self.period.player.team comparePlayerToTopScorer:self.period.player];
}

- (void) addOffensiveRebound {
    self.offensiveRebounds = [NSNumber numberWithInt: [self.offensiveRebounds intValue] + 1];
    
    [self.period.player.team comparePlayerToTopRebounder:self.period.player];
}

- (void) addDefensiveRebound {
    self.defensiveRebounds = [NSNumber numberWithInt: [self.defensiveRebounds intValue] + 1];
    
    [self.period.player.team comparePlayerToTopRebounder:self.period.player];
}

- (void) addAssist {
    self.assists = [NSNumber numberWithInt: [self.assists intValue] + 1];
    
    [self.period.player.team comparePlayerToTopAssists:self.period.player];
}

- (void) addSteal {
    self.steals = [NSNumber numberWithInt: [self.steals intValue] + 1];
    
    [self.period.player.team comparePlayerToTopSteals:self.period.player];
}

- (void) addBlock {
    self.blocks = [NSNumber numberWithInt: [self.blocks intValue] + 1];
    
    [self.period.player.team comparePlayerToTopBlocks:self.period.player];
}

- (void) addTurnover {
    self.turnovers = [NSNumber numberWithInt: [self.turnovers intValue] + 1];
    
    [self.period.player.team comparePlayerToTopTurnover:self.period.player];
}

- (void) addFoul {
    self.fouls = [NSNumber numberWithInt: [self.fouls intValue] + 1];
}


@end
