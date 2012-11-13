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
    
   
        
    self.loadingAlert = [[UIAlertView alloc] initWithTitle:@"Lütfen Bekleyiniz." message:@"Seçmen bilgileriniz yükleniyor.." delegate:self cancelButtonTitle:nil otherButtonTitles:nil, nil];
    NSLog(@"Here");
    UIActivityIndicatorView *myIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    myIndicator.hidesWhenStopped = YES;
    //    myIndicator.color = [UIColor colorWithRed:1.0 green:0 blue:0 alpha:1];
    [self.loadingAlert addSubview:myIndicator];
    [self.loadingAlert show];
    myIndicator.frame = CGRectMake(110, 64, 60, 60);
    [myIndicator startAnimating];
    
    
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

-(void)dismissLoadingView {
    [self.loadingAlert dismissWithClickedButtonIndex:-1 animated:YES];
}

@end
