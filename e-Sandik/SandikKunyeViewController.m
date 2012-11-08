//
//  SandikKunyeViewController.m
//  e-Sandik
//
//  Created by Alperen Kavun on 08.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import "SandikKunyeViewController.h"

#import "Voter.h"

@interface SandikKunyeViewController ()
    
- (void)configureViews;

@end

@implementation SandikKunyeViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self configureViews];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setVoter:(Voter *)voter {
    if (_voter != voter) {
        _voter = voter;
    }
    
    [self configureViews];
}

- (void)configureViews {
    self.nameLabel.text = self.voter.name;
    self.provinceLabel.text = self.voter.province;
    self.schoolLabel.text = self.voter.school;
    self.chestLabel.text = [NSString stringWithFormat:@"%@ / %@", self.voter.chest, self.voter.chestIndex];
}


@end
