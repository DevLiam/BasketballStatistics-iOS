//
//  GameOverviewViewController.h
//  BasketballStats
//
//  Created by Liam Andrew on 10/06/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Game.h"
#import "OverviewPageViewController.h"


@interface GameOverviewViewController : UIViewController <UIPageViewControllerDataSource>

@property (weak, nonatomic) IBOutlet UIButton *backButton;

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (strong, nonatomic) NSArray *pageIdentifierArray;

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic) Game *game;
@property (nonatomic) Team *homeTeam;
@property (nonatomic) Team *awayTeam;

@end
