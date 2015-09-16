//
//  TeamOptionsViewController.h
//  BasketballStats
//
//  Created by Liam Andrew on 5/06/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import "CreateGameViewController.h"
#import <UIKit/UIKit.h>
#import "RoundedView.h"

@interface TeamOptionsViewController : CreateGameViewController <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, UIAlertViewDelegate>

@property (nonatomic) NSDate *gameDate;

@property (weak, nonatomic) IBOutlet RoundedView *homeTeamView;
@property (weak, nonatomic) IBOutlet UITextField *homeTeamNameTextField;
@property (weak, nonatomic) IBOutlet RoundedView *awayTeamView;
@property (weak, nonatomic) IBOutlet UITextField *awayTeamNameTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *gameStateOptionPickerView;
@property (weak, nonatomic) IBOutlet UIPickerView *gameStructureOptionsPickerView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;


@end
