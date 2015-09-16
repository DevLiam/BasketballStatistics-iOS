//
//  ShotSelectionInterface.m
//  BasketballStats
//
//  Created by Liam Andrew on 25/06/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import "ShotSelectionInterface.h"

@implementation ShotSelectionInterface

#pragma mark Button Actions

- (IBAction)freeThrowButtonAction:(UIButton *)sender {
    [self.baseView presentShotStatusSelection:1];
}

- (IBAction)fieldGoalButtonAction:(UIButton *)sender {
    [self.baseView presentShotStatusSelection:2];
}

- (IBAction)threeGoalButtonAction:(UIButton *)sender {
    [self.baseView presentShotStatusSelection:3];
}


@end
