//
//  RoundedButton.h
//  FitnessSocial
//
//  Created by Liam Andrew on 15/05/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface RoundedButton : UIButton

@property (strong, nonatomic) UIColor *normalColor;
@property (strong, nonatomic) UIColor *highlightedColor;

- (void) setProperties;
- (void) setRoundedCorners;
- (void) setRoundedCornersWithFloat:(CGFloat) f;

@end
