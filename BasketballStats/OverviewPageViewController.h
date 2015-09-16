//
//  OverviewPageViewController.h
//  BasketballStats
//
//  Created by Liam Andrew on 10/06/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Game.h"
#import "Team.h"
#import "Player.h"


@interface OverviewPageViewController : UIViewController

@property (nonatomic) NSUInteger pageIndex;
@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic) Game *game;
@property (nonatomic) Team *homeTeam;
@property (nonatomic) Team *awayTeam;

- (void) setPageIndex:(NSUInteger)pageIndex;

@end
