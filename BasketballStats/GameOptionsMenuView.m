//
//  GameOptionsMenuView.m
//  BasketballStats
//
//  Created by Liam Andrew on 27/06/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import "GameOptionsMenuView.h"

@implementation GameOptionsMenuView {
    BOOL isShown;
}


- (id) initWithFrame:(CGRect)frame andParentViewController: (GameStatisticsViewController *) vc {
    if (self = [super initWithFrame:frame]) {
        
        self.hidden = YES;
        isShown = NO;
        self.parentController = vc;
        
        // Background Shadow View
        self.backgroundView = [[UIView alloc] initWithFrame:frame];
        self.backgroundView.backgroundColor = [UIColor colorWithRed:0.2 green:0.2 blue:0.2 alpha:0.75];
        self.backgroundView.hidden = YES;
        [self addSubview:self.backgroundView];
        
        // Game Options Interface
        self.gameOptionsInterface = [[[NSBundle mainBundle] loadNibNamed:@"GameOptionsInterface" owner:nil options:nil]lastObject];
        self.gameOptionsInterface.frame = CGRectMake(0, self.frame.size.height + self.gameOptionsInterface.frame.size.height, frame.size.width, self.gameOptionsInterface.frame.size.height);
        self.gameOptionsInterface.baseView = self;
        [self.gameOptionsInterface setUpButtons];
        [self addSubview:self.gameOptionsInterface];
    }
    return self;
}

- (void)presentView {
    if (!isShown) {
        self.hidden = NO;
        self.backgroundView.hidden = NO;
        [self setNextPeriodButton];
        [self animateGameOptionsInterfaceToPoint:CGPointMake(0, self.frame.size.height - self.gameOptionsInterface.frame.size.height) interface:self.gameOptionsInterface];
        isShown = YES;
    }
}

- (void)hideView {
    if (isShown) {
        self.backgroundView.hidden = YES;
        [self animateGameOptionsInterfaceToPoint:CGPointMake(0, self.frame.size.height + self.gameOptionsInterface.frame.size.height) interface:self.gameOptionsInterface];
        isShown = NO;
    }
}

- (void) animateGameOptionsInterfaceToPoint:(CGPoint)point interface: (UIView *) view{
    [UIView animateWithDuration: 0.3
                          delay: 0.0
                        options: UIViewAnimationOptionCurveEaseOut
                     animations: ^{
                         [view setFrame:CGRectMake(point.x, point.y, view.frame.size.width, view.frame.size.height)];
                     } completion: ^(BOOL finished) {
                         if (!isShown) {
                             self.hidden = true;
                         }
                     }];
}

#pragma mark Touch Functions

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    
    CGPoint point = [[touches anyObject] locationInView:self];
    
    if (self.backgroundView == [self hitTest:point withEvent:event]) {
        if (isShown) {
            [self hideView];
        }
    }
    
}

- (void) setNextPeriodButton {
    if ([self.parentController.game.structureHalves boolValue]) {
        switch ([self.parentController.game.currentPeriod intValue]) {
            case 0:
                [self.gameOptionsInterface setNextPeriodButton:[NSString stringWithFormat:@"Enter 2nd Half"]];
                break;
            case 1:
                [self.gameOptionsInterface setNextPeriodButton:[NSString stringWithFormat:@"Enter Overtime"]];
                break;
            default:
                [self.gameOptionsInterface setNextPeriodButton:[NSString stringWithFormat:@"Enter Overtime"]];
                break;
        }
    } else {
        switch ([self.parentController.game.currentPeriod intValue]) {
            case 0:
                [self.gameOptionsInterface setNextPeriodButton:[NSString stringWithFormat:@"Enter 2nd Quarter"]];
                break;
            case 1:
                [self.gameOptionsInterface setNextPeriodButton:[NSString stringWithFormat:@"Enter 3nd Quarter"]];
                break;
            case 2:
                [self.gameOptionsInterface setNextPeriodButton:[NSString stringWithFormat:@"Enter 4nd Quarter"]];
                break;
            case 3:
                [self.gameOptionsInterface setNextPeriodButton:[NSString stringWithFormat:@"Enter Overtime"]];
                break;
            default:
                [self.gameOptionsInterface setNextPeriodButton:[NSString stringWithFormat:@"Enter Overtime"]];
                break;
        }
    }
}

@end
