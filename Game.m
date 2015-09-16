//
//  Game.m
//  BasketballStats
//
//  Created by Liam Andrew on 13/07/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import "Game.h"
#import "Team.h"


@implementation Game

@dynamic currentPeriod;
@dynamic date;
@dynamic locationLatitude;
@dynamic locationLongitude;
@dynamic numberOfPeriods;
@dynamic recordAwayTeamStats;
@dynamic recordHomeTeamStats;
@dynamic structureHalves;
@dynamic gameStarted;
@dynamic defaultPeriodLength;
@dynamic teams;

- (void)addTeamsObject:(Team *)value {
    NSMutableOrderedSet *tempSet = [NSMutableOrderedSet orderedSetWithOrderedSet:self.teams];
    [tempSet addObject:value];
    self.teams = tempSet;
}

@end
