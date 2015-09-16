//
//  PDFViewController.h
//  BasketballStats
//
//  Created by Liam Andrew on 1/07/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <CoreGraphics/CoreGraphics.h>
#import <QuartzCore/QuartzCore.h>
#import <MessageUI/MessageUI.h>
#import <MessageUI/MFMailComposeViewController.h>
#import "Game.h"
#import "Team.h"
#import "Player.h"
#import "Period.h"
#import "Statistics.h"
#import "PDFObject.h"

@interface PDFViewController : UIViewController <MFMailComposeViewControllerDelegate, UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UIBarButtonItem *backButton;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *emailButton;
@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (nonatomic) Game *game;
@property (nonatomic) PDFObject *pdfObject;
@property (nonatomic) UIAlertView *mailAlert;

- (void) showPDFFile;

@end
