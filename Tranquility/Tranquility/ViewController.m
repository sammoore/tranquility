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
    
    //self.tableView.backgroundColor = [UIColor grayColor];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
    [self.tableView setContentOffset:CGPointMake(0, -568)];
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
        _contentView = [[[NSBundle mainBundle] loadNibNamed:@"SummaryView" owner:self options:nil] objectAtIndex:0];
        
        TRPieChart *chart = [[TRPieChart alloc] initWithView:_contentView.circleView];
        [chart setValue:0.5 forFoodGroup:FRUIT];
        //UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:_contentView.circleView action:@selector(singleTapGestureRecognizer:)];
        //[_contentView.circleView addGestureRecognizer:singleTap];
    }
    
    return _contentView;
}

#pragma mark - UITableViewController

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 62;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)sectionIndex
{
    if (sectionIndex == 0)
        return 0;
    return 0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0)
        return 20;
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    cell.foodTitle.text = @"Hamburger";
    cell.foodCalories.text = [NSString stringWithFormat:@"%d",40];
    
    return cell;
}

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)sectionIndex
//{
//    if (sectionIndex == 0) {
//        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(tableView.frame.origin.x, tableView.frame.origin.y, tableView.frame.size.width, 20)];
//        view.backgroundColor = [UIColor grayColor];
//        
//        //[view addSubview:label];
//        
//        return view;
//    }
//    return nil;
//}

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

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    NSLog(@"%f", scrollView.contentOffset.y);
}

#pragma mark - Sticky Scroll View

- (void)repositionScrollView:(UIScrollView *)scrollView
{
    CGFloat superHeight = [[scrollView superview] bounds].size.height;
    CGFloat scrollViewOffset = _targetContentY;;
    _oldContentY = [scrollView contentOffset].y;
    
    int newOffsetRatio = (int)superHeight / (int)scrollViewOffset;
    int oldOffsetRatio = (int)superHeight / (int)_oldContentY;
    
//    if (_targetContentY >= 0.5*-568) {
//        [self.navigationController setNavigationBarHidden:NO animated:YES];
//        //self.navigationController.navigationBarHidden = NO;
//    } else {
//        [self.navigationController setNavigationBarHidden:YES animated:YES];
//        //self.navigationController.navigationBarHidden = YES;
//    }
    
    NSLog(@"%d", newOffsetRatio);
    
    if (newOffsetRatio == -1)
    {
        // parallaxview in view
        [scrollView setContentOffset:CGPointMake(0, -568) animated:YES];
        //self.navigationController.navigationBarHidden = YES;
    }
    else if ((_targetContentY < -60 && _targetContentY > 0.5*-568) || (oldOffsetRatio < 0 && newOffsetRatio > 2))
    {
        // tableview in view
        [scrollView setContentOffset:CGPointMake(0, -60) animated:YES];
        //self.navigationController.navigationBarHidden = NO;
    }
}

#pragma mark - APParallaxViewDelegate

- (void)parallaxView:(APParallaxView *)view willChangeFrame:(CGRect)frame {
    
}

- (void)parallaxView:(APParallaxView *)view didChangeFrame:(CGRect)frame {
    //NSLog(@"%f %f %f %f", frame.origin.x, frame.origin.y, frame.size.width, frame.size.height);
    
    if (frame.origin.y >= 0.5*-568) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
        //self.navigationController.navigationBarHidden = NO;
    } else {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
        //self.navigationController.navigationBarHidden = YES;
    }
}


@end
