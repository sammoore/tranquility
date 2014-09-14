//
//  SummaryView.h
//  Tranquility
//
//  Created by Sam Moore on 9/13/14.
//  Copyright (c) 2014 Isaiah Turner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SummaryView : UIView
@property (strong, nonatomic) IBOutlet UILabel *dateLabel;
@property (nonatomic) int lastIndex;
@property (strong, nonatomic) NSArray *all;

@property (nonatomic, strong) IBOutlet UIView *circleView;
- (IBAction)increase:(id)sender;
- (IBAction)decrease:(id)sender;

@end
