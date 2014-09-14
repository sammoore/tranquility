//
//  TRChart.m
//  Tranquility
//
//  Created by Isaiah Turner on 9/13/14.
//  Copyright (c) 2014 Isaiah Turner. All rights reserved.
//

#import "TRChart.h"

@implementation TRChart
-(id)initWithCarbs:(int)carbs sugar:(int)sugar fiber:(int)fiber fat:(int)fat protein:(int)protein {
    self = [super init];
    if (self) {
        self.carbs = carbs;
        self.sugar = sugar;
        self.fat = fat;
        self.fiber = fiber;
        self.protein = protein;
    }
    return self;
}
@end
