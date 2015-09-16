//
//  GameOverviewViewController.m
//  BasketballStats
//
//  Created by Liam Andrew on 10/06/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import "GameOverviewViewController.h"
#import "OverviewLocationDateViewController.h"
#import "OverviewTopPlayersViewController.h"
#import "OverviewActionsViewController.h"

@interface GameOverviewViewController ()

@end

@implementation GameOverviewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Create model for page view identifiers
    self.pageIdentifierArray = @[@"OverviewLocationDateViewController", @"OverviewTopPlayersViewController", @"OverviewActionsViewController"];
    
    // Initiate Page View Controller
    self.pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"OverviewPageViewController"];
    self.pageViewController.dataSource = self;
    
    // Set the first view controller of page controller
    OverviewLocationDateViewController *locationViewController = (OverviewLocationDateViewController *) [self viewControllerAtIndex:0];
    NSArray *viewControllers = @[locationViewController];
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    // Change the frame/size of the page controller
    self.pageViewController.view.frame = CGRectMake(0, 5, self.view.frame.size.width, self.view.frame.size.height);
    
    // Set the page control properties
    UIPageControl *pageControl = [UIPageControl appearance];
    pageControl.pageIndicatorTintColor = [UIColor lightGrayColor];
    pageControl.currentPageIndicatorTintColor = [UIColor blackColor];
    pageControl.backgroundColor = [UIColor clearColor];
    pageControl.enabled = NO;
    
    [self addChildViewController:_pageViewController];
    [self.view addSubview:_pageViewController.view];
    
    [self.pageViewController didMoveToParentViewController:self];
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

#pragma mark Button Actions

- (IBAction)backButtonAction:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark Page View Controller

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSUInteger index = ((OverviewPageViewController *) viewController).pageIndex;
    
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex: index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSUInteger index = ((OverviewPageViewController *) viewController).pageIndex;
    
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageIdentifierArray count]) {
        return nil;
    }
    return [self viewControllerAtIndex: index];
}

- (UIViewController *)viewControllerAtIndex: (NSUInteger)index {
    
    if (([self.pageIdentifierArray count] == 0) || (index >= [self.pageIdentifierArray count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data
    OverviewPageViewController *viewController;
    switch (index) {
        case 0:
            viewController = (OverviewLocationDateViewController *) [self.storyboard instantiateViewControllerWithIdentifier:self.pageIdentifierArray[index]];
            [viewController setPageIndex:index];
            viewController.game = self.game;
            viewController.homeTeam = self.homeTeam;
            viewController.awayTeam = self.awayTeam;
            viewController.managedObjectContext = self.managedObjectContext;
            return (UIViewController *) viewController;
        case 1:
            viewController = (OverviewTopPlayersViewController *) [self.storyboard instantiateViewControllerWithIdentifier:self.pageIdentifierArray[index]];
            [viewController setPageIndex:index];
            viewController.game = self.game;
            viewController.homeTeam = self.homeTeam;
            viewController.awayTeam = self.awayTeam;
            viewController.managedObjectContext = self.managedObjectContext;
            return (UIViewController *) viewController;
        case 2:
            viewController = (OverviewActionsViewController *) [self.storyboard instantiateViewControllerWithIdentifier:self.pageIdentifierArray[index]];
            [viewController setPageIndex:index];
            viewController.game = self.game;
            viewController.homeTeam = self.homeTeam;
            viewController.awayTeam = self.awayTeam;
            viewController.managedObjectContext = self.managedObjectContext;
            return (UIViewController *) viewController;
        default:
            NSLog(@"Shouldn't reach this code");
            return nil;
    }
}

- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController
{
    return [self.pageIdentifierArray count];
}

- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController
{
    return 0;
}

@end
