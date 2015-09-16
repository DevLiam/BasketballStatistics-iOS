//
//  DetailedStatisticsViewController.m
//  BasketballStats
//
//  Created by Liam Andrew on 27/06/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import "DetailedStatisticsViewController.h"
#import "DetailedStatHeaderTableViewCell.h"
#import "DetailStatTableViewCell.h"

@interface DetailedStatisticsViewController () {
    int selectedPeriodIndex;
}

@end

@implementation DetailedStatisticsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    selectedPeriodIndex = [self.game.numberOfPeriods intValue];
    
    self.homeTeam = [self.game.teams firstObject];
    self.awayTeam = [self.game.teams lastObject];
    
    [self setUpPeriodSegmentControl];
    
    self.scrollView.frame = [[UIScreen mainScreen] applicationFrame];
    self.tableView.frame = [[UIScreen mainScreen] applicationFrame];
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
    
    DetailedStatHeaderTableViewCell *headerCell = (DetailedStatHeaderTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"headerCell"];
    
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
        return [self.homeTeam.players count] + 1;
    } else {
        return [self.awayTeam.players count] + 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 40.0f;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    DetailStatTableViewCell *cell = (DetailStatTableViewCell *) [tableView dequeueReusableCellWithIdentifier:@"playerCell"];

    Player *player;
    Team *team;
    
    if (indexPath.section == 0 && [self.game.recordHomeTeamStats boolValue]) {
//        player = [self.homeTeam.players objectAtIndex:indexPath.row];
        team = self.homeTeam;
    } else {
//        player = [self.awayTeam.players objectAtIndex:indexPath.row];
        team = self.awayTeam;
    }
    
    if (indexPath.row == [team.players count]) {
        cell.playerNumberLabel.text = @"";
        
        cell.playerFirstInitialLabel.text = @"Total";
        
        cell.playerLastNameLabel.text = @"";
    } else {
        player = [team.players objectAtIndex:indexPath.row];
        
        cell.playerNumberLabel.text = [NSString stringWithFormat:@"%@", player.playerNumber];
        
        cell.playerFirstInitialLabel.text = [NSString stringWithFormat:@"%@.", [player.firstName substringToIndex:1]];
        
        cell.playerLastNameLabel.text = player.lastName;
    }
    
    
    if (selectedPeriodIndex == [self.game.numberOfPeriods intValue]) {
        // Get Stats for the entire game
        if (indexPath.row != [team.players count]) {
            //Normal Cell
        
            cell.pointsLabel.text = [NSString stringWithFormat:@"%d", [[player getTotalPlayerPoints] intValue]];
    
            cell.fieldGoalsMadeAttemptedLabel.text = [NSString stringWithFormat:@"%d-%d", [[player getTotalPlayerFieldGoalsMade] intValue], [[player getTotalPlayerFieldGoalsAttempted] intValue]];
    
            cell.threeGoalsMadeAttemptedLabel.text = [NSString stringWithFormat:@"%d-%d", [[player getTotalPlayerThreeGoalsMade] intValue] , [[player getTotalPlayerThreeGoalsAttempted] intValue]];

            cell.freeThrowsMadeAttemptedLabel.text = [NSString stringWithFormat:@"%d-%d", [[player getTotalPlayerFreeThrowsMade] intValue] , [[player getTotalPlayerFreeThrowsAttempted] intValue]];
    
            cell.offensiveReboundsLabel.text = [NSString stringWithFormat:@"%d", [[player getTotalPlayerOffensiveRebounds] intValue]];
    
            cell.defensiveReboundsLabel.text = [NSString stringWithFormat:@"%d", [[player getTotalPlayerDefensiveRebounds] intValue]];
    
            cell.totalReboundsLabel.text = [NSString stringWithFormat:@"%d", [[player getTotalPlayerTotalRebounds] intValue]];
    
            cell.assistsLabel.text = [NSString stringWithFormat:@"%d", [[player getTotalPlayerAssists] intValue]];
    
            cell.stealsLabel.text = [NSString stringWithFormat:@"%d", [[player getTotalPlayerSteals] intValue]];
    
            cell.blockLabel.text = [NSString stringWithFormat:@"%d", [[player getTotalPlayerBlocks] intValue]];
    
            cell.turnoversLabel.text = [NSString stringWithFormat:@"%d", [[player getTotalPlayerTurnovers] intValue]];
    
            cell.foulsLabel.text = [NSString stringWithFormat:@"%d", [[player getTotalPlayerFouls] intValue]];
        } else {
            // Total Cell
            
            cell.pointsLabel.text = [NSString stringWithFormat:@"%d", [[team getTeamTotalPoints] intValue]];
            
            cell.fieldGoalsMadeAttemptedLabel.text = [NSString stringWithFormat:@"%d-%d", [[team getTeamTotalFieldGoalsMade] intValue], [[team getTeamTotalFieldGoalsAttempted] intValue]];
            
            cell.threeGoalsMadeAttemptedLabel.text = [NSString stringWithFormat:@"%d-%d", [[team getTeamTotalThreeGoalsMade] intValue] , [[team getTeamTotalThreeGoalsAttempted] intValue]];
            
            cell.freeThrowsMadeAttemptedLabel.text = [NSString stringWithFormat:@"%d-%d", [[team getTeamTotalFreeThrowsMade] intValue] , [[team getTeamTotalFreeThrowsAttempted] intValue]];
            
            cell.offensiveReboundsLabel.text = [NSString stringWithFormat:@"%d", [[team getTeamTotalOffensiveRebounds] intValue]];
            
            cell.defensiveReboundsLabel.text = [NSString stringWithFormat:@"%d", [[team getTeamTotalDefensiveRebounds] intValue]];
            
            cell.totalReboundsLabel.text = [NSString stringWithFormat:@"%d", [[team getTeamTotalTotalRebounds] intValue]];
            
            cell.assistsLabel.text = [NSString stringWithFormat:@"%d", [[team getTeamTotalAssists] intValue]];
            
            cell.stealsLabel.text = [NSString stringWithFormat:@"%d", [[team getTeamTotalSteals] intValue]];
            
            cell.blockLabel.text = [NSString stringWithFormat:@"%d", [[team getTeamTotalBlocks] intValue]];
            
            cell.turnoversLabel.text = [NSString stringWithFormat:@"%d", [[team getTeamTotalTurnovers] intValue]];
            
            cell.foulsLabel.text = [NSString stringWithFormat:@"%d", [[team getTeamTotalFouls] intValue]];
        }
        
    } else {
        // Get stats for a single period
        
        if (indexPath.row != [team.players count]) {
            // Normal Cell
        
            cell.pointsLabel.text = [NSString stringWithFormat:@"%d", [[player getPlayerPointsForPeriod: selectedPeriodIndex] intValue]];
        
            cell.fieldGoalsMadeAttemptedLabel.text = [NSString stringWithFormat:@"%d-%d", [[player getPlayerFieldGoalsMadeForPeriod:selectedPeriodIndex] intValue], [[player getPlayerFieldGoalsAttemptedForPeriod:selectedPeriodIndex] intValue]];
        
            cell.threeGoalsMadeAttemptedLabel.text = [NSString stringWithFormat:@"%d-%d", [[player getPlayerThreeGoalsMadeForPeriod:selectedPeriodIndex] intValue] , [[player getPlayerThreeGoalsAttemptedForPeriod:selectedPeriodIndex] intValue]];
        
            cell.freeThrowsMadeAttemptedLabel.text = [NSString stringWithFormat:@"%d-%d", [[player getPlayerFreeThrowsMadeForPeriod:selectedPeriodIndex] intValue] , [[player getPlayerFreeThrowsAttemptedForPeriod:selectedPeriodIndex] intValue]];
        
            cell.offensiveReboundsLabel.text = [NSString stringWithFormat:@"%d", [[player getPlayerOffensiveReboundsForPeriod:selectedPeriodIndex] intValue]];
        
            cell.defensiveReboundsLabel.text = [NSString stringWithFormat:@"%d", [[player getPlayerDefensiveReboundsForPeriod:selectedPeriodIndex] intValue]];
        
            cell.totalReboundsLabel.text = [NSString stringWithFormat:@"%d", [[player getPlayerTotalReboundsForPeriod:selectedPeriodIndex] intValue]];
        
            cell.assistsLabel.text = [NSString stringWithFormat:@"%d", [[player getPlayerAssistsForPeriod:selectedPeriodIndex] intValue]];
        
            cell.stealsLabel.text = [NSString stringWithFormat:@"%d", [[player getPlayerStealsForPeriod:selectedPeriodIndex] intValue]];
        
            cell.blockLabel.text = [NSString stringWithFormat:@"%d", [[player getPlayerBlocksForPeriod:selectedPeriodIndex] intValue]];
        
            cell.turnoversLabel.text = [NSString stringWithFormat:@"%d", [[player getPlayerTurnoversForPeriod:selectedPeriodIndex] intValue]];
        
            cell.foulsLabel.text = [NSString stringWithFormat:@"%d", [[player getPlayerFoulsForPeriod:selectedPeriodIndex] intValue]];
        } else {
            // Total Cell
            
            cell.pointsLabel.text = [NSString stringWithFormat:@"%d", [[team getTeamPointsForPeriod:selectedPeriodIndex] intValue]];
            
            cell.fieldGoalsMadeAttemptedLabel.text = [NSString stringWithFormat:@"%d-%d", [[team getTeamFieldGoalsMadeForPeriod:selectedPeriodIndex] intValue], [[team getTeamFieldGoalsAttemptedForPeriod:selectedPeriodIndex] intValue]];
            
            cell.threeGoalsMadeAttemptedLabel.text = [NSString stringWithFormat:@"%d-%d", [[team getTeamThreeGoalsMadeForPeriod:selectedPeriodIndex] intValue] , [[team getTeamThreeGoalsAttemptedForPeriod:selectedPeriodIndex] intValue]];
            
            cell.freeThrowsMadeAttemptedLabel.text = [NSString stringWithFormat:@"%d-%d", [[team getTeamFreeThrowsMadeForPeriod:selectedPeriodIndex] intValue] , [[team getTeamFreeThrowsAttemptedForPeriod:selectedPeriodIndex] intValue]];
            
            cell.offensiveReboundsLabel.text = [NSString stringWithFormat:@"%d", [[team getTeamOffensiveReboundsForPeriod:selectedPeriodIndex] intValue]];
            
            cell.defensiveReboundsLabel.text = [NSString stringWithFormat:@"%d", [[team getTeamDefensiveReboundsForPeriod:selectedPeriodIndex] intValue]];
            
            cell.totalReboundsLabel.text = [NSString stringWithFormat:@"%d", [[team getTeamTotalReboundsForPeriod:selectedPeriodIndex] intValue]];
            
            cell.assistsLabel.text = [NSString stringWithFormat:@"%d", [[team getTeamAssistsForPeriod:selectedPeriodIndex] intValue]];
            
            cell.stealsLabel.text = [NSString stringWithFormat:@"%d", [[team getTeamStealsForPeriod:selectedPeriodIndex] intValue]];
            
            cell.blockLabel.text = [NSString stringWithFormat:@"%d", [[team getTeamBlocksForPeriod:selectedPeriodIndex] intValue]];
            
            cell.turnoversLabel.text = [NSString stringWithFormat:@"%d", [[team getTeamTurnoversForPeriod:selectedPeriodIndex] intValue]];
            
            cell.foulsLabel.text = [NSString stringWithFormat:@"%d", [[team getTeamFoulsForPeriod:selectedPeriodIndex] intValue]];
        }
    }
    
    return (UITableViewCell *) cell;
}

#pragma mark Button Functions

- (IBAction)backButtonAction:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Segment Control 

- (IBAction)periodSegmentControlChanged:(UISegmentedControl *)sender {
    selectedPeriodIndex = (int) self.periodSegmentControl.selectedSegmentIndex;
    [self.tableView reloadData];
}

- (void) setUpPeriodSegmentControl {
    
    if ([self.game.structureHalves boolValue]) {
        // Game Structure is Halves
        
        [self.periodSegmentControl setTitle:@"H1" forSegmentAtIndex:0];
        [self.periodSegmentControl setTitle:@"H2" forSegmentAtIndex:1];
        
        for (int i = 2; i < [self.game.numberOfPeriods intValue]; i++) {
            [self.periodSegmentControl insertSegmentWithTitle: [NSString stringWithFormat:@"OT%d", i-1] atIndex:i animated:YES];
        }
        
        
    } else {
        // Game Structure is Quarters
        
        [self.periodSegmentControl setTitle:@"Q1" forSegmentAtIndex:0];
        [self.periodSegmentControl setTitle:@"Q2" forSegmentAtIndex:1];
        [self.periodSegmentControl insertSegmentWithTitle:@"Q3" atIndex:2 animated:YES];
        [self.periodSegmentControl insertSegmentWithTitle:@"Q4" atIndex:3 animated:YES];
        
        for (int i = 4; i < [self.game.numberOfPeriods intValue]; i++) {
            [self.periodSegmentControl insertSegmentWithTitle: [NSString stringWithFormat:@"OT%d", i-3] atIndex:i animated:YES];
        }
        
    }
    [self.periodSegmentControl insertSegmentWithTitle:@"All" atIndex:[self.game.numberOfPeriods intValue]+1 animated:YES];
    self.periodSegmentControl.selectedSegmentIndex = selectedPeriodIndex;
}



@end
