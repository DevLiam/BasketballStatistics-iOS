//
//  GameStatisticsViewController.h
//  BasketballStats
//
//  Created by Liam Andrew on 11/06/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Game.h"
#import "Team.h"
#import "Player.h"
#import "Period.h"
#import "Statistics.h"
#import "StatSelectorBaseView.h"
#import "GameOptionsMenuView.h"
#import "UndoAction.h"

@class StatSelectorBaseView;
@class GameOptionsMenuView;

@interface GameStatisticsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic) Game *game;
@property (nonatomic) Team *homeTeam;
@property (nonatomic) Team *awayTeam;

@property (strong, nonatomic) NSMutableOrderedSet *undoActionOrderedSet;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *actionButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *undoButton;
@property (weak, nonatomic) IBOutlet UINavigationItem *titleNavItem;

@property (strong, nonatomic) UIAlertView *undoAlertView;
@property (strong, nonatomic) UIAlertView *nextPeriodAlertView;

@property (strong, nonatomic) StatSelectorBaseView *statSelectorBaseView;
@property (strong, nonatomic) GameOptionsMenuView *gameOptionsMenuView;

- (void) presentDetailedStatisticsViewController;
- (void) addUndoActionToOrderedSet: (UndoAction *) undoAction;
- (void) enterNextPeriod;
- (void) setNavigationTitle;
- (void) presentHomeViewController;
- (void) presentNextPeriodAlertView:(NSString *)message;


@end
