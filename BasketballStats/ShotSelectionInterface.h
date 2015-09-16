//
//  ShotSelectionInterface.h
//  BasketballStats
//
//  Created by Liam Andrew on 25/06/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatSelectorBaseView.h"


@interface ShotSelectionInterface : UIView

@property (nonatomic) StatSelectorBaseView *baseView;

@property (weak, nonatomic) IBOutlet UIButton *freeThrowButton;
@property (weak, nonatomic) IBOutlet UIButton *fieldGoalButton;
@property (weak, nonatomic) IBOutlet UIButton *threeGoalButton;


@end
