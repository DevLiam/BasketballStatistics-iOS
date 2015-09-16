//
//  Team.h
//  BasketballStats
//
//  Created by Liam Andrew on 13/07/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Game, Player;

@interface Team : NSManagedObject

@property (nonatomic, retain) NSString * teamName;
@property (nonatomic, retain) Game *game;
@property (nonatomic, retain) NSOrderedSet *players;
@property (nonatomic, retain) Player *topAssists;
@property (nonatomic, retain) Player *topBlocks;
@property (nonatomic, retain) Player *topRebounder;
@property (nonatomic, retain) Player *topScorer;
@property (nonatomic, retain) Player *topSteals;
@property (nonatomic, retain) Player *topTurnovers;
@end

@interface Team (CoreDataGeneratedAccessors)

- (void)insertObject:(Player *)value inPlayersAtIndex:(NSUInteger)idx;
- (void)removeObjectFromPlayersAtIndex:(NSUInteger)idx;
- (void)insertPlayers:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removePlayersAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInPlayersAtIndex:(NSUInteger)idx withObject:(Player *)value;
- (void)replacePlayersAtIndexes:(NSIndexSet *)indexes withPlayers:(NSArray *)values;
- (void)addPlayersObject:(Player *)value;
- (void)removePlayersObject:(Player *)value;
- (void)addPlayers:(NSOrderedSet *)values;
- (void)removePlayers:(NSOrderedSet *)values;

- (NSNumber *) getTeamPointsForPeriod:(int)index;
- (NSNumber *) getTeamFieldGoalsMadeForPeriod:(int)index;
- (NSNumber *) getTeamFieldGoalsAttemptedForPeriod:(int)index;
- (NSNumber *) getTeamThreeGoalsMadeForPeriod:(int)index;
- (NSNumber *) getTeamThreeGoalsAttemptedForPeriod:(int)index;
- (NSNumber *) getTeamFreeThrowsMadeForPeriod:(int)index;
- (NSNumber *) getTeamFreeThrowsAttemptedForPeriod:(int)index;
- (NSNumber *) getTeamOffensiveReboundsForPeriod:(int)index;
- (NSNumber *) getTeamDefensiveReboundsForPeriod:(int)index;
- (NSNumber *) getTeamTotalReboundsForPeriod:(int)index;
- (NSNumber *) getTeamAssistsForPeriod:(int)index;
- (NSNumber *) getTeamBlocksForPeriod:(int)index;
- (NSNumber *) getTeamStealsForPeriod:(int)index;
- (NSNumber *) getTeamTurnoversForPeriod:(int)index;
- (NSNumber *) getTeamFoulsForPeriod:(int)index;

- (NSNumber *) getTeamTotalPoints;
- (NSNumber *) getTeamTotalFieldGoalsMade;
- (NSNumber *) getTeamTotalFieldGoalsAttempted;
- (NSNumber *) getTeamTotalThreeGoalsMade;
- (NSNumber *) getTeamTotalThreeGoalsAttempted;
- (NSNumber *) getTeamTotalFreeThrowsMade;
- (NSNumber *) getTeamTotalFreeThrowsAttempted;
- (NSNumber *) getTeamTotalOffensiveRebounds;
- (NSNumber *) getTeamTotalDefensiveRebounds;
- (NSNumber *) getTeamTotalTotalRebounds;
- (NSNumber *) getTeamTotalAssists;
- (NSNumber *) getTeamTotalBlocks;
- (NSNumber *) getTeamTotalSteals;
- (NSNumber *) getTeamTotalTurnovers;
- (NSNumber *) getTeamTotalFouls;

- (float)getTeamFGPerc;
- (float)getTeamTPPerc;
- (float)getTeamFTPerc;

- (void)comparePlayerToTopScorer:(Player *)player;
- (void)comparePlayerToTopRebounder:(Player *)player;
- (void)comparePlayerToTopAssists:(Player *)player;
- (void)comparePlayerToTopBlocks:(Player *)player;
- (void)comparePlayerToTopSteals:(Player *)player;
- (void)comparePlayerToTopTurnover:(Player *)player;
@end
