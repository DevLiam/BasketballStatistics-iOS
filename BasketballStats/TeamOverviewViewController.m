//
//  TeamOverviewViewController.m
//  BasketballStats
//
//  Created by Liam Andrew on 5/06/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import "TeamOverviewViewController.h"
#import "AddPlayerTableViewCell.h"
#import "GameStatisticsNavigationViewController.h"
#import "GameStatisticsViewController.h"

@interface TeamOverviewViewController ()

@property (nonatomic) NSMutableArray *teamListArray;

@end

@implementation TeamOverviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
 
    [self.addPlayerButton setProperties];
    [self.addPlayerButton setRoundedCorners];
    
    if (!self.gameDelegate) {
        self.navigationItem.rightBarButtonItem = nil;
    }
    
    if (!self.homeTeam) {
        self.homeTeam = [self.game.teams firstObject];
    }
    if (!self.awayTeam) {
        self.awayTeam = [self.game.teams lastObject];
    }

    
    // Set Team array for team options picker
    self.teamListArray = [NSMutableArray new];
    if ([self.game.recordHomeTeamStats boolValue]) {
        [self.teamListArray addObject: [[self.game.teams firstObject] teamName]];
    }
    if ([self.game.recordAwayTeamStats boolValue]) {
        [self.teamListArray addObject: [[self.game.teams lastObject] teamName]];
    }
    
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        // TODO: handle the error appropriately
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Table View

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    AddPlayerTableViewCell *cell = (AddPlayerTableViewCell *)[tableView dequeueReusableCellWithIdentifier:@"playerCell"];
    Player *player;
    Team *team;
    if (indexPath.section == 0 && [self.game.recordHomeTeamStats boolValue]) {

        // Player belongs to the home team
        team = (Team *)[self.game.teams firstObject];
        player = (Player *) [team.players objectAtIndex:indexPath.row];
    } else {
 
        // Player belongs to the away team
        team = (Team *)[self.game.teams lastObject];
        player = (Player *) [team.players objectAtIndex:indexPath.row];
    }
    cell.firstNameLabel.text = player.firstName;
    cell.lastNameLabel.text = player.lastName;
    cell.numberLabel.text = [NSString stringWithFormat:@"%d", [player.playerNumber intValue]];
   
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([self.game.recordHomeTeamStats boolValue] && [self.game.recordAwayTeamStats boolValue]) {
        return 2;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0 && [self.game.recordHomeTeamStats boolValue]) {
            return [self.homeTeam.players count];
    }
    return [self.awayTeam.players count];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    Team *team;
    if (section == 0 && [self.game.recordHomeTeamStats boolValue]) {
        team = [self.game.teams firstObject];
    } else {
        team = [self.game.teams lastObject];
    }

    return team.teamName;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView beginUpdates];
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        Player *p;
        if (indexPath.section == 0 && [self.game.recordHomeTeamStats boolValue]) {
            if ([self.homeTeam.players objectAtIndex:indexPath.row]) {
                
                p = (Player *) [self.homeTeam.players objectAtIndex:indexPath.row];
                [self.managedObjectContext deleteObject:p];

            }
        } else {
            if ([self.awayTeam.players objectAtIndex:indexPath.row]) {
                
                p = (Player *) [self.awayTeam.players objectAtIndex:indexPath.row];
                [self.managedObjectContext deleteObject:p];
                
            }
        }
       
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationAutomatic];
        
        NSError *error;
        
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            // TODO: handle the error appropriately
        }
    }
    
    [tableView endUpdates];
    [tableView reloadData];
}

#pragma mark Button Functions

- (IBAction)doneButtonAction:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Finished Game and Player Details?" message:@"Upon confirming you will no longer be able to edit game or player details." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Confirm", nil];
    [alert show];
}

- (IBAction)backButtonAction:(UIBarButtonItem *)sender {
//    [self.navigationController popViewControllerAnimated:YES];
    if (self.gameDelegate) {
        [self.gameDelegate setGameObjectOnPopover:self];
    } else {
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    }
}

#pragma mark Navigation 

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"AddPlayer"]) {
        
        // Creating a new player
        AddPlayersViewController *vc = (AddPlayersViewController *) segue.destinationViewController;
        // Set the properties of the add player scene
        vc.teamNamesArray = (NSArray *)self.teamListArray;
        vc.managedObjectContext = self.managedObjectContext;
        vc.game = self.game;
        vc.gameDelegate = self;
        vc.playerAddDelegate = self;
    }
}

#pragma mark Add Player Delegate 

- (void)addPlayerViewController:(AddPlayersViewController *) addPlayerViewController didAddConfirmPlayer:(BOOL)confirm {

    if (confirm) {
        
        NSLog(@"Adding player to game");
        
        Player *player = addPlayerViewController.player;
        if (!player) {
            return;
        }
        if (![player isValidPlayer]) {
            return;
        }
        
        if ([player.team isEqual:[self.game.teams firstObject]] && [self.game.recordHomeTeamStats boolValue]) {
            [[self.game.teams firstObject] addPlayersObject:player];
        } else if ([self.game.recordAwayTeamStats boolValue]){
            [[self.game.teams lastObject] addPlayersObject:player];
        } else {
            NSLog(@"error");
        }
        
        if ([self.game.gameStarted boolValue]) {
            for (int i = 0; i <= [self.game.currentPeriod intValue]; i++) {
                Period *period = [NSEntityDescription insertNewObjectForEntityForName:@"Period" inManagedObjectContext:self.managedObjectContext];
                period.index = [NSNumber numberWithInt:i];
            
                Statistics *statistics = [NSEntityDescription insertNewObjectForEntityForName:@"Statistics" inManagedObjectContext:self.managedObjectContext];
                statistics.period = period;
                period.statistics = statistics;
                    
                [player addPeriodsObject:period];
            }
        } else {
            Period *period = [NSEntityDescription insertNewObjectForEntityForName:@"Period" inManagedObjectContext:self.managedObjectContext];
            period.index = [NSNumber numberWithInt:0];
            
            Statistics *statistics = [NSEntityDescription insertNewObjectForEntityForName:@"Statistics" inManagedObjectContext:self.managedObjectContext];
            statistics.period = period;
            period.statistics = statistics;
            
            [player addPeriodsObject:period];
        }
        
//        for (int i = 0; i < [self.game.numberOfPeriods intValue]; i++) {
//            Period *period = [NSEntityDescription insertNewObjectForEntityForName:@"Period" inManagedObjectContext:self.managedObjectContext];
//            period.index = [NSNumber numberWithInt:i];
//            
//            Statistics *statistics = [NSEntityDescription insertNewObjectForEntityForName:@"Statistics" inManagedObjectContext:self.managedObjectContext];
//            statistics.period = period;
//            period.statistics = statistics;
//        
//            [player addPeriodsObject:period];
//        }
//        Period *period = [NSEntityDescription insertNewObjectForEntityForName:@"Period" inManagedObjectContext:self.managedObjectContext];
//        period.index = [NSNumber numberWithInt:0];
//        
//        Statistics *statistics = [NSEntityDescription insertNewObjectForEntityForName:@"Statistics" inManagedObjectContext:self.managedObjectContext];
//        statistics.period = period;
//        period.statistics = statistics;
//        
//        [player addPeriodsObject:period];
    
    } else {
        NSLog(@"Deleting player");
        [self.managedObjectContext deleteObject:addPlayerViewController.player];
        addPlayerViewController.player = nil;
    }
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        // TODO: handle the error appropriately
    }
    
    [self.tableView reloadData];
    // Dismiss the view once the confirmation has been handled
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark Alert View Delegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        //Indicate that the game has started
        self.game.gameStarted = [NSNumber numberWithBool:YES];
        
        NSError *error;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            // TODO: handle the error appropriately
        }
        
        GameStatisticsNavigationViewController *navController = (GameStatisticsNavigationViewController *) [self.storyboard instantiateViewControllerWithIdentifier:@"GameStatsNavigationController"];
        GameStatisticsViewController *vc = (GameStatisticsViewController *) navController.topViewController;
        vc.managedObjectContext = self.managedObjectContext;
        vc.game = self.game;
        
        [self presentViewController:navController animated:YES completion:nil];
    }
}

@end
