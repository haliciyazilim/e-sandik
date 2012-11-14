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
    
    UIImage *image = [UIImage imageNamed:@"title_esandik.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    self.navigationItem.titleView = imageView;
}

- (void)viewWillAppear:(BOOL)animated {
    
//    [super viewDidAppear:animated];
//    
//    self.navigationController.navigationBar.topItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title_esandik.png"]];
    
//    UIImage *image = [UIImage imageNamed:@"header_bg.png"];
//    UIImage *shadowImage = [UIImage imageNamed:@"header_shadow.png"];
//    [navBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
//    [navBar setShadowImage:shadowImage];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification object:self.view.window];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:)
                                                 name:UIKeyboardWillHideNotification object:self.view.window];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textFieldDidChange:) name:UITextFieldTextDidChangeNotification object:self.tckNoTextField];

}

-(void)viewWillDisappear:(BOOL)animated
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UITextFieldTextDidChangeNotification object:nil];
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
- (void)textFieldDidBeginEditing:(UITextField *)textField {
    if (textField.text.length == 0) {
        textField.clearButtonMode = UITextFieldViewModeNever;
    }
    else {
        textField.clearButtonMode = UITextFieldViewModeAlways;
    }
}
- (void)textFieldDidChange:(NSNotification *)notif {
    if (self.tckNoTextField.text.length == 0) {
        self.tckNoTextField.clearButtonMode = UITextFieldViewModeNever;
    }
    else {
        self.tckNoTextField.clearButtonMode = UITextFieldViewModeAlways;
    }
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

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string {
    NSUInteger newLength = [textField.text length];
    return (newLength >= 11) ? NO : YES;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    if ([[segue identifier] isEqualToString:@"ShowQueryResult"]) {
        SandikTabBarViewController *sandikTabBarViewController = [segue destinationViewController];
        
        [[APIManager sharedInstance] getVoterWithTckNo:self.tckNoTextField.text
                                          onCompletion:^(Voter *voter) {
                                              sandikTabBarViewController.voter = voter;
                                              [sandikTabBarViewController dismissLoadingView];
                                          } onError:^(NSError *error) {
                                              
                                          }];
    }
    [self.tckNoTextField setText:@""];
    
    [self.tckNoTextField resignFirstResponder];
        
    
}

- (IBAction)performQuery:(id)sender {
    if ([self.tckNoTextField.text length] == 11){
        [self performSegueWithIdentifier:@"ShowQueryResult" sender:self];
    }
    else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Hata" message:@"Lütfen 11 haneli T.C. Kimlik numaranızı giriniz." delegate:self cancelButtonTitle:@"Tamam" otherButtonTitles:nil, nil];
        [alertView show];
    }
}
@end
