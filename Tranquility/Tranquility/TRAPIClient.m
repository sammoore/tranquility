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
    NSString *accessKey = [[NSUserDefaults standardUserDefaults] stringForKey:@"Person"];
    if (!accessKey) {
        block(FALSE, nil, nil);
        return;
    }
    [manager GET:[NSString stringWithFormat:@"%s/data?id=accessKey",API_ENDPOINT] parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [[NSUserDefaults standardUserDefaults] setValue:accessKey forKey:@"AccessKey"];
        NSLog(@"%@",responseObject);
        block(TRUE, [[TRChart alloc] init], [[NSArray alloc] init]);
        
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
