//
//  HomeTableViewController.h
//  BasketballStats
//
//  Created by Liam Andrew on 8/07/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "GameHomeTableViewCell.h"

@interface HomeTableViewController : UITableViewController <NSFetchedResultsControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating>

@property (nonatomic, strong) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) UISearchController *searchController;

@end
