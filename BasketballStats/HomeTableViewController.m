//
//  HomeTableViewController.m
//  BasketballStats
//
//  Created by Liam Andrew on 8/07/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import "HomeTableViewController.h"
#import "AppDelegate.h"
#import "CreateNewGameRootViewController.h"
#import "GameOverviewViewController.h"
#import "SearchResultsTableViewController.h"
#import "Game.h"
#import "Team.h"

@interface HomeTableViewController () {
    NSDateFormatter *dateFormatter;
    NSDateFormatter *timeFormatter;
}

@property (nonatomic, strong) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, strong) NSArray *gameFetchResults;
@property (nonatomic, strong) NSArray *gameSearchResults;

@end

@implementation HomeTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // Set up date and time formatter
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"hh:mm"];
    
    // Check to see if there is a current managed object context
    if (!self.managedObjectContext) {
        AppDelegate *ad = [[UIApplication sharedApplication] delegate];
        self.managedObjectContext = ad.managedObjectContext;
    }
    
//    // Fetch Stored Game Data
//    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
//    
//    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Game" inManagedObjectContext:self.managedObjectContext];
//    [fetchRequest setEntity:entity];
//    
//    NSError *error = nil;
//    _gameFetchResults = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
//    
//    if (error) {
//        NSLog(@"Unable to execute fetch request.");
//        NSLog(@"%@, %@", error, error.localizedDescription);
//    }
    
    // Grab the navigation controller that holds the search results table view
    UINavigationController *gameSearchResultsController = [self.storyboard instantiateViewControllerWithIdentifier:@"SearchResultsTableViewController"];
    self.searchController = [[UISearchController alloc] initWithSearchResultsController:gameSearchResultsController];
    self.searchController.searchResultsUpdater = self;
    
    [self.searchController.searchBar sizeToFit];
    self.searchController.searchBar.delegate = self;
    self.searchController.searchBar.searchBarStyle = UISearchBarStyleMinimal;
    
    self.tableView.tableHeaderView = self.searchController.searchBar;
    self.definesPresentationContext = YES;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // Check to see if there is a current managed object context
    if (!self.managedObjectContext) {
        AppDelegate *ad = [[UIApplication sharedApplication] delegate];
        self.managedObjectContext = ad.managedObjectContext;
    }
    
    // Fetch Stored Game Data
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Game" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    NSError *error = nil;
    _gameFetchResults = [self.managedObjectContext executeFetchRequest:fetchRequest error:&error];
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_gameFetchResults count];;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GameHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GameTableViewCell"];
    
    Game *game = (Game *) [_gameFetchResults objectAtIndex:indexPath.row];
    
    Team *homeTeam = (Team *) [game.teams firstObject];
    Team *awayTeam = (Team *) [game.teams lastObject];
    
    cell.homeTeamNameLabel.text = homeTeam.teamName;
    cell.homeTeamScoreLabel.text = [NSString stringWithFormat:@"%d", [[homeTeam getTeamTotalPoints] intValue]];
    cell.awayTeamNameLabel.text = awayTeam.teamName;
    cell.awayTeamScoreLabel.text = [NSString stringWithFormat:@"%d", [[awayTeam getTeamTotalPoints] intValue]];
    cell.dateLabel.text = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:game.date]];
    cell.timeLabel.text = [NSString stringWithFormat:@"%@", [timeFormatter stringFromDate:game.date]];
    
    [cell setUpCell];
    
    return (UITableViewCell *) cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 150.0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GameOverviewViewController *vc = [self.storyboard instantiateViewControllerWithIdentifier:@"GameOverviewViewController"];
    vc.managedObjectContext = self.managedObjectContext;
    Game *game = (Game *) [_gameFetchResults objectAtIndex:indexPath.row];
    vc.game = game;
    vc.homeTeam = (Team *) [game.teams firstObject];
    vc.awayTeam = (Team *) [game.teams lastObject];
    
    [self presentViewController:vc animated:YES completion:nil];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Search Controller Delegate and Search Results Delegate 

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController {

    NSString *searchString = self.searchController.searchBar.text;

    [self updateSearchContentForTeamName:searchString];
    
    if (self.searchController.searchResultsController) {
        UINavigationController *navController = (UINavigationController *) self.searchController.searchResultsController;
        
        SearchResultsTableViewController *vc = (SearchResultsTableViewController *)navController.topViewController;
        vc.gameSearchResults = self.gameSearchResults;
        vc.managedObjectContext = self.managedObjectContext;
        
        [vc.tableView reloadData];
    }
    
}

- (void)updateSearchContentForTeamName:(NSString *)teamName {
    
    if (teamName == nil) {
        self.gameSearchResults = [self.gameFetchResults mutableCopy];
    } else {
        
        NSPredicate *teamNamePredicate = [NSPredicate predicateWithFormat:@"ANY teams.teamName CONTAINS[c] %@", teamName];
        _gameSearchResults = [_gameFetchResults filteredArrayUsingPredicate:teamNamePredicate];

    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"newGame"]) {
        UINavigationController *nc = (UINavigationController *) segue.destinationViewController;
        CreateNewGameRootViewController *vc = (CreateNewGameRootViewController *) nc.topViewController;
        
        vc.managedObjectContext = self.managedObjectContext;
    }
}

@end
