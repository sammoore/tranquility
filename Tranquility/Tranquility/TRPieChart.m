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

- (void)flashLabels {
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
}

- (void)setValue:(double)value forFoodGroup:(int)foodGroup {
    UIImageView *image;
    int top = 0;
    int left = 0;
    int right = 0;
    int bottom = 0;
    
    switch(foodGroup){
        case DAIRY: {
            image = chartView.chartDairy;
            [image setTranslatesAutoresizingMaskIntoConstraints:NO];
            left = chartView.chartDairy.frame.size.width * value;
            [UIView animateWithDuration:1.25 delay:0.5 options:(UIViewAnimationOptionCurveEaseInOut) animations:^(){
                chartView.chartFruitsWidth.constant = left;
                [self.view layoutIfNeeded];
            } completion:nil];
            
            NSLog(@"dairy updated to %f", value);
            break;
        }
        case FRUIT: {
            image = chartView.chartFruits;
            [image setTranslatesAutoresizingMaskIntoConstraints:NO];

            NSLog(@"%f",value);
            right = chartView.chartFruits.frame.size.width * value;
            [UIView animateWithDuration:1.25 delay:0.5 options:(UIViewAnimationOptionCurveEaseInOut) animations:^(){
                chartView.chartFruitsWidth.constant = right;
                [self.view layoutIfNeeded];
            } completion:nil];
            NSLog(@"fruit updated to %d", right);
            break;
        }
        case GRAIN: {
            image = chartView.chartGrains;
            [image setTranslatesAutoresizingMaskIntoConstraints:NO];
            NSLog(@"%f",value);
            top = image.frame.size.height * value;
            [UIView animateWithDuration:1.25 delay:0.5 options:(UIViewAnimationOptionCurveEaseInOut) animations:^(){
                chartView.chartGrainsHeight.constant = top;
                [self.view layoutIfNeeded];
            } completion:nil];
            NSLog(@"grain updated to %f", value);
            break;
        }
        case VEGITABLE: {
            image = chartView.chartVegitables;
            [image setTranslatesAutoresizingMaskIntoConstraints:NO];
            bottom = chartView.chartVegitables.frame.size.height * value;
            [UIView animateWithDuration:1.25 delay:0.5 options:(UIViewAnimationOptionCurveEaseInOut) animations:^(){
                chartView.chartVegitablesHeight.constant = bottom;
                [self.view layoutIfNeeded];
            } completion:nil];
            NSLog(@"vegitable updated to %f", value);
            break;
        }
        case PROTEIN: {
            image = chartView.chartProtein;
            [image setTranslatesAutoresizingMaskIntoConstraints:NO];
            right = chartView.chartProtein.frame.size.width * value;
            [UIView animateWithDuration:1.25 delay:0.5 options:(UIViewAnimationOptionCurveEaseInOut) animations:^(){
                chartView.chartProteinWidth.constant = right;
                [self.view layoutIfNeeded];
            } completion:nil];
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
