//
//  ViewController.m
//  Tranquility
//
//  Created by Isaiah Turner on 9/12/14.
//  Copyright (c) 2014 Isaiah Turner. All rights reserved.
//

#import "ViewController.h"

#define kTableViewCellHeight 62;

@implementation ViewController {
    CGFloat _targetContentY;
    CGFloat _oldContentY;
}

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
    return 20;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView
                     withVelocity:(CGPoint)velocity
              targetContentOffset:(inout CGPoint *)targetContentOffset
{
    _targetContentY = targetContentOffset->y;
}

- (void)scrollViewWillBeginDecelerating:(UIScrollView *)scrollView
{
    [self repositionScrollView:scrollView];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (!decelerate) [self repositionScrollView:scrollView];
}

#pragma mark - Sticky Scroll View

- (void)repositionScrollView:(UIScrollView *)scrollView
{
    CGFloat superHeight = [[scrollView superview] bounds].size.height;
    CGFloat scrollViewOffset = _targetContentY;;
    _oldContentY = [scrollView contentOffset].y;
    
    int newOffsetRatio = (int)superHeight / (int)scrollViewOffset;
    int oldOffsetRatio = (int)superHeight / (int)_oldContentY;
    
    if (newOffsetRatio == -1)
    {
        [scrollView setContentOffset:CGPointMake(0, -568) animated:YES];
    }
    else if (newOffsetRatio < -1 || (oldOffsetRatio < 0 && newOffsetRatio > 2))
    {
        [scrollView setContentOffset:CGPointMake(0, 0) animated:YES];
    }
}

#pragma mark - APParallaxViewDelegate

- (void)parallaxView:(APParallaxView *)view willChangeFrame:(CGRect)frame {
    
}

- (void)parallaxView:(APParallaxView *)view didChangeFrame:(CGRect)frame {
    
}


@end
