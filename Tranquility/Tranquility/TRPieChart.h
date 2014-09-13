//
//  TRPieChart.h
//  TRPieChart
//
//  Created by Isaiah Turner on 9/13/14.
//  Copyright (c) 2014 Isaiah Turner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "TRPieChartView.h"

typedef enum foodGroups
{
    DAIRY,
    FRUIT,
    GRAIN,
    VEGITABLE,
    PROTEIN
} FoodGroup;

@interface TRPieChart : NSObject
@property (nonatomic, strong) UIView *view;

- (id)initWithView:(UIView *)view;
- (void)setValue:(double)value forFoodGroup:(int)foodGroup;

@end
