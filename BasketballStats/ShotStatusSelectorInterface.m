//
//  ShotStatusSelectorInterface.m
//  BasketballStats
//
//  Created by Liam Andrew on 26/06/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import "ShotStatusSelectorInterface.h"

@implementation ShotStatusSelectorInterface

#pragma mark Button Functions

- (IBAction)makeButtonAction:(UIButton *)sender {
    switch (self.points) {
        case 1:
            [self.baseView addFreeThrow:YES forPlayer:self.baseView.selectedPlayer];
            break;
        case 2:
            [self.baseView addFieldGoal:YES forPlayer:self.baseView.selectedPlayer];
            break;
        case 3:
            [self.baseView addThreeGoal:YES forPlayer:self.baseView.selectedPlayer];
            break;
        default:
            NSLog(@"Shot selection error");
            break;
    }
}

- (IBAction)missButtonAction:(UIButton *)sender {
    switch (self.points) {
        case 1:
            [self.baseView addFreeThrow:NO forPlayer:self.baseView.selectedPlayer];
            break;
        case 2:
            [self.baseView addFieldGoal:NO forPlayer:self.baseView.selectedPlayer];
            break;
        case 3:
            [self.baseView addThreeGoal:NO forPlayer:self.baseView.selectedPlayer];
            break;
        default:
            NSLog(@"Shot selection error");
            break;
    }
}

@end
