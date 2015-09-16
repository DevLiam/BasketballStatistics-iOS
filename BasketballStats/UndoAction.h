//
//  UndoAction.h
//  BasketballStats
//
//  Created by Liam Andrew on 28/06/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "Player.h"
#import "Period.h"
#import "Statistics.h"

typedef enum {
    kAddFieldGoalMade = 0,
    kAddFieldGoalMissed,
    kAddThreeGoalMade,
    kAddThreeGoalMissed,
    kAddFreeThrowMade,
    kAddFreeThrowMissed,
    kAddOffensiveRebound,
    kAddDefensiveRebound,
    kAddAssist,
    kAddSteal,
    kAddBlock,
    kAddTurnover,
    kAddFoul
} Action;

@interface UndoAction : NSObject

@property (nonatomic) Player *player;
@property (nonatomic) Period *period;
@property (nonatomic) Action action;

- (id) initWithPlayer: (Player *)player forPeriod: (Period *)period andAction: (Action)action;
- (void) undoAction: (NSManagedObjectContext *)managedObjectContext;

@end
