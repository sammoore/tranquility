//
//  ViewController.m
//  Tranquility
//
//  Created by Isaiah Turner on 9/12/14.
//  Copyright (c) 2014 Isaiah Turner. All rights reserved.
//

#import "ViewController.h"

#define kTableViewCellHeight 62;

@implementation ViewController

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView addParallaxWithView:self.contentView andHeight:568];
    [self.tableView.parallaxView setDelegate:self];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DetailsViewController *vc = segue.destinationViewController;
    vc.title = @"Hamburger";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Accessors

- (UIView *)contentView {
    if (_contentView == nil) {
        _contentView = [[[NSBundle mainBundle] loadNibNamed:@"ParallaxView" owner:self options:nil] objectAtIndex:0];
    }
    
    return _contentView;
}

#pragma mark - UITableViewController

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.foodTitle.text = @"Hamburger";
    cell.foodCalories.text = [NSString stringWithFormat:@"%d",40];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return kTableViewCellHeight;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 100;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

#pragma mark - UIScrollViewDelegate

#pragma mark - APParallaxViewDelegate

- (void)parallaxView:(APParallaxView *)view willChangeFrame:(CGRect)frame {
    NSLog(@"parallaxView:willChangeFrame:");
    NSLog(@"-- paraframe: %0.f %0.f %0.f %0.f", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
    NSLog(@"-- contframe: %0.f %0.f %0.f %0.f", self.contentView.frame.origin.x, self.contentView.frame.origin.y, frame.size.width, frame.size.height);
}

- (void)parallaxView:(APParallaxView *)view didChangeFrame:(CGRect)frame {
    NSLog(@"parallaxView:didChangeFrame:");
    NSLog(@"-- paraframe: %0.f %0.f %0.f %0.f", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
    NSLog(@"-- contframe: %0.f %0.f %0.f %0.f", self.contentView.frame.origin.x, self.contentView.frame.origin.y, self.contentView.frame.size.width, self.contentView.frame.size.height);
}


@end
