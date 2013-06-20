//
//  SandikTabBarViewController.h
//  e-Sandik
//
//  Created by Alperen Kavun on 08.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Voter;

@interface SandikTabBarViewController : UITabBarController <UIAlertViewDelegate>

@property (nonatomic, strong) Voter* voter;

@end
