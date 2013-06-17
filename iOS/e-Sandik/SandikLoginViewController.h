//
//  SandikLoginViewController.h
//  e-Sandık
//
//  Created by Alperen Kavun on 10.06.2013.
//  Copyright (c) 2013 Halıcı. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SandikLoginViewController : UIViewController <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *usernameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;

- (IBAction)checkLogin:(id)sender;
@end
