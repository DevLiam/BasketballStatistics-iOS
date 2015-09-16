//
//  GameOptionsMenuView.h
//  BasketballStats
//
//  Created by Liam Andrew on 27/06/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GameStatisticsViewController.h"
#import "GameOptionsInterface.h"

@class GameStatisticsViewController;
@class GameOptionsInterface;

@interface GameOptionsMenuView : UIView

@property (strong, nonatomic) GameStatisticsViewController *parentController;

@property (strong, nonatomic) UIView *backgroundView;
@property (nonatomic) GameOptionsInterface *gameOptionsInterface;

- (id) initWithFrame:(CGRect)frame andParentViewController: (GameStatisticsViewController *) vc;
- (void) presentView;
- (void) hideView;

@end
