//
//  TeamOptionsViewController.m
//  BasketballStats
//
//  Created by Liam Andrew on 5/06/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import "TeamOptionsViewController.h"
#import "TeamOverviewViewController.h"

@interface TeamOptionsViewController () {
    NSArray *statOptionsArray;
    NSArray *gameStuctureOptionsArray;
    NSInteger *statPickerViewIndex;
    NSInteger *gameOptionsPickerViewIndex;
    BOOL structureHalves;
}

@end

@implementation TeamOptionsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    statOptionsArray = [[NSArray alloc] initWithObjects:@"Both Teams", @"Only the Home Team", @"Only the Away Team", nil];
    gameStuctureOptionsArray = [[NSArray alloc] initWithObjects:@"Halves", @"Quarters", nil];
    statPickerViewIndex = 0;
    gameOptionsPickerViewIndex = 0;
    

    self.homeTeamNameTextField.text = [NSString stringWithFormat:@"%@", [[self.game.teams firstObject] teamName]];
    self.awayTeamNameTextField.text = [NSString stringWithFormat:@"%@", [[self.game.teams lastObject] teamName]];
    
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        // TODO: handle the error appropriately
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.homeTeamNameTextField.text = [NSString stringWithFormat:@"%@", [[self.game.teams firstObject] teamName]];
    self.awayTeamNameTextField.text = [NSString stringWithFormat:@"%@", [[self.game.teams lastObject] teamName]];
}


#pragma mark - Navigation

- (BOOL)shouldPerformSegueWithIdentifier:(NSString *)identifier sender:(id)sender {
    
    if ([identifier isEqualToString:@"TeamOverview"]) {
        if ([self.homeTeamNameTextField.text isEqualToString:@""]) {
            
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter a home team name." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
            return NO;
        } else if ([self.awayTeamNameTextField.text isEqualToString:@""]){
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter a away team name." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            
            return NO;
        }
    }
    
    return YES;
}

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        // TODO: handle the error appropriately
    }
    
    if ([segue.identifier isEqualToString:@"TeamOverview"]) {
        
        TeamOverviewViewController *vc = (TeamOverviewViewController *) segue.destinationViewController;
        
        vc.game = self.game;
        vc.managedObjectContext = self.managedObjectContext;
        vc.gameDelegate = self;
    }
    
}


#pragma mark Picker View

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (pickerView == self.gameStateOptionPickerView) {
        return [statOptionsArray objectAtIndex:row];
    } else {
        return [gameStuctureOptionsArray objectAtIndex:row];
    }
    
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (pickerView == self.gameStateOptionPickerView) {
        return [statOptionsArray count];
    } else {
        return [gameStuctureOptionsArray count];
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (pickerView == self.gameStateOptionPickerView) {
        
        if ((int)row == 0) {

            self.game.recordHomeTeamStats = [NSNumber numberWithBool:YES];
            self.game.recordAwayTeamStats = [NSNumber numberWithBool:YES];
            
        } else if ((int) row == 1) {

            self.game.recordHomeTeamStats = [NSNumber numberWithBool:YES];
            self.game.recordAwayTeamStats = [NSNumber numberWithBool:NO];
            
        } else {

            self.game.recordHomeTeamStats = [NSNumber numberWithBool:NO];
            self.game.recordAwayTeamStats = [NSNumber numberWithBool:YES];
        }
    } else {
        
        if ((int) row == 0) {
            self.game.structureHalves = [NSNumber numberWithBool:YES];
            self.game.numberOfPeriods = [NSNumber numberWithInt:2];
        } else {
            self.game.structureHalves = [NSNumber numberWithBool:NO];
            self.game.numberOfPeriods = [NSNumber numberWithInt:4];
        }
        
    }
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        // TODO: handle the error appropriately
    }
    

    
}

#pragma mark UITextField Delegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (IBAction)homeTeamNameChanged:(UITextField *)sender {

    [[self.game.teams firstObject] setTeamName:sender.text];
}

- (IBAction)awayTeamNameChanged:(UITextField *)sender {
    [[self.game.teams lastObject] setTeamName:sender.text];
}

#pragma mark Button Function

- (IBAction)backButtonAction:(UIBarButtonItem *)sender {
//    [self.navigationController popViewControllerAnimated:YES];
    [self.gameDelegate setGameObjectOnPopover:self];
}



@end
