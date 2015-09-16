//
//  Statistics.h
//  BasketballStats
//
//  Created by Liam Andrew on 13/07/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Period;

@interface Statistics : NSManagedObject

@property (nonatomic, retain) NSNumber * assists;
@property (nonatomic, retain) NSNumber * blocks;
@property (nonatomic, retain) NSNumber * defensiveRebounds;
@property (nonatomic, retain) NSNumber * fieldGoalsAttempted;
@property (nonatomic, retain) NSNumber * fieldGoalsMade;
@property (nonatomic, retain) NSNumber * fouls;
@property (nonatomic, retain) NSNumber * freeThrowsAttempted;
@property (nonatomic, retain) NSNumber * freeThrowsMade;
@property (nonatomic, retain) NSNumber * offensiveRebounds;
@property (nonatomic, retain) NSNumber * steals;
@property (nonatomic, retain) NSNumber * threeGoalsAttempted;
@property (nonatomic, retain) NSNumber * threeGoalsMade;
@property (nonatomic, retain) NSNumber * turnovers;
@property (nonatomic, retain) NSNumber * minutesPlayed;
@property (nonatomic, retain) NSNumber * efficiency;
@property (nonatomic, retain) Period *period;

- (void) addFieldGoalMiss;
- (void) addFieldGoalMade;
- (void) addThreeGoalMiss;
- (void) addThreeGoalMade;
- (void) addFreeThrowMiss;
- (void) addFreeThrowMade;
- (void) addOffensiveRebound;
- (void) addDefensiveRebound;
- (void) addAssist;
- (void) addSteal;
- (void) addBlock;
- (void) addTurnover;
- (void) addFoul;

@end
