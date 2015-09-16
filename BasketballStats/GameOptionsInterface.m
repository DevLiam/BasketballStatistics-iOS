//
//  GameOptionsInterface.m
//  BasketballStats
//
//  Created by Liam Andrew on 27/06/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import "GameOptionsInterface.h"

@implementation GameOptionsInterface

- (void) setUpButtons {
    
    [self.continueNextPeriodButton setProperties];
    [self.continueNextPeriodButton setRoundedCorners];
    
    [self.editPlayerButton setProperties];
    [self.editPlayerButton setRoundedCorners];
    
    [self.viewDetailedStatisticsButton setProperties];
    [self.viewDetailedStatisticsButton setRoundedCorners];
    
    [self.exitButton setProperties];
    [self.exitButton setRoundedCorners];
}

- (IBAction)continueNextPeriodButtonAction:(UIButton *)sender {
//    [self continueToNextPeriod];
    [self.baseView.parentController presentNextPeriodAlertView:self.continueNextPeriodButton.titleLabel.text];
}

- (IBAction)editPlayersButtonAction:(UIButton *)sender {
}

- (IBAction)viewDetailedStatsButtonAction:(UIButton *)sender {

    [self.baseView.parentController presentDetailedStatisticsViewController];
}

- (IBAction)exitButtonAction:(UIButton *)sender {
//    [self.baseView.parentController dismissViewControllerAnimated:YES completion:nil];
    [self.baseView.parentController presentHomeViewController];
}

- (void) setNextPeriodButton: (NSString *) string {
//    self.continueNextPeriodButton.titleLabel.text = string;
//    [self.continueNextPeriodButton.titleLabel setText: string];
    NSAttributedString *aString = [[NSAttributedString alloc] initWithString:string];
    [self.continueNextPeriodButton setAttributedTitle: aString forState:UIControlStateNormal];
    self.continueNextPeriodButton.contentHorizontalAlignment = UIControlContentHorizontalAlignmentCenter;
    
}

- (void) continueToNextPeriod {
    
//    [self.baseView.parentController enterNextPeriod];
//    
//    [self.baseView.parentController setNavigationTitle];
    
    
    
    [self.baseView hideView];
}

@end
