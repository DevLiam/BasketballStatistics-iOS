//
//  AddPlayersViewController.h
//  BasketballStats
//
//  Created by Liam Andrew on 5/06/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import "CreateGameViewController.h"
#import <UIKit/UIKit.h>
#import "RoundedView.h"

@protocol PlayerAddDelegate;

@class Player;

@interface AddPlayersViewController : CreateGameViewController <UIPickerViewDataSource, UIPickerViewDelegate, UITextFieldDelegate, UIAlertViewDelegate>


@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *numberTextField;
@property (weak, nonatomic) IBOutlet UIPickerView *teamSelectPickerView;
@property (weak, nonatomic) IBOutlet RoundedButton *confirmPlayerButton;

@property (nonatomic) Player *player;
@property (nonatomic) NSArray *teamNamesArray;
@property (nonatomic, unsafe_unretained) id <PlayerAddDelegate> playerAddDelegate;


@end


@protocol PlayerAddDelegate <NSObject>

- (void)addPlayerViewController:(AddPlayersViewController *) addPlayerViewController didAddConfirmPlayer:(BOOL)confirm;

@end