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

+ (void)loginWith:(NSString *)phone block:(void(^)(BOOL success))block {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    [manager GET:[NSString stringWithFormat:@"%s/login?phone=%@",API_ENDPOINT, phone] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        block(TRUE);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
    }];
}
+ (void)getDataWithBlock:(void(^)(BOOL success, TRChart *chart, NSArray *foods))block {
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    NSString *accessKey = [[NSUserDefaults standardUserDefaults] stringForKey:@"Person"];
    
    [manager GET:[NSString stringWithFormat:@"%s/data",API_ENDPOINT] parameters:@{ @"id": accessKey } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        NSLog(@"%@",responseObject);
        block(TRUE, [[TRChart alloc] init], [[NSArray alloc] init]);
        
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        NSLog(@"Error: %@", [error localizedDescription]);
    }];
}

+ (void)setAccessKey:(NSString *)accessKey {
    [[NSUserDefaults standardUserDefaults] setValue:accessKey forKey:@"AccessKey"];
}

@end
