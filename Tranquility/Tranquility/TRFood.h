//
//  TRFood.h
//  Tranquility
//
//  Created by Isaiah Turner on 9/13/14.
//  Copyright (c) 2014 Isaiah Turner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface TRFood : NSObject

@property (nonatomic) int carbs;
@property (nonatomic) int sugar;
@property (nonatomic) int fiber;
@property (nonatomic) int fat;
@property (nonatomic) int protein;
@property (strong, nonatomic) NSString *foodName;
@property (strong, nonatomic) UIImage *icon;
@property (nonatomic) int calories;
@property (nonatomic) int objectID;

-(id)initWithCarbs:(int)carbs sugar:(int)sugar fiber:(int)fiber fat:(int)fat protein:(int)protein name:(NSString *)foodName icon:(UIImage *)icon calories:(int)calories objectID:(int)objectID;

@end
