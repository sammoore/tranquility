//
//  AppDelegate.h
//  Tranquility
//
//  Created by Isaiah Turner on 9/12/14.
//  Copyright (c) 2014 Isaiah Turner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <PebbleKit/PebbleKit.h>

typedef enum NutritionGroup : NSUInteger {
    Carbs,
    Sugar,
    Fiber,
    Fat,
    Protien
} NutritionGroup;
#define kNutritionGroupArray @"Carbs", @"Sugar", @"Fiber", @"Fat", @"Protien", nil

@interface AppDelegate : UIResponder <UIApplicationDelegate, PBPebbleCentralDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, strong) PBWatch *connectedWatch;

@end

