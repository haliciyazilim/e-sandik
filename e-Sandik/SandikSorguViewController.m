//
//  SandikSorguViewController.m
//  e-Sandik
//
//  Created by Alperen Kavun on 08.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import "SandikSorguViewController.h"

#import "SandikTabBarViewController.h"
#import "APIManager.h"

@interface SandikSorguViewController ()

@end

@implementation SandikSorguViewController

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
    
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Geri"
                                                                   style:UIBarButtonItemStyleBordered
                                                                  target:self
                                                                  action:nil];
    UIImage *buttonImage = [UIImage imageNamed:@"btn_back_normal.png"];
    
    UIImage *hoverButtonImage = [UIImage imageNamed:@"btn_back_hover.png"];
    
    [backButton setBackButtonBackgroundImage:buttonImage
                                    forState:UIControlStateNormal
                                  barMetrics:UIBarMetricsDefault];
    
    [backButton setBackButtonBackgroundImage:hoverButtonImage
                                    forState:UIControlStateHighlighted
                                  barMetrics:UIBarMetricsDefault];
    
    self.navigationItem.backBarButtonItem = backButton;
}

- (void)viewWillAppear:(BOOL)animated {
//    UINavigationBar *navBar = self.navigationController.navigationBar;
    
    UINavigationItem *navItem = self.navigationItem;
    navItem.title = @"e-Sandık";
    
    
    
//    UIImage *image = [UIImage imageNamed:@"header_bg.png"];
//    UIImage *shadowImage = [UIImage imageNamed:@"header_shadow.png"];
//    [navBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
//    [navBar setShadowImage:shadowImage];
    
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:self.view.window];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:self.view.window];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
//    if(textField == self.tckNoTextField){
        [textField resignFirstResponder];
//    }
    return YES;
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.tckNoTextField resignFirstResponder];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    

    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField {

    
    return YES;
}

- (void)keyboardWillShow:(NSNotification *)notif {
    NSDictionary* userInfo = [notif userInfo];
    
    // Get animation info from userInfo
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    
    [UIView animateWithDuration:animationDuration
                     animations:^{
                         CGRect frame = self.view.frame;
                         frame.origin.y = -80;
                         [self.view setFrame:frame];
                     }];
}

- (void)keyboardWillHide:(NSNotification *)notif {
    NSDictionary* userInfo = [notif userInfo];
    
    // Get animation info from userInfo
    NSTimeInterval animationDuration;
    UIViewAnimationCurve animationCurve;
    
    [[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&animationCurve];
    [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] getValue:&animationDuration];
    
    [UIView animateWithDuration:animationDuration
                     animations:^{
                         CGRect frame = self.view.frame;
                         frame.origin.y = 0;
                         [self.view setFrame:frame];
                     }];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"ShowQueryResult"]) {
        SandikTabBarViewController *sandikTabBarViewController = [segue destinationViewController];
        
        [[APIManager sharedInstance] getVoterWithTckNo:[self.tckNoTextField.text intValue]
                                          onCompletion:^(Voter *voter) {
                                              sandikTabBarViewController.voter = voter;
                                          } onError:^(NSError *error) {
                                              
                                          }];
        
    //    detailViewController.sighting = [self.dataController objectInListAtIndex:[self.tableView indexPathForSelectedRow].row];
    }
    [self.tckNoTextField setText:@""];
    
    [self.tckNoTextField resignFirstResponder];
}

@end
