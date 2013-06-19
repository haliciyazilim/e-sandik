//
//  SandikSorguViewController.h
//  e-Sandik
//
//  Created by Alperen Kavun on 08.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SandikSorguViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic) NSString* currentUsername;
@property (nonatomic) NSString* currentPassword;
@property (nonatomic) NSString* currentTckNo;
@property (weak, nonatomic) IBOutlet UITextField *tckNoTextField;
@property (nonatomic, strong) UIAlertView* loadingAlert;

- (IBAction)performQuery:(id)sender;

@end
