//
//  SummaryView.m
//  Tranquility
//
//  Created by Sam Moore on 9/13/14.
//  Copyright (c) 2014 Isaiah Turner. All rights reserved.
//

#import "SummaryView.h"

@implementation SummaryView

- (NSArray *)all {
    if (_all == nil)
        _all = [[NSArray alloc] initWithObjects:@"Today", @"1 Week", @"2 Weeks", @"3 Weeks", @"1 Month", nil];
    
    return _all;
}

- (IBAction)increase:(id)sender {
    NSLog(@"%d %d", self.lastIndex, (int)[self.all count]);
    if (self.lastIndex == (int)[self.all count]) return;
    self.lastIndex += 1;
    self.dateLabel.text = [self.all objectAtIndex:self.lastIndex];
}
- (IBAction)decrease:(id)sender {
    if (self.lastIndex == 0) return;
    self.lastIndex -= 1;
    self.dateLabel.text = [self.all objectAtIndex:self.lastIndex];
}

@end
