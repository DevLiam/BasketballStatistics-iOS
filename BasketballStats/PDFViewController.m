//
//  PDFViewController.m
//  BasketballStats
//
//  Created by Liam Andrew on 1/07/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import "PDFViewController.h"

@interface PDFViewController ()

@end

@implementation PDFViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    NSString *filename = [self getPDFFileName];
    
    self.pdfObject = [[PDFObject alloc] initWithGameObject:self.game andFileName:filename];
    
    [self showPDFFile];
    
    self.mailAlert = [[UIAlertView alloc] initWithTitle:nil message:@"" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

#pragma mark Button Functions

- (IBAction)backButtonAction:(UIBarButtonItem *)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)emailButtonAction:(UIBarButtonItem *)sender {
    
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *mail = [[MFMailComposeViewController alloc] init];
        mail.mailComposeDelegate = self;
        [mail setSubject:[NSString stringWithFormat:@"Simple Basketball Statistics"]];
        [mail setMessageBody: [NSString stringWithFormat:@"%@ vs. %@", [[self.game.teams firstObject] teamName], [[self.game.teams lastObject] teamName]] isHTML:NO];
        
        NSString *filePath = [self getPDFFileName];
        NSData *fileData = [NSData dataWithContentsOfFile:filePath];
        [mail addAttachmentData:fileData mimeType:@"application/pdf" fileName: [self getPDFFileName]];
        
        [self presentViewController:mail animated:YES completion:nil];
    } else {
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:@"This device cannot send emails." delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [alert show];
    }
   
}

#pragma mark PDF Functions

- (NSString *)getPDFFileName {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy.MM.DD"];
    
    NSDateFormatter *timeFormatter = [[NSDateFormatter alloc] init];
    [timeFormatter setDateFormat:@"hh.mm"];
    
    
    NSString *fileName = [NSString stringWithFormat:@"SBS_%@_%@.PDF", [dateFormatter stringFromDate:self.game.date], [timeFormatter stringFromDate:self.game.date]];
    
    NSArray *arrayPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *path = [arrayPaths objectAtIndex:0];
    NSString *pdfFileName = [path stringByAppendingPathComponent:fileName];
    
    return pdfFileName;
}

- (void) showPDFFile {
    NSString *fileName = [self getPDFFileName];
    
    NSURL *url = [NSURL fileURLWithPath:fileName];
   
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    
    [self.webView setScalesPageToFit:YES];
    
    [self.webView loadRequest:request];
   
    
}

#pragma mark - Mail Delegate 

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    switch (result) {
        case MFMailComposeResultSent:
            [self.mailAlert setMessage:@"Email Sent."];
            [self.mailAlert show];
            break;
        case MFMailComposeResultSaved:
            [self.mailAlert setMessage:@"Email Saved."];
            [self.mailAlert show];
            break;
        case MFMailComposeResultCancelled:
            [self.mailAlert setMessage:@"Email Cancelled."];
            [self.mailAlert show];
            break;
        case MFMailComposeResultFailed:
            [self.mailAlert setMessage:@"Email Failed."];
            [self.mailAlert show];
            break;
        default:
            [self.mailAlert setMessage:@"Error occurred."];
            [self.mailAlert show];
            break;
    }
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
    if (alertView == self.mailAlert) {
        [self dismissViewControllerAnimated:YES completion:NULL];
    }
}




@end
