//
//  LoginViewController.m
//  Tranquility
//
//  Created by Isaiah Turner on 9/13/14.
//  Copyright (c) 2014 Isaiah Turner. All rights reserved.
//

#import "LoginViewController.h"
#import "TRAPIClient.h"
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>


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
    self.phoneField.enabled = FALSE;
    UIButton *button = (UIButton *)sender;
    button.enabled = FALSE;
    [button setTitle:@"Visit the link we sent" forState:UIControlStateNormal];
    [TRAPIClient loginWith:self.phoneField.text block:^(BOOL success, NSString *phone) {

        ABAddressBookRef iPhoneAddressBook = ABAddressBookCreate();
        ABRecordRef newPerson = ABPersonCreate();
        
        ABRecordSetValue(newPerson, kABPersonFirstNameProperty, CFSTR("Tranquility"), nil);
        
        ABMutableMultiValueRef multiPhone = ABMultiValueCreateMutable(kABMultiStringPropertyType);
        
        ABMultiValueAddValueAndLabel(multiPhone, (__bridge CFTypeRef)(phone), kABHomeLabel, NULL);
        ABRecordSetValue(newPerson, kABPersonPhoneProperty, multiPhone,nil);
        CFRelease(multiPhone);
        
        UIImage *im = [UIImage imageNamed:@"logo_mobile_48.png"];
        NSData *dataRef = UIImagePNGRepresentation(im);
        ABPersonSetImageData(newPerson, (__bridge CFDataRef)dataRef, nil);
        
        
        ABAddressBookAddRecord(iPhoneAddressBook, newPerson, nil);
        
        CFRelease(newPerson);
        CFRelease(iPhoneAddressBook);
    }];
}

-(void)viewDidAppear:(BOOL)animated {
    NSString *accessKey = [TRAPIClient accessKey];
    if (accessKey) {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
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
