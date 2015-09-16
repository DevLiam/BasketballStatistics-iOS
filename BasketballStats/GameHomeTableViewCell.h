//
//  GameHomeTableViewCell.h
//  BasketballStats
//
//  Created by Liam Andrew on 28/05/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RoundedView.h"

@interface GameHomeTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet RoundedView *cellBackgroundView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeTeamNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *homeTeamScoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *awayTeamNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *awayTeamScoreLabel;
@property (weak, nonatomic) IBOutlet UIImageView *gameImageView;

- (void) setUpCell;

@end
