//
//  SandikKunyeViewController.m
//  e-Sandik
//
//  Created by Alperen Kavun on 08.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import "SandikKunyeViewController.h"

#import "Voter.h"

#import <QuartzCore/QuartzCore.h>

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
    imageView.contentMode = UIViewContentModeBottom;
    
    // Add image view on top of table view
    
    // Set the background view of the table view
    self.tableView.backgroundView = imageView;
    
    [self.tableView setSeparatorColor:[UIColor clearColor]];
    
    UIImageView *myImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_bg.png"]];
    myImageView.layer.cornerRadius = 6.0;
    myImageView.clipsToBounds = YES;
   
    UIImageView *myImageView2 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_bg.png"]];
    myImageView2.layer.cornerRadius = 6.0;
    myImageView2.clipsToBounds = YES;
    
    UIImageView *myImageView3 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_bg.png"]];
    myImageView3.layer.cornerRadius = 6.0;
    myImageView3.clipsToBounds = YES;
    
    UIImageView *myImageView4 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_bg.png"]];
    myImageView4.layer.cornerRadius = 6.0;
    myImageView4.clipsToBounds = YES;

    UIImageView *myImageView5 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_tile_bg.png"]];
    myImageView5.layer.cornerRadius = 6.0;
    myImageView5.clipsToBounds = YES;
    myImageView5.alpha = 0.3;

    UIImageView *myImageView6 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_tile_bg.png"]];
    myImageView6.layer.cornerRadius = 6.0;
    myImageView6.clipsToBounds = YES;
    myImageView6.alpha = 0.3;
    
    UIImageView *myImageView7 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_tile_bg.png"]];
    myImageView7.layer.cornerRadius = 6.0;
    myImageView7.clipsToBounds = YES;
    myImageView7.alpha = 0.3;

    UIImageView *myImageView8 = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"cell_tile_bg.png"]];
    myImageView8.layer.cornerRadius = 6.0;
    myImageView8.clipsToBounds = YES;
    myImageView8.alpha = 0.3;
    
    self.nameCell.backgroundView = myImageView;
    self.provinceCell.backgroundView = myImageView2;
    self.schoolCell.backgroundView = myImageView3;
    self.chestCell.backgroundView = myImageView4;
    
    self.detailNameCell.backgroundView = myImageView5;
    self.detailProvinceCell.backgroundView = myImageView6;
    self.detailSchoolCell.backgroundView = myImageView7;
    self.detailChestCell.backgroundView = myImageView8;
    
    UIView *emptyView = [[UIView alloc] initWithFrame:CGRectZero];
    emptyView.backgroundColor = [UIColor clearColor];
    UIView *emptyView2 = [[UIView alloc] initWithFrame:CGRectZero];
    emptyView2.backgroundColor = [UIColor clearColor];
    UIView *emptyView3 = [[UIView alloc] initWithFrame:CGRectZero];
    emptyView3.backgroundColor = [UIColor clearColor];
    UIView *emptyView4 = [[UIView alloc] initWithFrame:CGRectZero];
    emptyView4.backgroundColor = [UIColor clearColor];

    self.firstEmptyRow.backgroundView = emptyView;
    self.secondEmptyRow.backgroundView = emptyView2;
    self.thirdEmptyRow.backgroundView = emptyView3;
    self.fourthEmptyRow.backgroundView = emptyView4;

//    [self configureViews];
    [self configure];
}
- (void) configure {
    self.nameLabel.text = self.voter.name;
    self.provinceLabel.text = self.voter.province;
    self.schoolLabel.text = self.voter.school;
    if (self.voter.chest && self.voter.chestIndex) {
        self.chestLabel.text = [NSString stringWithFormat:@"%@ / %@", self.voter.chest, self.voter.chestIndex];
    } else {
        self.chestLabel.text = nil;
    }
}
- (void)viewWillAppear:(BOOL)animated {

    if(isFirst != 0){
    
    self.navigationController.navigationBar.topItem.titleView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"title_secmenkunyesi.png"]];
    }
    else{
        isFirst = 1;
    }
}
- (void) viewDidAppear:(BOOL)animated {
    [self configureViews];
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
}

- (void)configureViews {

    if(self.voter.isInformationsOld){
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 10.0, 320.0, 70.0)];
        UILabel *headerLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0, 0.0, 300.0, 0.0)];
        [headerLabel setBackgroundColor:[UIColor clearColor]];
        [headerLabel setTextColor:[UIColor whiteColor]];
        [headerLabel setFont:[UIFont fontWithName:@"Futura-Medium" size:13]];
        [headerLabel setAdjustsFontSizeToFitWidth:NO];
        [headerLabel setNumberOfLines:0];
        [headerLabel setTextAlignment:NSTextAlignmentCenter];
        [headerLabel setText:[NSString stringWithFormat:@"Not: Yeni seçmen listeleri açıklanana kadar %@ seçimlerine dair bilgiler görüntülenecektir.",self.voter.electionYear]];
        [headerView addSubview:headerLabel];
        
        [UIView animateWithDuration:1.0 delay:0.0 options:UIViewAnimationCurveEaseInOut animations:^{
            headerLabel.frame = CGRectMake(10.0, 10.0, 300.0, 60.0);
            self.tableView.tableHeaderView = headerView;
        } completion:^(BOOL finished) {
            
        }];
    }
    
    self.nameLabel.text = self.voter.name;
    self.provinceLabel.text = self.voter.province;
    self.schoolLabel.text = self.voter.school;
    if (self.voter.chest && self.voter.chestIndex) {
        self.chestLabel.text = [NSString stringWithFormat:@"%@ / %@", self.voter.chest, self.voter.chestIndex];
    } else {
        self.chestLabel.text = nil;
    }
}
- (void) viewDidDisappear:(BOOL)animated {
    self.tableView.tableHeaderView = nil;
}
- (void)setIsFirst {
    isFirst = 0;
}
@end
