//
//  GameOptionsInterface.h
//  BasketballStats
//
//  Created by Liam Andrew on 27/06/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameOptionsMenuView.h"
#import "RoundedButton.h"

@class GameOptionsMenuView;

@interface GameOptionsInterface : UIView

@property (nonatomic) GameOptionsMenuView *baseView;

@property (weak, nonatomic) IBOutlet RoundedButton *continueNextPeriodButton;
@property (weak, nonatomic) IBOutlet RoundedButton *editPlayerButton;
@property (weak, nonatomic) IBOutlet RoundedButton *viewDetailedStatisticsButton;
@property (weak, nonatomic) IBOutlet RoundedButton *exitButton;

- (void) setUpButtons;
- (void) setNextPeriodButton: (NSString *) string;

@end
