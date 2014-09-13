//
//  TRAPIClient.h
//  Tranquility
//
//  Created by Isaiah Turner on 9/13/14.
//  Copyright (c) 2014 Isaiah Turner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFNetworking.h"
#import "TRChart.h"
#import "TRFood.h"

@interface TRAPIClient : NSObject
+ (void)loginWith:(NSString *)phone block:(void(^)(BOOL success))block;
+ (void)setAccessKey:(NSString *)accessKey;
+ (void)getDataWithBlock:(void(^)(BOOL success, TRChart *chart, NSArray *foods))block;

@end
