//
//  FoodTableViewCell.h
//  Tranquility
//
//  Created by Isaiah Turner on 9/13/14.
//  Copyright (c) 2014 Isaiah Turner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FoodTableViewCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *foodIcon;
@property (strong, nonatomic) IBOutlet UILabel *foodTitle;
@property (strong, nonatomic) IBOutlet UILabel *foodCalories;

@end
