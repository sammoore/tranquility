//
//  AppDelegate.m
//  Tranquility
//
//  Created by Isaiah Turner on 9/12/14.
//  Copyright (c) 2014 Isaiah Turner. All rights reserved.
//

#import "AppDelegate.h"
#import <PebbleKit/PebbleKit.h>
#import "TRAPIClient.h"

@interface AppDelegate ()

@end

@implementation AppDelegate {
    PBWatch *_targetWatch;
}

#pragma mark - PB/Tranquility AppMessages

/*
 * - refreshDataFromSender:withChartDict:
 *
 * sender unused right now, you can use nil
 * dict expects ~= @{
 *   @"chart": @{
 *     @"dataCategory": @(intValue),
 *     ...,
 *     ...
 *   }
 * }
 */
- (void)refreshDataFromSender:(id)sender withChartDict:(NSDictionary *)dict {
    if (_targetWatch == nil || [_targetWatch isConnected] == NO) {
        NSLog(@"Tried updating data, but no connected watch!");
        return;
    }
    
    __block NSString *message;
    NSDictionary *chartDict = [dict objectForKey:@"chart"];
    NSMutableDictionary *update = [[NSMutableDictionary alloc] init];
    
    for (NSString *key in chartDict)
    {
        NSNumber *groupKey = @([self nutritionGroupStringToEnum:key]);
        int percent = [chartDict[key] integerValue];
        [update setValue:@(percent) forKey:groupKey];
    }
    
    [_targetWatch appMessagesPushUpdate:update onSent:^(PBWatch *watch, NSDictionary *update, NSError *error) {
        message = error ? [error localizedDescription] : @"Update sent!";
    }];
    return;
}

- (void)setTargetWatch:(PBWatch *)watch {
    _targetWatch = watch;
    
    [watch appMessagesGetIsSupported:^(PBWatch *watch, BOOL isAppMessagesSupported) {
        NSString *message;
        
        if (isAppMessagesSupported) {
            // Configure out communications channel to target the Tranquility Pebble app:
            uuid_t trPebbleUUIDbytes;
            NSUUID *trPebbleUUID = [[NSUUID alloc] initWithUUIDString:@"0dff7ddc-e15f-473f-b89d-70b750a2842d"];
            [trPebbleUUID getUUIDBytes:trPebbleUUIDbytes];
            [[PBPebbleCentral defaultCentral] setAppUUID:[NSData dataWithBytes:trPebbleUUIDbytes length:16]];
            
            message = [NSString stringWithFormat:@"%@ connected with AppMessages support", [watch name]];
            [self sendTestAppMessage];
        } else {
            message = [NSString stringWithFormat:@"%@ connected without AppMessages support", [watch name]];
        }
        
        NSLog(@"%@", message);
    }];
}

- (void)sendTestAppMessage
{
    // TODO: implement
}

- (NSString *)nutritionGroupToString:(NutritionGroup)enumVal
{
    NSArray *nutritionTypeArray = [[NSArray alloc] initWithObjects:kNutritionGroupArray];
    return [nutritionTypeArray objectAtIndex:enumVal];
}

- (NSUInteger)nutritionGroupStringToEnum:(NSString *)strVal
{
    NSArray *nutritionTypeArray = [[NSArray alloc] initWithObjects:kNutritionGroupArray];
    NSUInteger n = [nutritionTypeArray indexOfObject:strVal];
    if(n < 1) n = Carbs;
    
    return n;
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    // PBPebbleCentral configuration
    //[[PBPebbleCentral defaultCentral] setAppUUID:[NSData dataWithBytes:trPebbleUUIDbytes length:16]];
    [[PBPebbleCentral defaultCentral] setDelegate:self];
    [self setTargetWatch:[[PBPebbleCentral defaultCentral] lastConnectedWatch]];
    NSLog(@"Last connected watch: %@", self.connectedWatch);
    
    return YES;
}

#pragma mark - PBPebbleCentralDelegate

- (void)pebbleCentral:(PBPebbleCentral *)central
      watchDidConnect:(PBWatch *)watch
                isNew:(BOOL)isNew
{
    [self setTargetWatch:watch];
}

- (void)pebbleCentral:(PBPebbleCentral *)centrald
   watchDidDisconnect:(PBWatch *)watch
                isNew:(BOOL)isNew
{
    if (_targetWatch == watch || [watch isEqual:_targetWatch]) {
        [self setTargetWatch:nil];
    }
}

#pragma mark - UIApplicationDelegate

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication annotation:(id)annotation
{
    NSLog(@"URL query: %@", [url host]);
    [TRAPIClient setAccessKey:[url host]];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
