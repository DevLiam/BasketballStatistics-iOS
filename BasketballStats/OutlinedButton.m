//
//  OutlinedButton.m
//  FitnessSocial
//
//  Created by Liam Andrew on 15/05/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import "OutlinedButton.h"

@implementation OutlinedButton

- (void)setOutlineProperties {
    UIColor *tempColor = self.backgroundColor;
    
    self.backgroundColor = [UIColor clearColor];
    
    self.layer.borderWidth = 1.5f;
    self.layer.borderColor = tempColor.CGColor;
    
}

- (UIColor *)darkerColorForColor:(UIColor *)c {
    return [UIColor colorWithRed:0.1f green:0.1f blue:0.1f alpha:0.5f];
}


- (void)setHighlighted:(BOOL)highlighted {
    if (highlighted) {
        self.backgroundColor = self.highlightedColor;
    } else {
        self.backgroundColor = [UIColor clearColor];
    }
}

@end
