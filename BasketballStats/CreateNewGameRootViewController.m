//
//  CreateNewGameRootViewController.m
//  BasketballStats
//
//  Created by Liam Andrew on 29/05/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import "CreateNewGameRootViewController.h"
#import "TeamOptionsViewController.h"
#import "AppDelegate.h"

@interface CreateNewGameRootViewController () {
    BOOL userLocationShown;
    double locationLongitude;
    double locationLatitude;
    NSDateFormatter *dateFormatter;
    NSDateFormatter *timeFormatter;
}

@end

@implementation CreateNewGameRootViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Check to see if there is a current managed object context
    if (!self.managedObjectContext) {
        NSLog(@"Creating Managed Object Context");
        AppDelegate *ad = [[UIApplication sharedApplication] delegate];
        self.managedObjectContext = ad.managedObjectContext;
    }
    
    userLocationShown = NO;
    
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    self.pointAnnotation = [[MKPointAnnotation alloc] init];
    self.pointAnnotation.title = @"Game Location";
    [self.mapView addAnnotation: self.pointAnnotation];
    
    [self.locationManager startUpdatingLocation]; // Perform update once
    
    // Add Gesture Recognizer to Map view in order to move the pin
    UIPanGestureRecognizer *panGesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didDragMap:)];
    panGesture.delegate = self;
    [self.mapView addGestureRecognizer:panGesture];
    
    // Set up the game core data object if it doesnt exist
    if (!self.game) {
        NSLog(@"Creating New Game Object");
        self.game = (Game *) [NSEntityDescription insertNewObjectForEntityForName:@"Game" inManagedObjectContext:self.managedObjectContext];
        self.game.gameStarted = [NSNumber numberWithBool:NO];
        self.game.currentPeriod = [NSNumber numberWithInt:0];
        self.game.numberOfPeriods = [NSNumber numberWithInt:2];
        self.game.structureHalves = [NSNumber numberWithBool:YES];
        self.game.recordHomeTeamStats = [NSNumber numberWithBool:YES];
        self.game.recordAwayTeamStats = [NSNumber numberWithBool:YES];
        self.game.date = self.datePicker.date;
        
        // Home Team
        Team *homeTeam = (Team *) [NSEntityDescription insertNewObjectForEntityForName:@"Team" inManagedObjectContext:self.managedObjectContext];
        homeTeam.teamName = @"";
        [self.game addTeamsObject:homeTeam];
        
        
        // Away Team
        Team *awayTeam = (Team *) [NSEntityDescription insertNewObjectForEntityForName:@"Team" inManagedObjectContext:self.managedObjectContext];
        awayTeam.teamName = @"";
        [self.game addTeamsObject:awayTeam];
        
    } else {
        [self setPointAnnotationLocation: CLLocationCoordinate2DMake([self.game.locationLatitude doubleValue], [self.game.locationLongitude doubleValue])];
        MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(CLLocationCoordinate2DMake([self.game.locationLatitude doubleValue], [self.game.locationLongitude doubleValue]), 1000, 1000);
        [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
        self.datePicker.date = self.game.date;
    }
    
    
    // Set up date and time formatter
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"HH:mm:ss"];
    
    
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        // TODO: handle the error appropriately
    }
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    [self.locationManager stopUpdatingLocation];
}

#pragma mark Button Functions

- (IBAction)cancelButtonAction:(UIBarButtonItem *)sender {
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Are you sure?" message:@"Cancelling will delete all progress." delegate:self cancelButtonTitle:@"No" otherButtonTitles:@"Yes", nil];
    [alert show];
    
}

#pragma mark Alert View Delegate

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (buttonIndex == 1) {
        [self.managedObjectContext deleteObject:self.game];
        NSError *error;
        if (![self.managedObjectContext save:&error]) {
            NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
            // TODO: handle the error appropriately
        }
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    } 
}

#pragma mark Map View Delegate

- (void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation {
    if (userLocationShown) {
        return;
    }
    NSLog(@"Update user location");
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(userLocation.coordinate, 1000, 1000);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
    self.game.locationLongitude = [NSNumber numberWithDouble:self.pointAnnotation.coordinate.longitude];
    self.game.locationLatitude = [NSNumber numberWithDouble:self.pointAnnotation.coordinate.latitude];
    
    [self setPointAnnotationLocation: CLLocationCoordinate2DMake(userLocation.coordinate.latitude, userLocation.coordinate.longitude)];
    
    [self.locationManager stopUpdatingLocation]; //Only want to the the user location once to display an accurate pin, then stop updating.
    
    userLocationShown = YES;
    
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        // TODO: handle the error appropriately
    }
}

-(void)mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated {
    self.pointAnnotation.coordinate = mapView.centerCoordinate;
    
    self.game.locationLongitude = [NSNumber numberWithDouble:self.pointAnnotation.coordinate.longitude];
    self.game.locationLatitude = [NSNumber numberWithDouble:self.pointAnnotation.coordinate.latitude];
    
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        // TODO: handle the error appropriately
    }
}

- (void) setPointAnnotationLocation: (CLLocationCoordinate2D)location {
    [self.pointAnnotation setCoordinate:location];
}

#pragma mark Gesture Recognizer 

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    return YES;
}

- (void)didDragMap: (UIGestureRecognizer *) gestureRecognizer {
    self.pointAnnotation.coordinate = self.mapView.centerCoordinate;
}

#pragma mark Navigation 

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier  isEqualToString:@"nextOptions"]) {
        
        TeamOptionsViewController *vc = (TeamOptionsViewController *) segue.destinationViewController;
        vc.game = self.game;
        vc.managedObjectContext = self.managedObjectContext;
        vc.gameDelegate = self;
        
    }
}

#pragma mark Date Picker 

- (IBAction)datePickerChanged:(UIDatePicker *)sender {
    self.game.date = sender.date;    
    
    NSError *error;
    if (![self.managedObjectContext save:&error]) {
        NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
        // TODO: handle the error appropriately
    }
}




@end
