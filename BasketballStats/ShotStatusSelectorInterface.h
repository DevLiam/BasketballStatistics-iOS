//
//  ShotStatusSelectorInterface.h
//  BasketballStats
//
//  Created by Liam Andrew on 26/06/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatSelectorBaseView.h"

@class StatSelectorBaseView;

@interface ShotStatusSelectorInterface : UIView

@property (nonatomic) StatSelectorBaseView *baseView;
@property (nonatomic) int points;

@property (weak, nonatomic) IBOutlet UIButton *missButton;
@property (weak, nonatomic) IBOutlet UIButton *makeButton;


@end
