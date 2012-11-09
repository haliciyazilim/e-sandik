//
//  SandikKunyeViewController.h
//  e-Sandik
//
//  Created by Alperen Kavun on 08.11.2012.
//  Copyright (c) 2012 Halıcı. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Voter;

@interface SandikKunyeViewController : UITableViewController

@property (strong, nonatomic) Voter *voter;

// label details -> voter's info will be displayed in these labels
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *provinceLabel;
@property (weak, nonatomic) IBOutlet UILabel *schoolLabel;
@property (weak, nonatomic) IBOutlet UILabel *chestLabel;

// Label cells -> voter's infos header
@property (weak, nonatomic) IBOutlet UITableViewCell *nameCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *provinceCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *schoolCell;
@property (weak, nonatomic) IBOutlet UITableViewCell *chestCell;



@end
