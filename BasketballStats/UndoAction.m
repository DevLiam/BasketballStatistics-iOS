//
//  UndoAction.m
//  BasketballStats
//
//  Created by Liam Andrew on 28/06/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import "UndoAction.h"

@implementation UndoAction

- (id) initWithPlayer: (Player *)player forPeriod: (Period *)period andAction: (Action)action {
    if (self = [super init]) {
        
        self.player = player;
        self.period = period;
        self.action = action;
        
    }
    return self;
}

- (void) undoAction: (NSManagedObjectContext *)managedObjectContext {
    switch (self.action) {
        case kAddFieldGoalMade:
            NSLog(@"Undo Action: Field Goal Made From Player: %@.", self.player.firstName);
            
            self.period.statistics.fieldGoalsMade = [NSNumber numberWithInt:[self.period.statistics.fieldGoalsMade intValue] - 1];
            self.period.statistics.fieldGoalsAttempted = [NSNumber numberWithInt:[self.period.statistics.fieldGoalsAttempted intValue] - 1];
            
            break;
        case kAddFieldGoalMissed:
            NSLog(@"Undo Action: Field Goal Missed From Player: %@.", self.player.firstName);
            
            self.period.statistics.fieldGoalsAttempted = [NSNumber numberWithInt:[self.period.statistics.fieldGoalsAttempted intValue] - 1];
            
            break;
        case kAddThreeGoalMade:
            NSLog(@"Undo Action: Three Goal Made From Player: %@.", self.player.firstName);
            
            self.period.statistics.fieldGoalsMade = [NSNumber numberWithInt:[self.period.statistics.fieldGoalsMade intValue] - 1];
            self.period.statistics.fieldGoalsAttempted = [NSNumber numberWithInt:[self.period.statistics.fieldGoalsAttempted intValue] - 1];
            
            self.period.statistics.threeGoalsMade = [NSNumber numberWithInt:[self.period.statistics.threeGoalsMade intValue] - 1];
            self.period.statistics.threeGoalsAttempted = [NSNumber numberWithInt:[self.period.statistics.threeGoalsAttempted intValue] - 1];
            
            break;
        case kAddThreeGoalMissed:
            NSLog(@"Undo Action: Three Goal Missed From Player: %@.", self.player.firstName);
            
            self.period.statistics.fieldGoalsAttempted = [NSNumber numberWithInt:[self.period.statistics.fieldGoalsAttempted intValue] - 1];
            self.period.statistics.threeGoalsAttempted = [NSNumber numberWithInt:[self.period.statistics.threeGoalsAttempted intValue] - 1];
            
            break;
        case kAddFreeThrowMade:
            NSLog(@"Undo Action: Free Throw Made From Player: %@.", self.player.firstName);
            
            self.period.statistics.freeThrowsMade = [NSNumber numberWithInt:[self.period.statistics.freeThrowsMade intValue] - 1];
            self.period.statistics.freeThrowsAttempted = [NSNumber numberWithInt:[self.period.statistics.freeThrowsAttempted intValue] - 1];
            
            break;
        case kAddFreeThrowMissed:
            NSLog(@"Undo Action: Free Throw Missed From Player: %@.", self.player.firstName);
            
            self.period.statistics.freeThrowsAttempted = [NSNumber numberWithInt:[self.period.statistics.freeThrowsAttempted intValue] - 1];
            
            break;
        case kAddOffensiveRebound:
            NSLog(@"Undo Action: Offensive Rebound From Player: %@.", self.player.firstName);
            
            self.period.statistics.offensiveRebounds = [NSNumber numberWithInt:[self.period.statistics.offensiveRebounds intValue] - 1];
            
            break;
        case kAddDefensiveRebound:
            NSLog(@"Undo Action: Defensive Rebound From Player: %@.", self.player.firstName);
            
            self.period.statistics.defensiveRebounds = [NSNumber numberWithInt:[self.period.statistics.defensiveRebounds intValue] - 1];
            
            break;
        case kAddAssist:
            NSLog(@"Undo Action: Assist From Player: %@.", self.player.firstName);
            
            self.period.statistics.assists = [NSNumber numberWithInt:[self.period.statistics.assists intValue] - 1];
            
            break;
        case kAddBlock:
            NSLog(@"Undo Action: Block From Player: %@.", self.player.firstName);
            
            self.period.statistics.blocks = [NSNumber numberWithInt:[self.period.statistics.blocks intValue] - 1];
            
            break;
        case kAddSteal:
            NSLog(@"Undo Action: Steal From Player: %@.", self.player.firstName);
            
            self.period.statistics.steals = [NSNumber numberWithInt:[self.period.statistics.steals intValue] - 1];
            
            break;
        case kAddTurnover:
            NSLog(@"Undo Action: Turnover From Player: %@.", self.player.firstName);
            
            self.period.statistics.turnovers = [NSNumber numberWithInt:[self.period.statistics.turnovers intValue] - 1];
            
            break;
        case kAddFoul:
            NSLog(@"Undo Action: Foul From Player: %@.", self.player.firstName);
            
            self.period.statistics.fouls = [NSNumber numberWithInt:[self.period.statistics.fouls intValue] - 1];
            
            break;
        default:
            NSLog(@"Undo Action Error");
            
            break;
    }
    NSError *error;
    if (![managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        // TODO: handle the error appropriately
    }
    
    
}


@end
