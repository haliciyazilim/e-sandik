//
//  SandikTabBarViewController.m
//  e-Sandik
//
//  Created by Alperen Kavun on 08.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import "SandikTabBarViewController.h"

#import "SandikKunyeViewController.h"

@interface SandikTabBarViewController ()

@end

@implementation SandikTabBarViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    UINavigationItem *navItem = self.navigationItem;
    navItem.backBarButtonItem.tintColor = [UIColor clearColor];
}

- (void)viewWillAppear:(BOOL)animated {
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setVoter:(Voter *)voter {
    SandikKunyeViewController *sandikKunyeViewController = [self.viewControllers objectAtIndex:0];
    sandikKunyeViewController.voter = voter;
}

@end
