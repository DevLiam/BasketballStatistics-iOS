//
//  CreateGameViewController.h
//  BasketballStats
//
//  Created by Liam Andrew on 9/07/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "RoundedButton.h"
#import "Game.h"
#import "Team.h"
#import "Player.h"

@protocol GameDelegate;

@interface CreateGameViewController : UIViewController <GameDelegate>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic) Game *game;
@property (nonatomic, unsafe_unretained) id <GameDelegate> gameDelegate;


@end

@protocol GameDelegate <NSObject>

- (void)setGameObjectOnPopover:(CreateGameViewController *) createGameViewController ;

@end