//
//  PlayerSummaryStatsTableViewCell.h
//  BasketballStats
//
//  Created by Liam Andrew on 23/06/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayerSummaryStatsTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *playerNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerFirstNameInitialLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerLastNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerPointsLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerReboundsLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerAssistsLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerStealsLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerBlocksLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerTurnoversLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerFoulsLabel;


@end
