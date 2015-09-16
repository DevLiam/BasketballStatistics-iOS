//
//  AddPlayersViewController.m
//  BasketballStats
//
//  Created by Liam Andrew on 5/06/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import "AddPlayersViewController.h"

@interface AddPlayersViewController ()

@end

@implementation AddPlayersViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.confirmPlayerButton setProperties];
    [self.confirmPlayerButton setRoundedCorners];
        
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    // Either create a new player or set the parameters to edit existing player
    if (!self.player) {
        NSLog(@"Creating a new Player.");
        
        self.player = (Player *) [NSEntityDescription insertNewObjectForEntityForName:@"Player" inManagedObjectContext:self.managedObjectContext];
        self.player.team = [self.game.teams firstObject];
    } else {
        NSLog(@"Player sent to scene");
    }
}

#pragma mark Text Field

- (IBAction)firstNameChanged:(UITextField *)sender {
    [self.player setFirstName:sender.text];
}

- (IBAction)lastNameChanged:(UITextField *)sender {
    [self.player setLastName:sender.text];
}

- (IBAction)playerNumberChanged:(UITextField *)sender {
    NSNumber *n = [NSNumber numberWithInteger:[sender.text integerValue]];
    [self.player setPlayerNumber: n];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

#pragma mark Picker View

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    
    return [self.teamNamesArray objectAtIndex:row];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return [self.teamNamesArray count];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {

    Team *team = [self.game.teams firstObject];
    if ([[self.teamNamesArray objectAtIndex:row] isEqualToString:team.teamName] && [self.game.recordHomeTeamStats boolValue]) {
        self.player.team = [self.game.teams firstObject];
    } else {
        self.player.team = [self.game.teams lastObject];
    }
}

#pragma mark Button Actions 

- (IBAction)confirmButtonAction:(RoundedButton *)sender {
    
    NSScanner *scanner = [NSScanner scannerWithString:self.numberTextField.text];
    int i;
    [scanner scanInt:&i];
    
    
    // Check to make sure that the textfields are appropriately entered
    if ([self.firstNameTextField.text isEqualToString:@""]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter a player first name" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
        
    } else if ([self.lastNameTextField.text isEqualToString:@""]) {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter a player last name" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    } else if ([scanner isAtEnd] && (i >= 0) && (![self.numberTextField.text isEqualToString:@""]) && [self.player isValidPlayer]) {
        [self.playerAddDelegate addPlayerViewController:self didAddConfirmPlayer:YES];
    } else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"Please enter a valid player number" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
}

- (IBAction)cancelButtonAction:(UIBarButtonItem *)sender {
    [self.playerAddDelegate addPlayerViewController:self didAddConfirmPlayer:NO];
}


@end
