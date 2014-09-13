//
//  TRPieChart.m
//  TRPieChart
//
//  Created by Isaiah Turner on 9/13/14.
//  Copyright (c) 2014 Isaiah Turner. All rights reserved.
//

#import "TRPieChart.h"

@implementation TRPieChart {
    TRPieChartView *chartView;
}

- (id)initWithView:(UIView *)view {
    if (!self) {
        self = [super init];
    }
    self.view = view;
    NSArray *nibViews = [[NSBundle mainBundle] loadNibNamed:@"TRPieChartView" owner:self options:nil];
    
    chartView = [nibViews objectAtIndex:0];
    [self.view addSubview:chartView];
    for (UILabel *label in chartView.labels) {
        label.layer.opacity = 0;
    }
    [UIView animateWithDuration:.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^(){
        for (UILabel *label in chartView.labels) {
            label.layer.opacity = 1;
        }
    } completion:^(BOOL info){
        [UIView animateWithDuration:1.5 delay:1 options:UIViewAnimationOptionAllowUserInteraction animations:^(){
            for (UILabel *label in chartView.labels) {
                label.layer.opacity = 0;
            }
        } completion:nil];
    }];
    return self;
}

- (void)setValue:(double)value forFoodGroup:(int)foodGroup {
    value = 1.0 - value;
    UIImageView *image;
    int top = 0;
    int left = 0;
    int right = 0;
    int bottom = 0;
    
    switch(foodGroup){
        case DAIRY: {
            image = chartView.chartDairy;
            left = chartView.chartDairy.frame.size.width * value;
            [UIView animateWithDuration:0.5 animations:^(){
                chartView.chartFruitsWidth.constant = left;
            }];
            
            NSLog(@"dairy updated to %f", value);
            break;
        }
        case FRUIT: {
            image = chartView.chartFruits;
            [image setTranslatesAutoresizingMaskIntoConstraints:NO];

            NSLog(@"%f",value);
            right = chartView.chartFruits.frame.size.width * value;
            [UIView animateWithDuration:0.5 animations:^(){
                chartView.chartFruitsWidth.constant = right;
            }];
            NSLog(@"fruit updated to %d", right);
            break;
        }
        case GRAIN: {
            image = chartView.chartGrains;
            bottom = chartView.chartGrains.frame.size.width * value;
            NSLog(@"grain updated to %f", value);
            break;
        }
        case VEGITABLE: {
            image = chartView.chartVegitables;
            top = chartView.chartVegitables.frame.size.width * value;
            NSLog(@"vegitable updated to %f", value);
            break;
        }
        case PROTEIN: {
            image = chartView.chartProtein;
            right = chartView.chartFruits.frame.size.width * value;
            NSLog(@"protein updated to %f", value);
            break;
        }
        default: {
            NSLog(@"ERROR: Unknown food group.");
            break;
        }
    }    
}

@end
