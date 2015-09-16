//
//  Game.h
//  BasketballStats
//
//  Created by Liam Andrew on 13/07/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Team;

@interface Game : NSManagedObject

@property (nonatomic, retain) NSNumber * currentPeriod;
@property (nonatomic, retain) NSDate * date;
@property (nonatomic, retain) NSNumber * locationLatitude;
@property (nonatomic, retain) NSNumber * locationLongitude;
@property (nonatomic, retain) NSNumber * numberOfPeriods;
@property (nonatomic, retain) NSNumber * recordAwayTeamStats;
@property (nonatomic, retain) NSNumber * recordHomeTeamStats;
@property (nonatomic, retain) NSNumber * structureHalves;
@property (nonatomic, retain) NSNumber * gameStarted;
@property (nonatomic, retain) NSNumber * defaultPeriodLength;
@property (nonatomic, retain) NSOrderedSet *teams;
@end

@interface Game (CoreDataGeneratedAccessors)

- (void)insertObject:(Team *)value inTeamsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromTeamsAtIndex:(NSUInteger)idx;
- (void)insertTeams:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeTeamsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInTeamsAtIndex:(NSUInteger)idx withObject:(Team *)value;
- (void)replaceTeamsAtIndexes:(NSIndexSet *)indexes withTeams:(NSArray *)values;
- (void)addTeamsObject:(Team *)value;
- (void)removeTeamsObject:(Team *)value;
- (void)addTeams:(NSOrderedSet *)values;
- (void)removeTeams:(NSOrderedSet *)values;
@end
