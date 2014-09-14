//
//  ViewController.m
//  Tranquility
//
//  Created by Isaiah Turner on 9/12/14.
//  Copyright (c) 2014 Isaiah Turner. All rights reserved.
//

#import "ViewController.h"
#import "NutritionInfoViewController.h"

#define kTableViewCellHeight 62;
const int kParallaxHeight = 568;

@implementation ViewController {
    CGFloat _targetContentY;
    CGFloat _oldContentY;
}

#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.tableView addParallaxWithView:self.contentView andHeight:kParallaxHeight];
    [self.tableView.parallaxView setDelegate:self];
    
    [self.navigationItem setTitle:@"Today"];
    
    //self.tableView.backgroundColor = [UIColor grayColor];
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = YES;
     }

- (void)viewDidAppear:(BOOL)animated
{
    if (!self.loggedIn) {
        self.loggedIn = TRUE;
        return;
    }
    if (!self.shown) {
        self.shown = TRUE;
    [TRAPIClient getDataWithBlock:^(BOOL success, TRChart *chart, NSArray *meals) {
        self.chart = chart;
        self.meals = meals;
        float fat = self.chart.fat / 1000 + .5;
        float protein = self.chart.protein / 1000 + .5;
        float fiber = self.chart.fiber / 1000 + .5;
        NSLog(@"FATT%d %d %d %d",fat, protein, fiber, self.chart.fiber);
        [self.pieChart setValue:fat forFoodGroup:FRUIT];
        [self.pieChart setValue:protein forFoodGroup:PROTEIN];
        [self.pieChart setValue:fiber forFoodGroup:VEGITABLE];
        [self.tableView reloadData];
        
        [self.tableView setContentOffset:CGPointMake(0, -44-kParallaxHeight)];
        [self.tableView.parallaxView setBackgroundColor:[UIColor blackColor]];
        
        NSLog(@"%@", [TRAPIClient accessKey]);
        [TRAPIClient getDataWithBlock:^(BOOL success, TRChart *chart, NSArray *foods) {
            if (!success) {
                [self performSegueWithIdentifier:@"showLogin" sender:self];
            } else {
                NSLog(@"Use the data");
            }
        }];
    }];
    }
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqual:@"showInfo"]) {
    NutritionInfoViewController *vc = segue.destinationViewController;
    TRFood *food = [self.meals objectAtIndex:[[self.tableView indexPathForSelectedRow] row]];
    vc.calories.text = [NSString stringWithFormat:@"%d%%", food.calories];
    vc.fat.text = [NSString stringWithFormat:@"%d%%", food.fat];
    vc.protein.text = [NSString stringWithFormat:@"%d%%", food.protein];
    vc.sugar.text = [NSString stringWithFormat:@"%d%%", food.sugar];
    vc.title = @"Hamburger";
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Accessors

- (UIView *)contentView {
    if (_contentView == nil) {
        _contentView = [[[NSBundle mainBundle] loadNibNamed:@"SummaryView" owner:self options:nil] objectAtIndex:0];
        self.pieChart = [[TRPieChart alloc] initWithView:_contentView.circleView];
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
        return [self.meals count];
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    FoodTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    TRFood *meal = [self.meals objectAtIndex:[indexPath row]];
    cell.foodTitle.text = meal.foodName;
    cell.foodCalories.text = [NSString stringWithFormat:@"%d",meal.calories];
    
    return cell;
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

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
    //NSLog(@"%f", scrollView.contentOffset.y);
    _oldContentY = scrollView.contentOffset.y;
}

#pragma mark - Sticky Scroll View

- (void)repositionScrollView:(UIScrollView *)scrollView
{
    //CGFloat superHeight = [[scrollView superview] bounds].size.height;
    //CGFloat scrollViewOffset = _targetContentY;;
    //_oldContentY = [scrollView contentOffset].y;
    
    //int newOffsetRatio = (int)superHeight / (int)scrollViewOffset;
    //int oldOffsetRatio = (int)superHeight / (int)_oldContentY;

    //NSLog(@"targetContentY %f, 0.3k %f", _targetContentY, 0.3*-kParallaxHeight);
    //NSLog(@"oldContentY %f", _oldContentY);
    
    if (_targetContentY <= -kParallaxHeight) // if it is pulled down, bring it back up. // < -568 means pulled even farther down
    {
        // parallaxview in view
        [scrollView setContentOffset:CGPointMake(0, -kParallaxHeight) animated:YES];
    }
    else if (_targetContentY > -kParallaxHeight && _targetContentY <= 0.5*-kParallaxHeight) // if it is pulled up, we want the target to be (1/2)(-568) so the dest. needs to be
    {
        // tableview in view
        [scrollView setContentOffset:CGPointMake(0, -kParallaxHeight) animated:YES];
    }
    else if (_targetContentY > 0.5*-kParallaxHeight && _targetContentY < 0)
    {
        [scrollView setContentOffset:CGPointMake(0, -60) animated:YES];
    }
}
#pragma mark - APParallaxViewDelegate

- (void)parallaxView:(APParallaxView *)view willChangeFrame:(CGRect)frame {
    
}

- (void)parallaxView:(APParallaxView *)view didChangeFrame:(CGRect)frame {
    
    if (frame.origin.y >= 0.5*-kParallaxHeight) {
        [self.navigationController setNavigationBarHidden:NO animated:YES];
    } else {
        [self.navigationController setNavigationBarHidden:YES animated:YES];
    }
}


@end
