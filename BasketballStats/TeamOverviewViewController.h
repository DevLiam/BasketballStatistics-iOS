//
//  TeamOverviewViewController.h
//  BasketballStats
//
//  Created by Liam Andrew on 5/06/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import "CreateGameViewController.h"
#import <UIKit/UIKit.h>
#import "AddPlayersViewController.h"

@interface TeamOverviewViewController : CreateGameViewController <PlayerAddDelegate, UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>

@property (nonatomic) NSDate *gameDate;
@property (nonatomic) Team *homeTeam;
@property (nonatomic) Team *awayTeam;


@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet RoundedButton *addPlayerButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;

@end
