//
//  OverviewActionsViewController.m
//  BasketballStats
//
//  Created by Liam Andrew on 10/06/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import "OverviewActionsViewController.h"
#import "GameStatisticsNavigationViewController.h"
#import "GameStatisticsViewController.h"
#import "DetailedStatisticsViewController.h"
#import "TeamOverviewViewController.h"
#import "PDFViewController.h"

@interface OverviewActionsViewController ()

@end

@implementation OverviewActionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.continueGameButton setProperties];
    [self.continueGameButton setRoundedCorners];
    
    [self.viewStatisticsButton setProperties];
    [self.viewStatisticsButton setRoundedCorners];
    
    [self.exportStatisticsButton setProperties];
    [self.exportStatisticsButton setRoundedCorners];
    
    [self.deleteGameButton setProperties];
    [self.deleteGameButton setRoundedCorners];
    
    [self.addRemovePlayerButton setProperties];
    [self.addRemovePlayerButton setRoundedCorners];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Button Functions 

- (IBAction)continueGameButtonAction:(UIButton *)sender {
    GameStatisticsNavigationViewController *navController = (GameStatisticsNavigationViewController *) [self.storyboard instantiateViewControllerWithIdentifier:@"GameStatsNavigationController"];
    GameStatisticsViewController *vc = (GameStatisticsViewController *) navController.topViewController;
    vc.managedObjectContext = self.managedObjectContext;
    vc.game = self.game;
    
    [self presentViewController:navController animated:YES completion:nil];
}

- (IBAction)viewDetailedStatisticsButtonAction:(UIButton *)sender {
    NSLog(@"Present Detailed Statistics View");
//    DetailedStatisticsViewController *dvc = (DetailedStatisticsViewController *) [self.storyboard instantiateViewControllerWithIdentifier:@"DetailStatisticsViewController"];
    UINavigationController *dnvc = [self.storyboard instantiateViewControllerWithIdentifier:@"DetailNavigationController"];
    DetailedStatisticsViewController *dvc = (DetailedStatisticsViewController *) dnvc.topViewController;
    dvc.game = self.game;
    
    [self presentViewController:dnvc animated:YES completion:nil];
}

- (IBAction)exportStatisticsButtonAction:(UIButton *)sender {
}

- (IBAction)deleteButtonAction:(UIButton *)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Are you sure?" message:@"Deleting the game will destroy all data for this game." delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Confirm", nil];
    [alert show];
    
}

- (void)deleteGame {
    [self.managedObjectContext deleteObject:self.game];
    
    NSError *error;
    
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        // TODO: handle the error appropriately
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Navigation 

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([segue.identifier isEqualToString:@"exportStatistics"]) {
        UINavigationController *nc = (UINavigationController *) segue.destinationViewController;
        PDFViewController *vc = (PDFViewController *) nc.topViewController;
        vc.game = self.game;
    } else if ([segue.identifier isEqualToString:@"editPlayers"]) {
        UINavigationController *nvc = (UINavigationController *) segue.destinationViewController;
        
        TeamOverviewViewController *vc = (TeamOverviewViewController *) nvc.topViewController;
        vc.managedObjectContext = self.managedObjectContext;
        vc.game = self.game;
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self deleteGame];
    }
}

@end
