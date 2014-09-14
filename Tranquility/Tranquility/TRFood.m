//
//  TRFood.m
//  Tranquility
//
//  Created by Isaiah Turner on 9/13/14.
//  Copyright (c) 2014 Isaiah Turner. All rights reserved.
//

#import "TRFood.h"

@implementation TRFood

-(id)initWithCarbs:(int)carbs sugar:(int)sugar fiber:(int)fiber fat:(int)fat protein:(int)protein name:(NSString *)foodName icon:(UIImage *)icon calories:(int)calories objectID:(int)objectID {
    self = [super init];
    if (self) {
        self.carbs = carbs;
        self.sugar = sugar;
        self.fat = fat;
        self.fiber = fiber;
        self.protein = protein;
        self.foodName = foodName;
        self.icon = icon;
        self.calories = calories;
        self.objectID = objectID;
    }
    return self;
}

@end
