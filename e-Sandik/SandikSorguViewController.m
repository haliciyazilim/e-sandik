//
//  SandikSorguViewController.m
//  e-Sandik
//
//  Created by Alperen Kavun on 08.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import "SandikSorguViewController.h"

#import "SandikTabBarViewController.h"

@interface SandikSorguViewController ()

@end

@implementation SandikSorguViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewWillAppear:(BOOL)animated {
//    UINavigationBar *navBar = self.navigationController.navigationBar;
//    UIImage *image = [UIImage imageNamed:@"header_bg.png"];
//    UIImage *shadowImage = [UIImage imageNamed:@"header_shadow.png"];
//    [navBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
//    [navBar setShadowImage:shadowImage];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    if(textField == self.tckNoTextField){
        [textField resignFirstResponder];
    }
    return YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowQueryResult"]) {
//        SandikTabBarViewController *sandikTabBarViewController = [segue destinationViewController];
        
    
        
        
    //    detailViewController.sighting = [self.dataController objectInListAtIndex:[self.tableView indexPathForSelectedRow].row];
    }
    [self.tckNoTextField setText:@""];
}

@end
