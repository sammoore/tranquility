//
//  LoginViewController.m
//  Tranquility
//
//  Created by Isaiah Turner on 9/13/14.
//  Copyright (c) 2014 Isaiah Turner. All rights reserved.
//

#import "LoginViewController.h"
#import "TRAPIClient.h"
@interface LoginViewController ()
@property (strong, nonatomic) IBOutlet UITextField *phoneField;

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardDidShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)logIn:(id)sender {
    [TRAPIClient loginWith:self.phoneField.text block:^(BOOL success) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
}

- (void)keyboardWasShown:(NSNotification *)notification {
    NSDictionary* info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;

    CGRect frame = self.view.frame;
    frame.origin.y -= kbSize.height;
    frame.size.height += kbSize.height;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:0.2];
    self.view.frame = frame;
    [UIView commitAnimations];
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([textField.text isEqualToString: @""]) {
        textField.text = @"+1";
    }
}
- (void)keyboardWillBeHidden:(NSNotification *)notification {
    CGRect frame = self.view.frame;
    frame.origin.y = 0;
    frame.size.height = self.view.window.frame.size.height;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:0.2];
    self.view.frame = frame;
    [UIView commitAnimations];
}

@end
