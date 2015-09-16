//
//  Player.h
//  BasketballStats
//
//  Created by Liam Andrew on 13/07/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Period, Team;

@interface Player : NSManagedObject

@property (nonatomic, retain) NSString * firstName;
@property (nonatomic, retain) NSString * lastName;
@property (nonatomic, retain) NSNumber * playerNumber;
@property (nonatomic, retain) NSNumber * isPlaying;
@property (nonatomic, retain) NSOrderedSet *periods;
@property (nonatomic, retain) Team *team;
@property (nonatomic, retain) Team *scorerTop;
@property (nonatomic, retain) Team *reboundsTop;
@property (nonatomic, retain) Team *assistsTop;
@property (nonatomic, retain) Team *turnoversTop;
@property (nonatomic, retain) Team *blocksTop;
@property (nonatomic, retain) Team *stealsTop;
@end

@interface Player (CoreDataGeneratedAccessors)

- (void)insertObject:(Period *)value inPeriodsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromPeriodsAtIndex:(NSUInteger)idx;
- (void)insertPeriods:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removePeriodsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInPeriodsAtIndex:(NSUInteger)idx withObject:(Period *)value;
- (void)replacePeriodsAtIndexes:(NSIndexSet *)indexes withPeriods:(NSArray *)values;
- (void)addPeriodsObject:(Period *)value;
- (void)removePeriodsObject:(Period *)value;
- (void)addPeriods:(NSOrderedSet *)values;
- (void)removePeriods:(NSOrderedSet *)values;

- (NSNumber *) getTotalPlayerPoints;
- (NSNumber *) getTotalPlayerFieldGoalsMade;
- (NSNumber *) getTotalPlayerFieldGoalsAttempted;
- (NSNumber *) getTotalPlayerThreeGoalsMade;
- (NSNumber *) getTotalPlayerThreeGoalsAttempted;
- (NSNumber *) getTotalPlayerFreeThrowsMade;
- (NSNumber *) getTotalPlayerFreeThrowsAttempted;
- (NSNumber *) getTotalPlayerOffensiveRebounds;
- (NSNumber *) getTotalPlayerDefensiveRebounds;
- (NSNumber *) getTotalPlayerTotalRebounds;
- (NSNumber *) getTotalPlayerAssists;
- (NSNumber *) getTotalPlayerBlocks;
- (NSNumber *) getTotalPlayerSteals;
- (NSNumber *) getTotalPlayerTurnovers;
- (NSNumber *) getTotalPlayerFouls;

- (NSNumber *) getPlayerPointsForPeriod:(int)index;
- (NSNumber *) getPlayerFieldGoalsMadeForPeriod:(int)index;
- (NSNumber *) getPlayerFieldGoalsAttemptedForPeriod:(int)index;
- (NSNumber *) getPlayerThreeGoalsMadeForPeriod:(int)index;
- (NSNumber *) getPlayerThreeGoalsAttemptedForPeriod:(int)index;
- (NSNumber *) getPlayerFreeThrowsMadeForPeriod:(int)index;
- (NSNumber *) getPlayerFreeThrowsAttemptedForPeriod:(int)index;
- (NSNumber *) getPlayerOffensiveReboundsForPeriod:(int)index;
- (NSNumber *) getPlayerDefensiveReboundsForPeriod:(int)index;
- (NSNumber *) getPlayerTotalReboundsForPeriod:(int)index;
- (NSNumber *) getPlayerAssistsForPeriod:(int)index;
- (NSNumber *) getPlayerBlocksForPeriod:(int)index;
- (NSNumber *) getPlayerStealsForPeriod:(int)index;
- (NSNumber *) getPlayerTurnoversForPeriod:(int)index;
- (NSNumber *) getPlayerFoulsForPeriod:(int)index;

- (BOOL) isValidPlayer;

@end
