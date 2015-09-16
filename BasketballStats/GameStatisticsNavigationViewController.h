//
//  GameStatisticsNavigationViewController.h
//  BasketballStats
//
//  Created by Liam Andrew on 23/06/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Game.h"
#import "Team.h"
#import "Player.h"
#import "Period.h"
#import "Statistics.h"

@interface GameStatisticsNavigationViewController : UINavigationController

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic) Game *game;

@end
