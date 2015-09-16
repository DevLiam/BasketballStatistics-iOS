//
//  OverviewTopPlayersViewController.h
//  BasketballStats
//
//  Created by Liam Andrew on 10/06/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OverviewPageViewController.h"

@interface OverviewTopPlayersViewController : OverviewPageViewController

@property (weak, nonatomic) IBOutlet UILabel *homeTeamNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeTeamTopScorerLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeTeamTopRebounderLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeTeamTopAssistsLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeTeamTopBlocksLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeTeamTopStealLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeTeamTopTurnoversLabel;

@property (weak, nonatomic) IBOutlet UILabel *awayTeamNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *awayTeamTopScorerLabel;
@property (weak, nonatomic) IBOutlet UILabel *awayTeamTopRebounderLabel;
@property (weak, nonatomic) IBOutlet UILabel *awayTeamTopAssistsLabel;
@property (weak, nonatomic) IBOutlet UILabel *awayTeamTopBlocksLabel;
@property (weak, nonatomic) IBOutlet UILabel *awayTeamTopStealLabel;
@property (weak, nonatomic) IBOutlet UILabel *awayTeamTopTurnoversLabel;

@end
