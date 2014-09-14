//
//  ViewController.h
//  Tranquility
//
//  Created by Isaiah Turner on 9/12/14.
//  Copyright (c) 2014 Isaiah Turner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIScrollView+APParallaxHeader.h"
#import "SummaryView.h"
#import "TRPieChart.h"
#import "TRAPIClient.h"
#import "FoodTableViewCell.h"
#import "DetailsViewController.h"

@interface ViewController : UITableViewController <APParallaxViewDelegate>
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) SummaryView *contentView;
@property (strong, nonatomic) TRChart *chart;
@property (strong, nonatomic) NSArray *meals;
@property (strong, nonatomic) TRPieChart *pieChart;
@property (nonatomic) BOOL shown;
@property (nonatomic) BOOL loggedIn;

@end

