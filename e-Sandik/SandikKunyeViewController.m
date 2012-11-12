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
        UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Yeni sorgu" style:UIBarButtonItemStylePlain target:nil action:nil];
        self.navigationItem.backBarButtonItem = backButton;
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UIImage *image = [UIImage imageNamed:@"mainbg.png"];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:image];
    
    // Add image view on top of table view
    [self.tableView addSubview:imageView];
    
    // Set the background view of the table view
    self.tableView.backgroundView = imageView;

    [self configureViews];
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    self.navigationController.navigationBar.topItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title_secmenkunyesi.png"]];
}

- (void)viewWillAppear:(BOOL)animated {
    
//    UINavigationBar *navBar = self.navigationController.navigationBar;
//    UIImage *image = [UIImage imageNamed:@"header_bg.png"];
//    UIImage *shadowImage = [UIImage imageNamed:@"header_shadow.png"];
//    [navBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
//    [navBar setShadowImage:shadowImage];
    
//    self.navigationController.navigationBar.topItem.title = @"Künye";
    
    
        
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
    if (self.voter.chest && self.voter.chestIndex) {
        self.chestLabel.text = [NSString stringWithFormat:@"%@ / %@", self.voter.chest, self.voter.chestIndex];
    } else {
        self.chestLabel.text = nil;
    }
    
}


@end
