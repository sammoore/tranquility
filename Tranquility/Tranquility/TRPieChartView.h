//
//  TRPieChartView.h
//  TRPieChart
//
//  Created by Isaiah Turner on 9/13/14.
//  Copyright (c) 2014 Isaiah Turner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TRPieChartView : UIView
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *chartFruitsWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *chartDairyWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *chartProteinWidth;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *chartGrainsHeight;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *chartVegitablesHeight;


@property (strong, nonatomic) IBOutlet UIImageView *chartGrains;
@property (strong, nonatomic) IBOutlet UIImageView *chartDairy;
@property (strong, nonatomic) IBOutlet UIImageView *chartVegitables;
@property (strong, nonatomic) IBOutlet UIImageView *chartFruits;
@property (strong, nonatomic) IBOutlet UIImageView *chartProtein;
@property (strong, nonatomic) IBOutletCollection(UILabel) NSArray *labels;

@property (strong, nonatomic) IBOutlet UILabel *chartVegitablesLabel;
@property (strong, nonatomic) IBOutlet UILabel *chartFruitLabel;
@property (strong, nonatomic) IBOutlet UILabel *chartDairyLabel;
@property (strong, nonatomic) IBOutlet UILabel *chartProteinLabel;
@property (strong, nonatomic) IBOutlet UILabel *chartGrainLabel;

@end
