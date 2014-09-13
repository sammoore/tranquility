//
//  ViewController.h
//  Tranquility
//
//  Created by Isaiah Turner on 9/12/14.
//  Copyright (c) 2014 Isaiah Turner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+APParallaxHeader.h"
#import "FoodTableViewCell.h"
#import "DetailsViewController.h"

@interface ViewController : UITableViewController <APParallaxViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) UIView *contentView;


@end

