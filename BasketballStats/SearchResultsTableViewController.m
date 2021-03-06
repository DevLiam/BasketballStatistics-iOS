//
//  SearchResultsTableViewController.m
//  BasketballStats
//
//  Created by Liam Andrew on 8/07/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import "SearchResultsTableViewController.h"
#import "GameOverviewViewController.h"
#import "Game.h"
#import "Team.h"

@interface SearchResultsTableViewController () {
    NSDateFormatter *dateFormatter;
    NSDateFormatter *timeFormatter;
}

@end

@implementation SearchResultsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tableView.contentInset = UIEdgeInsetsMake(150, 0, 0, 0);
    
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"hh:mm"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [_gameSearchResults count];;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    GameHomeTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GameTableViewCell"];
    
    Game *game = (Game *) [self.gameSearchResults objectAtIndex:indexPath.row];
    
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
    Game *game = (Game *) [self.gameSearchResults objectAtIndex:indexPath.row];
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
