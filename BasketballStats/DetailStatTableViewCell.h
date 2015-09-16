//
//  DetailStatTableViewCell.h
//  BasketballStats
//
//  Created by Liam Andrew on 27/06/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailStatTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *playerNumberLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerFirstInitialLabel;
@property (weak, nonatomic) IBOutlet UILabel *playerLastNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *pointsLabel;
@property (weak, nonatomic) IBOutlet UILabel *fieldGoalsMadeAttemptedLabel;
@property (weak, nonatomic) IBOutlet UILabel *threeGoalsMadeAttemptedLabel;
@property (weak, nonatomic) IBOutlet UILabel *freeThrowsMadeAttemptedLabel;
@property (weak, nonatomic) IBOutlet UILabel *offensiveReboundsLabel;
@property (weak, nonatomic) IBOutlet UILabel *defensiveReboundsLabel;
@property (weak, nonatomic) IBOutlet UILabel *totalReboundsLabel;
@property (weak, nonatomic) IBOutlet UILabel *assistsLabel;
@property (weak, nonatomic) IBOutlet UILabel *stealsLabel;
@property (weak, nonatomic) IBOutlet UILabel *blockLabel;
@property (weak, nonatomic) IBOutlet UILabel *turnoversLabel;
@property (weak, nonatomic) IBOutlet UILabel *foulsLabel;

@end
