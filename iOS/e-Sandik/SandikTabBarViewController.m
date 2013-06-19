//
//  SandikTabBarViewController.m
//  e-Sandik
//
//  Created by Alperen Kavun on 08.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import "SandikTabBarViewController.h"

#import "SandikKunyeViewController.h"
#import "SandikBinaBilgisiViewController.h"
#import "SandikSecmenlerViewController.h"

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
    
}

- (void)viewWillAppear:(BOOL)animated {
    
    UIImage *titleImage = [UIImage imageNamed:@"title_secmenkunyesi.png"];
    UIImageView *titleImageView = [[UIImageView alloc] initWithImage:titleImage];
    
    self.navigationItem.titleView = titleImageView;
    
    SandikKunyeViewController *sandikKunyeViewController = [self.viewControllers objectAtIndex:0];
    [sandikKunyeViewController setIsFirst];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)setVoter:(Voter *)voter {
    SandikKunyeViewController *sandikKunyeViewController = [self.viewControllers objectAtIndex:0];
    sandikKunyeViewController.voter = voter;
    
    SandikBinaBilgisiViewController *sandikBinaBilgisiViewController = [self.viewControllers objectAtIndex:1];
    sandikBinaBilgisiViewController.voter = voter;
    
    SandikSecmenlerViewController *sandikSecmenlerViewController = [self.viewControllers objectAtIndex:2];
    sandikSecmenlerViewController.voter = voter;
}

@end
