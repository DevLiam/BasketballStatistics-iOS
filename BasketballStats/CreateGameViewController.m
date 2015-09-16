//
//  CreateGameViewController.m
//  BasketballStats
//
//  Created by Liam Andrew on 9/07/2015.
//  Copyright (c) 2015 Liam Andrew. All rights reserved.
//

#import "CreateGameViewController.h"

@interface CreateGameViewController ()

@end

@implementation CreateGameViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setGameObjectOnPopover:(CreateGameViewController *) createGameViewController {
    self.game = createGameViewController.game;
    
    // Dismiss the view once the confirmation has been handled
    [self.navigationController popViewControllerAnimated:YES];
}

@end
