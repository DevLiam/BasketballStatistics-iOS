//
//  Period.h
//  BasketballStats
//
//  Created by Liam Andrew on 13/07/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Player, Statistics;

@interface Period : NSManagedObject

@property (nonatomic, retain) NSNumber * index;
@property (nonatomic, retain) NSNumber * periodLength;
@property (nonatomic, retain) Player *player;
@property (nonatomic, retain) Statistics *statistics;

@end
