//
//  OverviewLocationDateViewController.m
//  BasketballStats
//
//  Created by Liam Andrew on 10/06/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import "OverviewLocationDateViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface OverviewLocationDateViewController (){
    NSDateFormatter *dateFormatter;
    NSDateFormatter *timeFormatter;
}

@end

@implementation OverviewLocationDateViewController 

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Set up date and time formatter
    dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy/MM/dd"];
    timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"hh:mm"];
    
    // Map View
    self.mapView.clipsToBounds = YES;
    self.mapView.layer.masksToBounds = YES;
    self.mapView.layer.cornerRadius = self.mapView.frame.size.width / 2.0;
    self.mapView.userInteractionEnabled = NO;
    
    // Set Label names
    self.homeTeamNameLabel.text = self.homeTeam.teamName;
    self.homeTeamScoreLabel.text = [NSString stringWithFormat:@"%d", [[self.homeTeam getTeamTotalPoints] intValue]];
    self.awayTeamNameLabel.text = self.awayTeam.teamName;
    self.awayTeamScoreLabel.text = [NSString stringWithFormat:@"%d", [[self.awayTeam getTeamTotalPoints] intValue]];
    self.gameDateLabel.text = [NSString stringWithFormat:@"%@", [dateFormatter stringFromDate:self.game.date]];
    self.gameTimeLabel.text = [NSString stringWithFormat:@"%@", [timeFormatter stringFromDate:self.game.date]];
    
    // Set Point for game location
    MKPointAnnotation *point = [[MKPointAnnotation alloc] init];
    point.coordinate = CLLocationCoordinate2DMake([self.game.locationLatitude doubleValue], [self.game.locationLongitude doubleValue]);
    [self.mapView addAnnotation:point];
    
    // Zoom in on the point
    MKCoordinateRegion region = MKCoordinateRegionMakeWithDistance(point.coordinate, 1300, 1300);
    [self.mapView setRegion:[self.mapView regionThatFits:region] animated:YES];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark Button Action

- (IBAction)backButtonAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
