//
//  ReboundSelectorInterface.m
//  BasketballStats
//
//  Created by Liam Andrew on 25/06/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import "ReboundSelectorInterface.h"

@implementation ReboundSelectorInterface

#pragma mark Button Actions

- (IBAction)defensiveReboundAction:(UIButton *)sender {
    [self.baseView addReboundForPlayer:self.baseView.selectedPlayer isOffensive:NO];
}

- (IBAction)offensiveReboundAction:(UIButton *)sender {
    [self.baseView addReboundForPlayer:self.baseView.selectedPlayer isOffensive:YES];
}

@end
