//
//  StatSelectorInterface.m
//  BasketballStats
//
//  Created by Liam Andrew on 24/06/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import "StatSelectorInterface.h"

@implementation StatSelectorInterface


#pragma mark Button Functions 

- (IBAction)turnoverButtonAction:(UIButton *)sender {
    [self.baseView addTurnoverForPlayer:self.baseView.selectedPlayer];
}

- (IBAction)stealButtonAction:(UIButton *)sender {
    [self.baseView addStealForPlayer:self.baseView.selectedPlayer];
}

- (IBAction)assistButtonAction:(UIButton *)sender {
    [self.baseView addAssistForPlayer:self.baseView.selectedPlayer];
}

- (IBAction)shotButtonAction:(UIButton *)sender {
    // Present the shot interface
    [self.baseView presentShotSelection];
}

- (IBAction)reboundButtonAction:(UIButton *)sender {
    // Present the Rebound interface
    [self.baseView presentReboundSelection];
}

- (IBAction)blockButtonAction:(UIButton *)sender {
    [self.baseView addBlockForPlayer:self.baseView.selectedPlayer];
}

- (IBAction)foulButtonAction:(UIButton *)sender {
    [self.baseView addFoulForPlayer:self.baseView.selectedPlayer];
}


@end
