//
//  DetailedStatisticsViewController.h
//  BasketballStats
//
//  Created by Liam Andrew on 27/06/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Game.h"
#import "Team.h"
#import "Player.h"
#import "Period.h"
#import "Statistics.h"

@interface DetailedStatisticsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic) Game *game;
@property (nonatomic) Team *homeTeam;
@property (nonatomic) Team *awayTeam;

@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (weak, nonatomic) IBOutlet UISegmentedControl *periodSegmentControl;


@end
