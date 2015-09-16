//
//  OverviewActionsViewController.h
//  BasketballStats
//
//  Created by Liam Andrew on 10/06/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OverviewPageViewController.h"
#import "RoundedButton.h"

@interface OverviewActionsViewController : OverviewPageViewController <UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet RoundedButton *continueGameButton;
@property (weak, nonatomic) IBOutlet RoundedButton *viewStatisticsButton;
@property (weak, nonatomic) IBOutlet RoundedButton *exportStatisticsButton;
@property (weak, nonatomic) IBOutlet RoundedButton *deleteGameButton;
@property (weak, nonatomic) IBOutlet RoundedButton *addRemovePlayerButton;

@end
