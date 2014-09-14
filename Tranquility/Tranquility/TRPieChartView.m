//
//  TRPieChartView.m
//  TRPieChart
//
//  Created by Isaiah Turner on 9/13/14.
//  Copyright (c) 2014 Isaiah Turner. All rights reserved.
//

#import "TRPieChartView.h"

@implementation TRPieChartView
- (IBAction)tap:(UITapGestureRecognizer *)sender {
    [self flashLabels];
}
- (void)flashLabels {
    [UIView animateWithDuration:.5 delay:0 options:UIViewAnimationOptionAllowUserInteraction animations:^(){
        for (UILabel *label in self.labels) {
            label.layer.opacity = 1;
        }
    } completion:^(BOOL info){
        [UIView animateWithDuration:1.5 delay:1 options:UIViewAnimationOptionAllowUserInteraction animations:^(){
            for (UILabel *label in self.labels) {
                label.layer.opacity = 0;
            }
        } completion:nil];
    }];
}
@end
