//
//  CreateNewGameRootViewController.h
//  BasketballStats
//
//  Created by Liam Andrew on 29/05/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import "CreateGameViewController.h"
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>





@interface CreateNewGameRootViewController : CreateGameViewController <MKMapViewDelegate, CLLocationManagerDelegate, UIGestureRecognizerDelegate, UIAlertViewDelegate>

@property (nonatomic) NSDate *gameDate;

@property (weak, nonatomic) IBOutlet UIBarButtonItem *cancelButton;
@property (weak, nonatomic) IBOutlet UIDatePicker *datePicker;
@property (weak, nonatomic) IBOutlet MKMapView *mapView;
@property (strong, nonatomic) CLLocationManager *locationManager;
@property (nonatomic) MKPointAnnotation *pointAnnotation;



@end
