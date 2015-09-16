//
//  ReboundSelectorInterface.h
//  BasketballStats
//
//  Created by Liam Andrew on 25/06/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatSelectorBaseView.h"

@class StatSelectorBaseView;

@interface ReboundSelectorInterface : UIView

@property StatSelectorBaseView *baseView;

@property (weak, nonatomic) IBOutlet UIButton *defensiveReboundButton;
@property (weak, nonatomic) IBOutlet UIButton *offensiveReboundButton;


@end
