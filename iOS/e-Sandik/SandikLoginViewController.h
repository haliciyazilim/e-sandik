//
//  SandikLoginViewController.h
//  e-Sandık
//
//  Created by Alperen Kavun on 10.06.2013.
//  Copyright (c) 2013 Halıcı. All rights reserved.
//

#import <UIKit/UIKit.h>

#define ENCRYPTION_KEY @"8iQ-2[,f5^x"
#define USER_DEFAULTS_KEY_USERNAME @"usernameKey"
#define USER_DEFAULTS_KEY_PASSWORD @"passwordKey"

@interface SandikLoginViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;

- (IBAction)checkLogin:(id)sender;
@end
