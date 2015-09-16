//
//  RoundedView.m
//  FitnessSocial
//
//  Created by Liam Andrew on 15/05/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import "RoundedView.h"

@implementation RoundedView

- (void) setRoundedCorners {
    
    // Make the corners of the button round
    self.layer.cornerRadius = 2.0;
    self.layer.masksToBounds = YES;
    
}

- (void) setRoundedCornersWithFloat:(CGFloat) f{
    
    // Make the corners of the button round
    self.layer.cornerRadius = f;
    self.layer.masksToBounds = YES;
}

- (void)setOutline {
    
    UIColor *color = self.backgroundColor;
    
    self.backgroundColor = [UIColor clearColor];
    
    // Make an outline for the button and set the color to the background
    self.layer.borderColor = color.CGColor;
    self.layer.borderWidth = 2.0f;
    
}


@end
