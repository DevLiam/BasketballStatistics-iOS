//
//  StatSelectorInterface.h
//  BasketballStats
//
//  Created by Liam Andrew on 24/06/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatSelectorBaseView.h"

@class StatSelectorBaseView;

@interface StatSelectorInterface : UIView

@property (nonatomic) StatSelectorBaseView *baseView;

@property (weak, nonatomic) IBOutlet UIButton *turnoverButton;
@property (weak, nonatomic) IBOutlet UIButton *stealButton;
@property (weak, nonatomic) IBOutlet UIButton *assistButton;
@property (weak, nonatomic) IBOutlet UIButton *shotButton;
@property (weak, nonatomic) IBOutlet UIButton *reboundButton;
@property (weak, nonatomic) IBOutlet UIButton *blockButton;
@property (weak, nonatomic) IBOutlet UIButton *foulButton;


@end
