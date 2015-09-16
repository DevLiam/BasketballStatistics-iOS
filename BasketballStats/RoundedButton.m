//
//  RoundedButton.m
//  FitnessSocial
//
//  Created by Liam Andrew on 15/05/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import "RoundedButton.h"

@implementation RoundedButton

#pragma mark Class Methods

- (void) setProperties {
    self.normalColor = self.backgroundColor;
    self.highlightedColor = [self darkerColorForColor:self.normalColor];
    self.adjustsImageWhenHighlighted = NO;
}

- (void) setRoundedCorners {
    
    // Make the corners of the button round
    self.layer.cornerRadius = 3.0;
    self.layer.masksToBounds = YES;
    
}

- (void) setRoundedCornersWithFloat:(CGFloat) f{
    
    // Make the corners of the button round
    self.layer.cornerRadius = f;
    self.layer.masksToBounds = YES;
}

- (void)setHighlighted:(BOOL)highlighted {
    
    if (highlighted) {
        self.backgroundColor = self.highlightedColor;
    } else {
        self.backgroundColor = self.normalColor;
    }
}


#pragma mark Color Adjustment Functions

- (UIColor *)darkerColorForColor:(UIColor *)c
{
    CGFloat r, g, b, a;
    if ([c getRed:&r green:&g blue:&b alpha:&a])
        return [UIColor colorWithRed:MAX(r - 0.2, 0.0)
                               green:MAX(g - 0.2, 0.0)
                                blue:MAX(b - 0.2, 0.0)
                               alpha:a];
    return nil;
}

- (UIColor *)lighterColorForColor:(UIColor *)c
{
    CGFloat r, g, b, a;
    if ([c getRed:&r green:&g blue:&b alpha:&a])
        return [UIColor colorWithRed:MIN(r + 0.2, 1.0)
                               green:MIN(g + 0.2, 1.0)
                                blue:MIN(b + 0.2, 1.0)
                               alpha:a];
    return nil;
}

@end
