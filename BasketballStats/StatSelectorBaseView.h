//
//  StatSelectorBaseView.h
//  BasketballStats
//
//  Created by Liam Andrew on 24/06/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "GameStatisticsViewController.h"
#import "StatSelectorInterface.h"
#import "ReboundSelectorInterface.h"
#import "ShotSelectionInterface.h"
#import "ShotStatusSelectorInterface.h"
#import "Player.h"
#import "Period.h"
#import "Statistics.h"

@class GameStatisticsViewController;
@class StatSelectorInterface;
@class ShotSelectionInterface;
@class ShotStatusSelectorInterface;
@class ReboundSelectorInterface;

@interface StatSelectorBaseView : UIView

@property GameStatisticsViewController *parentController;

@property (strong, nonatomic) UIView *backgroundView;
@property (nonatomic) StatSelectorInterface *statSelectorInterface;
@property (nonatomic) ShotSelectionInterface *shotSelectionInterface;
@property (nonatomic) ShotStatusSelectorInterface *shotStatusSelectorInterface;
@property (nonatomic) ReboundSelectorInterface *reboundSelectorInterface;
@property (nonatomic) NSManagedObjectContext *managedObjectContext;

@property (nonatomic) Player *selectedPlayer;
@property (strong, nonatomic) NSNumber *currentPeriod;
@property (nonatomic) NSIndexPath *indexPath;

- (id) initWithFrame:(CGRect)frame andParentViewController: (GameStatisticsViewController *) vc;
- (void) hideBaseView;
- (void) presentBaseViewWithSelectedPlayer: (Player *) player atIndexPath: (NSIndexPath *) indexPath forPeriodIndex: (NSNumber *) index;
- (void) hideShotSelectionView;
- (void) presentShotSelection;
- (void) hideShotStatusSelection;
- (void) presentShotStatusSelection:(int) point;
- (void) hideReboundSelection;
- (void) presentReboundSelection;
- (void) addFieldGoal: (BOOL) made forPlayer:(Player *) player;
- (void) addThreeGoal: (BOOL) made forPlayer:(Player *) player;
- (void) addFreeThrow: (BOOL) made forPlayer:(Player *) player;
- (void) addReboundForPlayer: (Player *) player isOffensive: (BOOL) offensive;
- (void) addAssistForPlayer: (Player *) player;
- (void) addBlockForPlayer: (Player *) player;
- (void) addStealForPlayer: (Player *) player;
- (void) addTurnoverForPlayer: (Player *) player;
- (void) addFoulForPlayer: (Player *) player;


@end
