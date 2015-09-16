//
//  PDFObject.h
//  BasketballStats
//
//  Created by Liam Andrew on 1/07/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <CoreGraphics/CoreGraphics.h>
#import "Game.h"
#import "Team.h"
#import "Player.h"
#import "Period.h"
#import "Statistics.h"
#import "PDFGameStatsView.h"

@interface PDFObject : NSObject

@property (nonatomic) Game *game;
@property (nonatomic) Team *homeTeam;
@property (nonatomic) Team *awayTeam;
@property (strong, nonatomic) NSString *fileName;

- (id) initWithGameObject:(Game *)game andFileName:(NSString *)fileName;



@end
