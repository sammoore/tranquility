//
//  TRAPIClient.m
//  Tranquility
//
//  Created by Isaiah Turner on 9/13/14.
//  Copyright (c) 2014 Isaiah Turner. All rights reserved.
//

#import "TRAPIClient.h"
#define API_ENDPOINT "http://tranquility-penn.herokuapp.com"

@implementation TRAPIClient
+ (NSDictionary *)icons {
    
    return @{@"cheeseburger": @"cheeseburger",
             @"chicken": @"chicken", @"cupcake": @"cupcake",
             @"egg": @"egg",
             @"fries": @"fries",
             @"pizza": @"pizza",
             @"sushi": @"sushi",
             @"taco": @"taco",
             @"steak": @"steak",
             @"soda": @"soda",
             @"fish": @"fish"
             };
}
+ (void)loginWith:(NSString *)phone block:(void(^)(BOOL success, NSString *phone))block {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"%s/login?phone=%@",API_ENDPOINT, phone] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        block(TRUE, responseObject[@"phone"]);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
    }];
}
+ (void)getDataWithBlock:(void(^)(BOOL success, TRChart *chart, NSArray *foods))block {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *accessKey = [[NSUserDefaults standardUserDefaults] stringForKey:@"AccessKey"];
    if (!accessKey) {
        block(FALSE, nil, nil);
        return;
    }
    [manager GET:[NSString stringWithFormat:@"%s/data?id=%@",API_ENDPOINT, accessKey] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        NSMutableArray *meals = [[NSMutableArray alloc] init];
        for (NSDictionary *meal in responseObject[@"meals"]) {
            TRFood *food = [[TRFood alloc] initWithCarbs:meal[@"nutrition"][@"carbs"] sugar:meal[@"nutrition"][@"carbs"] fiber:meal[@"nutrition"][@"fiber"] fat:meal[@"nutrition"][@"fat"] protein:meal[@"nutrition"][@"protein"] name:meal[@"food"][@"name"] icon:[UIImage imageNamed:[UIImage imageNamed:[[self icons] objectForKey:meal[@"food"][@"name"]]]] calories:meal[@"food"][@"calories"] objectID:meal[@"food"][@"id"]];
            [meals addObject:food];
        }
        TRChart *chart = [[TRChart alloc] initWithCarbs:responseObject[@"chart"][@"carbs"] sugar:responseObject[@"chart"][@"sugar"] fiber:responseObject[@"chart"][@"fiber"] fat:responseObject[@"chart"][@"fat"] protein:responseObject[@"chart"][@"protein"]];
        block(TRUE, chart, meals);
        [[NSUserDefaults standardUserDefaults] removeObjectForKey:@"AccessKey"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
    }];
}

+ (void)setAccessKey:(NSString *)accessKey {
    [[NSUserDefaults standardUserDefaults] setValue:accessKey forKey:@"AccessKey"];
}

+ (NSString *)accessKey {
    return [[NSUserDefaults standardUserDefaults] stringForKey:@"AccessKey"];
}

@end
