//
//  GameStatisticsViewController.m
//  BasketballStats
//
//  Created by Liam Andrew on 11/06/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import "GameStatisticsViewController.h"
#import "StatHeaderTableViewCell.h"
#import "PlayerSummaryStatsTableViewCell.h"
#import "GameStatisticsNavigationViewController.h"
#import "DetailedStatisticsViewController.h"
#import "HomeTableViewController.h"

@interface GameStatisticsViewController () 

@end

@implementation GameStatisticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.homeTeam = [self.game.teams firstObject];
    self.awayTeam = [self.game.teams lastObject];

    [self setNavigationTitle];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor colorWithRed:37/255 green:44/255 blue:61/255 alpha:1.0f]}];
    
    // Ordered Set to track statistics action to configure undo button
    self.undoActionOrderedSet = [[NSMutableOrderedSet alloc] init];
    if ([self.undoActionOrderedSet count] == 0) {
        self.undoButton.enabled = NO;
    }
    
    // Stat Base Selector View
    self.statSelectorBaseView = [[StatSelectorBaseView alloc] initWithFrame:self.view.frame andParentViewController:self];
    self.statSelectorBaseView.managedObjectContext = self.managedObjectContext;
    [self.view addSubview:self.statSelectorBaseView];
    
    // Game Options Menu View
    self.gameOptionsMenuView = [[GameOptionsMenuView alloc] initWithFrame:self.view.frame andParentViewController:self];
    [self.view addSubview:self.gameOptionsMenuView];
    
    // Undo Alert View
    self.undoAlertView = [[UIAlertView alloc] initWithTitle:@"Confirm Undo Action" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Confirm", nil];
    self.nextPeriodAlertView = [[UIAlertView alloc] initWithTitle:@"Confirm action" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Confirm", nil];
    
    NSLog(@"current: %d number: %d", [self.game.currentPeriod intValue], [self.game.numberOfPeriods intValue]);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self.game.recordHomeTeamStats boolValue] && [self.game.recordAwayTeamStats boolValue]) {
        return 2;
    }
    return 1;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    StatHeaderTableViewCell *headerCell = (StatHeaderTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"headerCell"];

    if (section == 0 && [self.game.recordHomeTeamStats boolValue]) {
        headerCell.teamNameLabel.text = self.homeTeam.teamName;
    } else {
        headerCell.teamNameLabel.text = self.awayTeam.teamName;
    }
    
    return (UIView *) headerCell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0 && [self.game.recordHomeTeamStats boolValue]) {
        return [self.homeTeam.players count];
    } else {
        return [self.awayTeam.players count];
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    PlayerSummaryStatsTableViewCell *cell = (PlayerSummaryStatsTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"playerCell"];
    Player *player;
    if (indexPath.section == 0 && [self.game.recordHomeTeamStats boolValue]) {
        player = [self.homeTeam.players objectAtIndex:indexPath.row];
    } else {
        player = [self.awayTeam.players objectAtIndex:indexPath.row];
    }
    
    cell.playerNumberLabel.text = [NSString stringWithFormat:@"%@", player.playerNumber];
    
    cell.playerFirstNameInitialLabel.text = [NSString stringWithFormat:@"%@.", [player.firstName substringToIndex:1]];
    
    cell.playerLastNameLabel.text = player.lastName;
    
    cell.playerPointsLabel.text = [NSString stringWithFormat:@"%d", [[player getTotalPlayerPoints] intValue]];
    
    cell.playerReboundsLabel.text = [NSString stringWithFormat:@"%d", [[player getTotalPlayerTotalRebounds] intValue]];
    
    cell.playerAssistsLabel.text = [NSString stringWithFormat:@"%d", [[player getTotalPlayerAssists] intValue]];
    
    cell.playerStealsLabel.text = [NSString stringWithFormat:@"%d", [[player getTotalPlayerSteals] intValue]];
    
    cell.playerBlocksLabel.text = [NSString stringWithFormat:@"%d", [[player getTotalPlayerBlocks] intValue]];
    
    cell.playerTurnoversLabel.text = [NSString stringWithFormat:@"%d", [[player getTotalPlayerTurnovers] intValue]];
    
    cell.playerFoulsLabel.text = [NSString stringWithFormat:@"%d", [[player getTotalPlayerFouls] intValue]];

    return (UITableViewCell *) cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    Player *player;
    
    if (indexPath.section == 0 && [self.game.recordHomeTeamStats boolValue]) {
        player = [self.homeTeam.players objectAtIndex:indexPath.row];
    } else {
        player = [self.awayTeam.players objectAtIndex:indexPath.row];
    }
    
    [self.statSelectorBaseView presentBaseViewWithSelectedPlayer:player atIndexPath:indexPath forPeriodIndex:self.game.currentPeriod];

}

# pragma mark Button Functions 

- (IBAction)actionButtonAction:(UIBarButtonItem *)sender {
    [self.gameOptionsMenuView presentView];
}

- (IBAction)undoButtonAction:(UIBarButtonItem *)sender {
    
    if ([self.undoActionOrderedSet count] != 0) {
        
        UndoAction *nextAction = [self.undoActionOrderedSet lastObject];
        
        [self.undoAlertView setMessage: [self getUndoAlertMessage:nextAction]];
        
        [self.undoAlertView show];
    }
    
}

#pragma mark Undo Functions 

- (NSString *)getUndoAlertMessage: (UndoAction *)undoAction {
    
    switch (undoAction.action) {
        case kAddFieldGoalMade:
            return [NSString stringWithFormat:@"Undo made 2 pointer from %@ %@", undoAction.player.firstName, undoAction.player.lastName];
            break;
        case kAddFieldGoalMissed:
            return [NSString stringWithFormat:@"Undo missed 2 pointer from %@ %@", undoAction.player.firstName, undoAction.player.lastName];
            break;
        case kAddThreeGoalMade:
            return [NSString stringWithFormat:@"Undo made 3 pointer from %@ %@", undoAction.player.firstName, undoAction.player.lastName];
            break;
        case kAddThreeGoalMissed:
            return [NSString stringWithFormat:@"Undo missed 3 pointer from %@ %@", undoAction.player.firstName, undoAction.player.lastName];
            break;
        case kAddFreeThrowMade:
            return [NSString stringWithFormat:@"Undo made free throw from %@ %@", undoAction.player.firstName, undoAction.player.lastName];
            break;
        case kAddFreeThrowMissed:
            return [NSString stringWithFormat:@"Undo missed free throw from %@ %@", undoAction.player.firstName, undoAction.player.lastName];
            break;
        case kAddOffensiveRebound:
            return [NSString stringWithFormat:@"Undo offensive rebound from %@ %@", undoAction.player.firstName, undoAction.player.lastName];
            break;
        case kAddDefensiveRebound:
            return [NSString stringWithFormat:@"Undo defensive rebound from %@ %@", undoAction.player.firstName, undoAction.player.lastName];
            break;
        case kAddAssist:
            return [NSString stringWithFormat:@"Undo assist from %@ %@", undoAction.player.firstName, undoAction.player.lastName];
            break;
        case kAddBlock:
            return [NSString stringWithFormat:@"Undo block from %@ %@", undoAction.player.firstName, undoAction.player.lastName];
            break;
        case kAddSteal:
            return [NSString stringWithFormat:@"Undo steal from %@ %@", undoAction.player.firstName, undoAction.player.lastName];
            break;
        case kAddTurnover:
            return [NSString stringWithFormat:@"Undo turnover from %@ %@", undoAction.player.firstName, undoAction.player.lastName];
            break;
        case kAddFoul:
            return [NSString stringWithFormat:@"Undo foul from %@ %@", undoAction.player.firstName, undoAction.player.lastName];
            break;
        default:
            return @"nil";
            break;
    }
}

- (void) undoAction {
    UndoAction *nextAction = [self.undoActionOrderedSet lastObject];
    
    [nextAction undoAction:self.managedObjectContext];
    
    [self.undoActionOrderedSet removeObjectAtIndex:[self.undoActionOrderedSet count] - 1];
    
    if ([self.undoActionOrderedSet count] == 0) {
        self.undoButton.enabled = NO;
    }
    
    [self.tableView reloadData];
}

- (void) addUndoActionToOrderedSet: (UndoAction *) undoAction {
    
    [self.undoActionOrderedSet addObject:undoAction];
    
    if (!self.undoButton.enabled) {
        self.undoButton.enabled = YES;
    }
    
}

#pragma mark Alert View Delegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (alertView == self.undoAlertView) {
        if (buttonIndex == 1) {
            [self undoAction];
        }
    }
    if (alertView == self.nextPeriodAlertView) {
        if (buttonIndex == 1) {
            [self.gameOptionsMenuView hideView];
            [self enterNextPeriod];
        }
    }
    
}

#pragma mark Navigation

- (void) presentDetailedStatisticsViewController {

    UINavigationController *dnvc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailNavigationController"];
    DetailedStatisticsViewController *dvc = (DetailedStatisticsViewController *) dnvc.topViewController;
    dvc.game = self.game;
    
    [self.gameOptionsMenuView hideView];
    
    [self presentViewController:dnvc animated:YES completion:nil];
}

- (void)presentHomeViewController {
//    HomeMenuViewController *vc = (HomeMenuViewController *) [self.storyboard instantiateInitialViewController];
//    
//    [self presentViewController:vc animated:YES completion:nil];
    NSLog(@"Home View");
    UINavigationController *nc = (UINavigationController *) [self.storyboard instantiateInitialViewController];
    [self presentViewController:nc animated:YES completion:nil];
}

- (void) enterNextPeriod {
    
    self.game.currentPeriod = [NSNumber numberWithInt: [self.game.currentPeriod intValue] + 1];
    
    if (self.game.currentPeriod >= self.game.numberOfPeriods) {
        // Need to add an overtime Period if the current period is greater than the planned number of period for the game
        self.game.numberOfPeriods = [NSNumber numberWithInt: [self.game.numberOfPeriods intValue] + 1];
        
    }
    NSLog(@"current: %d number: %d", [self.game.currentPeriod intValue], [self.game.numberOfPeriods intValue]);
    
    //Add Periods to each player
    for (Player *player in self.homeTeam.players) {
        Period *period = [NSEntityDescription insertNewObjectForEntityForName:@"Period" inManagedObjectContext:self.managedObjectContext];
        period.index = [NSNumber numberWithInt:[self.game.currentPeriod intValue]];
        
        Statistics *statistics = [NSEntityDescription insertNewObjectForEntityForName:@"Statistics" inManagedObjectContext:self.managedObjectContext];
        statistics.period = period;
        period.statistics = statistics;
        
        [player addPeriodsObject:period];
    }
    
    for (Player *player in self.awayTeam.players) {
        Period *period = [NSEntityDescription insertNewObjectForEntityForName:@"Period" inManagedObjectContext:self.managedObjectContext];
        period.index = [NSNumber numberWithInt:[self.game.currentPeriod intValue]];
        
        Statistics *statistics = [NSEntityDescription insertNewObjectForEntityForName:@"Statistics" inManagedObjectContext:self.managedObjectContext];
        statistics.period = period;
        period.statistics = statistics;
        
        [player addPeriodsObject:period];
    }
    
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        // TODO: handle the error appropriately
    }
    [self setNavigationTitle];
}

- (void)setNavigationTitle {

    if ([self.game.structureHalves boolValue]) {
        switch ([self.game.currentPeriod intValue]) {
            case 0:
                self.navigationItem.title = @"First Half";
                break;
            case 1:
                self.navigationItem.title = @"Second Half";
                break;
            default:
                self.navigationItem.title = [NSString stringWithFormat:@"Overtime %d", [self.game.currentPeriod intValue] - 1];
                break;
        }
    } else {
        switch ([self.game.currentPeriod intValue]) {
            case 0:
                self.navigationItem.title = @"First Quarter";
                break;
            case 1:
                self.navigationItem.title = @"Second Quarter";
                break;
            case 2:
                self.navigationItem.title = @"Third Quarter";
                break;
            case 3:
                self.navigationItem.title = @"Fourth Quarter";
                break;
            default:
                self.navigationItem.title = [NSString stringWithFormat:@"Overtime %d", [self.game.currentPeriod intValue] - 3];
                break;
        }
    }
    
}

- (void) presentNextPeriodAlertView:(NSString *)message {
    [self.nextPeriodAlertView setMessage:message];
    [self.nextPeriodAlertView show];
}


@end
