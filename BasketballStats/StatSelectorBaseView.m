//
//  StatSelectorBaseView.m
//  BasketballStats
//
//  Created by Liam Andrew on 24/06/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import "StatSelectorBaseView.h"
#import "UndoAction.h"

@implementation StatSelectorBaseView {
    BOOL baseIsShown;
    BOOL shotIsShown;
    BOOL shotStatusIsShown;
    BOOL reboundIsShown;
}

- (id) initWithFrame:(CGRect)frame andParentViewController: (GameStatisticsViewController *) vc{
    if ((self = [super initWithFrame:frame])) {
        
        self.hidden = YES;
        baseIsShown = NO;
        shotIsShown = NO;
        shotStatusIsShown = NO;
        reboundIsShown = NO;
        self.parentController = vc;
        
        // Background Shadow View
        self.backgroundView = [[UIView alloc] initWithFrame:frame];
        self.backgroundView.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.75];
        self.backgroundView.hidden = YES;
        [self addSubview:self.backgroundView];
        
        // Stat Selector Interface
        self.statSelectorInterface = [[[NSBundle mainBundle] loadNibNamed:@"StatSelectorInterface" owner:nil options:nil]lastObject];
        self.statSelectorInterface.frame = CGRectMake(0, self.frame.size.height + self.statSelectorInterface.frame.size.height,
                                                          frame.size.width, self.statSelectorInterface.frame.size.height);
        self.statSelectorInterface.baseView = self;
        [self addSubview:self.statSelectorInterface];
        
        // Shot Selection Interface
        self.shotSelectionInterface = [[[NSBundle mainBundle] loadNibNamed:@"ShotSelectionInterface" owner:nil options:nil]lastObject];
        self.shotSelectionInterface.frame = CGRectMake(0, self.frame.size.height + self.shotSelectionInterface.frame.size.height, frame.size.width, self.shotSelectionInterface.frame.size.height);
        self.shotSelectionInterface.baseView = self;
        [self addSubview:self.shotSelectionInterface];
        
        // Shot Status Selection Interface
        self.shotStatusSelectorInterface = [[[NSBundle mainBundle] loadNibNamed:@"ShotStatusSelectorInterface" owner:nil options:nil]lastObject];
        self.shotStatusSelectorInterface.frame = CGRectMake(0, self.frame.size.height + self.shotStatusSelectorInterface.frame.size.height, frame.size.width, self.shotStatusSelectorInterface.frame.size.height);
        self.shotStatusSelectorInterface.baseView = self;
        self.shotStatusSelectorInterface.points = 0;
        [self addSubview:self.shotStatusSelectorInterface];
        
        // Rebound Selection Interface
        self.reboundSelectorInterface = [[[NSBundle mainBundle] loadNibNamed:@"ReboundSelectorInterface" owner:nil options:nil]lastObject];
        self.reboundSelectorInterface.frame = CGRectMake(0, self.frame.size.height + self.reboundSelectorInterface.frame.size.height, frame.size.width, self.reboundSelectorInterface.frame.size.height);
        self.reboundSelectorInterface.baseView = self;
        [self addSubview:self.reboundSelectorInterface];
        
    }
    return self;
}

#pragma mark Base Stat Selection Functions

- (void) presentBaseViewWithSelectedPlayer: (Player *) player atIndexPath: (NSIndexPath *) indexPath forPeriodIndex: (NSNumber *) index{
    
    if (!baseIsShown) {
        self.selectedPlayer = player;
        self.currentPeriod = index;
        self.hidden = NO;
        self.backgroundView.hidden = NO;
        [self animateStatSelectorInterfaceToPoint:CGPointMake(0, self.frame.size.height - self.statSelectorInterface.frame.size.height) interface:self.statSelectorInterface];
        baseIsShown = YES;
    }
}

- (void)hideBaseView {
    
    if (baseIsShown) {
        NSError *error;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            // TODO: handle the error appropriately
        }
        [self.parentController.tableView reloadData];
        [self.parentController.tableView deselectRowAtIndexPath:self.indexPath animated:YES];
        baseIsShown = NO;
        self.selectedPlayer = nil;
        self.backgroundView.hidden = YES;
        [self animateStatSelectorInterfaceToPoint:CGPointMake(0, self.frame.size.height + self.statSelectorInterface.frame.size.height) interface: self.statSelectorInterface];
    }
}

#pragma mark Shot Selection Functions 

- (void)presentShotSelection {
    if (!shotIsShown) {
        
        [self animateStatSelectorInterfaceToPoint:CGPointMake(0, self.frame.size.height - self.shotSelectionInterface.frame.size.height) interface:self.shotSelectionInterface];
        shotIsShown = YES;
    }
}

- (void)hideShotSelectionView {
    if (shotIsShown) {
        
        [self animateStatSelectorInterfaceToPoint:CGPointMake(0, self.frame.size.height + self.shotSelectionInterface.frame.size.height) interface:self.shotSelectionInterface];
        shotIsShown = NO;
        
    }
}

#pragma mark Shot Status Selection Functions

- (void) presentShotStatusSelection:(int) point {
    if (!shotStatusIsShown) {
        self.shotStatusSelectorInterface.points = point;
        [self animateStatSelectorInterfaceToPoint:CGPointMake(0, self.frame.size.height - self.shotStatusSelectorInterface.frame.size.height) interface:self.shotStatusSelectorInterface];
        shotStatusIsShown = YES;
    }
}

- (void) hideShotStatusSelection {
    if (shotStatusIsShown) {
        self.shotStatusSelectorInterface.points = 0;
        [self animateStatSelectorInterfaceToPoint:CGPointMake(0, self.frame.size.height + self.shotStatusSelectorInterface.frame.size.height) interface:self.shotStatusSelectorInterface];
        shotStatusIsShown = NO;
    }
}

#pragma mark Rebound Stat Selection Functions

- (void)presentReboundSelection {
    if (!reboundIsShown) {

        [self animateStatSelectorInterfaceToPoint:CGPointMake(0, self.frame.size.height - self.reboundSelectorInterface.frame.size.height) interface:self.reboundSelectorInterface];
        reboundIsShown = YES;
    }
}

- (void)hideReboundSelection {
    if (reboundIsShown) {

        [self animateStatSelectorInterfaceToPoint:CGPointMake(0, self.frame.size.height + self.reboundSelectorInterface.frame.size.height) interface:self.reboundSelectorInterface];
        reboundIsShown = NO;
    }
}

- (void) animateStatSelectorInterfaceToPoint:(CGPoint)point interface: (UIView *) view{
    [UIView animateWithDuration: 0.3
                          delay: 0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations: ^{
                         [view setFrame:CGRectMake(point.x, point.y, view.frame.size.width, view.frame.size.height)];
                     } completion: ^(BOOL finished) {
                         if (!baseIsShown) {
                             self.hidden = true;
                         }
                     }];
}

#pragma mark Touch Functions

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    CGPoint point = [[touches anyObject] locationInView:self];
    
    if (self.backgroundView == [self hitTest:point withEvent:event]) {
        if (reboundIsShown) {
            [self hideReboundSelection];
        } else if (shotStatusIsShown) {
            [self hideShotStatusSelection];
        } else if (shotIsShown) {
            [self hideShotSelectionView];
        } else {
            [self hideBaseView];
        }
    }
    
}

#pragma mark Statistic Functions

- (void) addFieldGoal: (BOOL) made forPlayer:(Player *) player {
    Period *period = [player.periods objectAtIndex:[self.currentPeriod intValue]];
    
    UndoAction *undoAction;
    
    if (made) {
        [period.statistics addFieldGoalMade];
        
        undoAction = [[UndoAction alloc] initWithPlayer:player forPeriod:period andAction:kAddFieldGoalMade];
    } else {
        [period.statistics addFieldGoalMiss];
        
        undoAction = [[UndoAction alloc] initWithPlayer:player forPeriod:period andAction:kAddFieldGoalMissed];
    }
    
    [self.parentController addUndoActionToOrderedSet:undoAction];
    
    [self hideShotSelectionView];
    [self hideShotStatusSelection];
    [self hideBaseView];
}

- (void) addThreeGoal: (BOOL) made forPlayer:(Player *) player {
    Period *period = [player.periods objectAtIndex:[self.currentPeriod intValue]];
    
    UndoAction *undoAction;
    
    if (made) {
        [period.statistics addThreeGoalMade];
        
        undoAction = [[UndoAction alloc] initWithPlayer:player forPeriod:period andAction:kAddThreeGoalMade];
    } else {
        [period.statistics addThreeGoalMiss];
        
        undoAction = [[UndoAction alloc] initWithPlayer:player forPeriod:period andAction:kAddThreeGoalMissed];
    }
    
    [self.parentController addUndoActionToOrderedSet:undoAction];
    
    [self hideShotSelectionView];
    [self hideShotStatusSelection];
    [self hideBaseView];
}

- (void) addFreeThrow: (BOOL) made forPlayer:(Player *) player {
    
    Period *period = [player.periods objectAtIndex:[self.currentPeriod intValue]];
    
    UndoAction *undoAction;
    
    if (made) {
        [period.statistics addFreeThrowMade];
        
        undoAction = [[UndoAction alloc] initWithPlayer:player forPeriod:period andAction:kAddFreeThrowMade];
    } else {
        [period.statistics addFreeThrowMiss];
        
        undoAction = [[UndoAction alloc] initWithPlayer:player forPeriod:period andAction:kAddFreeThrowMissed];
    }
    
    [self.parentController addUndoActionToOrderedSet:undoAction];
    
    [self hideShotSelectionView];
    [self hideShotStatusSelection];
    [self hideBaseView];
}

- (void) addReboundForPlayer: (Player *) player isOffensive: (BOOL) offensive {
    
    Period *period = [player.periods objectAtIndex:[self.currentPeriod integerValue]];
    
    UndoAction *undoAction;
    
    if (offensive) {
        [period.statistics addOffensiveRebound];
        
        undoAction = [[UndoAction alloc] initWithPlayer:player forPeriod:period andAction:kAddOffensiveRebound];
    } else {
        [period.statistics addDefensiveRebound];
        
        undoAction = [[UndoAction alloc] initWithPlayer:player forPeriod:period andAction:kAddDefensiveRebound];
    }
    
    [self.parentController addUndoActionToOrderedSet:undoAction];
    
    [self hideReboundSelection];
    [self hideBaseView];
}

- (void) addAssistForPlayer: (Player *) player {
    
    Period *period = [player.periods objectAtIndex:[self.currentPeriod integerValue]];
    
    UndoAction *undoAction = [[UndoAction alloc] initWithPlayer:player forPeriod:period andAction:kAddAssist];
    
    [period.statistics addAssist];
    
    [self.parentController addUndoActionToOrderedSet:undoAction];
    
    [self hideBaseView];
}

- (void) addBlockForPlayer: (Player *) player {
    
    Period *period = [player.periods objectAtIndex:[self.currentPeriod integerValue]];
    
    UndoAction *undoAction = [[UndoAction alloc] initWithPlayer:player forPeriod:period andAction:kAddBlock];
    
    [period.statistics addBlock];
    
    [self.parentController addUndoActionToOrderedSet:undoAction];
    
    [self hideBaseView];
}

- (void) addStealForPlayer: (Player *) player {
    
    Period *period = [player.periods objectAtIndex:[self.currentPeriod integerValue]];
    
    UndoAction *undoAction = [[UndoAction alloc] initWithPlayer:player forPeriod:period andAction:kAddSteal];
    
    [period.statistics addSteal];
    
    [self.parentController addUndoActionToOrderedSet:undoAction];
    
    [self hideBaseView];
}

- (void) addTurnoverForPlayer: (Player *) player {
    
    Period *period = [player.periods objectAtIndex:[self.currentPeriod integerValue]];
    
    UndoAction *undoAction = [[UndoAction alloc] initWithPlayer:player forPeriod:period andAction:kAddTurnover];
    
    [period.statistics addTurnover];
    
    [self.parentController addUndoActionToOrderedSet:undoAction];
    
    [self hideBaseView];
}

- (void) addFoulForPlayer: (Player *) player {
    
    Period *period = [player.periods objectAtIndex:[self.currentPeriod integerValue]];
    
    UndoAction *undoAction = [[UndoAction alloc] initWithPlayer:player forPeriod:period andAction:kAddFoul];
    
    [period.statistics addFoul];
    
    [self.parentController addUndoActionToOrderedSet:undoAction];
    
    [self hideBaseView];
}

@end
