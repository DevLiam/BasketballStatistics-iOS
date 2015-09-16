//
//  OverviewTopPlayersViewController.m
//  BasketballStats
//
//  Created by Liam Andrew on 10/06/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import "OverviewTopPlayersViewController.h"

@interface OverviewTopPlayersViewController ()

@end

@implementation OverviewTopPlayersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.homeTeamNameLabel.text = self.homeTeam.teamName;
    
    if (self.homeTeam.topScorer) {
        self.homeTeamTopScorerLabel.text = [NSString stringWithFormat:@"%@. %@", [self.homeTeam.topScorer.firstName substringToIndex:1], self.homeTeam.topScorer.lastName];
    } else {
        self.homeTeamTopScorerLabel.text = @"N/A";
    }
    
    if (self.homeTeam.topRebounder) {
        self.homeTeamTopRebounderLabel.text = [NSString stringWithFormat:@"%@. %@", [self.homeTeam.topRebounder.firstName substringToIndex:1], self.homeTeam.topRebounder.lastName];
    } else {
        self.homeTeamTopRebounderLabel.text = @"N/A";
    }
    
    if (self.homeTeam.topAssists) {
        self.homeTeamTopAssistsLabel.text = [NSString stringWithFormat:@"%@. %@", [self.homeTeam.topAssists.firstName substringToIndex:1], self.homeTeam.topAssists.lastName];
    } else {
        self.homeTeamTopAssistsLabel.text = @"N/A";
    }
    
    if (self.homeTeam.topBlocks) {
        self.homeTeamTopBlocksLabel.text = [NSString stringWithFormat:@"%@. %@", [self.homeTeam.topBlocks.firstName substringToIndex:1], self.homeTeam.topBlocks.lastName];
    } else {
        self.homeTeamTopBlocksLabel.text = @"N/A";
    }
    
    if (self.homeTeam.topSteals) {
        self.homeTeamTopStealLabel.text = [NSString stringWithFormat:@"%@. %@", [self.homeTeam.topSteals.firstName substringToIndex:1], self.homeTeam.topSteals.lastName];
    } else {
        self.homeTeamTopStealLabel.text = @"N/A";
    }
    
    if (self.homeTeam.topTurnovers) {
        self.homeTeamTopTurnoversLabel.text = [NSString stringWithFormat:@"%@. %@", [self.homeTeam.topTurnovers.firstName substringToIndex:1], self.homeTeam.topTurnovers.lastName];
    } else {
        self.homeTeamTopTurnoversLabel.text = @"N/A";
    }
    
    self.awayTeamNameLabel.text = self.awayTeam.teamName;
    
    if (self.awayTeam.topScorer) {
        self.awayTeamTopScorerLabel.text = [NSString stringWithFormat:@"%@. %@", [self.awayTeam.topScorer.firstName substringToIndex:1], self.awayTeam.topScorer.lastName];
    } else {
        self.awayTeamTopScorerLabel.text = @"N/A";
    }
    
    if (self.awayTeam.topRebounder) {
        self.awayTeamTopRebounderLabel.text = [NSString stringWithFormat:@"%@. %@", [self.awayTeam.topRebounder.firstName substringToIndex:1], self.awayTeam.topRebounder.lastName];
    } else {
        self.awayTeamTopRebounderLabel.text = @"N/A";
    }
    
    if (self.awayTeam.topAssists) {
        self.awayTeamTopAssistsLabel.text = [NSString stringWithFormat:@"%@. %@", [self.awayTeam.topAssists.firstName substringToIndex:1], self.awayTeam.topAssists.lastName];
    } else {
        self.awayTeamTopAssistsLabel.text = @"N/A";
    }
    
    if (self.awayTeam.topBlocks) {
        self.awayTeamTopBlocksLabel.text = [NSString stringWithFormat:@"%@. %@", [self.awayTeam.topBlocks.firstName substringToIndex:1], self.awayTeam.topBlocks.lastName];
    } else {
        self.awayTeamTopBlocksLabel.text = @"N/A";
    }
    
    if (self.awayTeam.topSteals) {
        self.awayTeamTopStealLabel.text = [NSString stringWithFormat:@"%@. %@", [self.awayTeam.topSteals.firstName substringToIndex:1], self.awayTeam.topSteals.lastName];
    } else {
        self.awayTeamTopStealLabel.text = @"N/A";
    }
    
    if (self.awayTeam.topTurnovers) {
        self.awayTeamTopTurnoversLabel.text = [NSString stringWithFormat:@"%@. %@", [self.awayTeam.topTurnovers.firstName substringToIndex:1], self.awayTeam.topTurnovers.lastName];
    } else {
        self.awayTeamTopTurnoversLabel.text = @"N/A";
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
