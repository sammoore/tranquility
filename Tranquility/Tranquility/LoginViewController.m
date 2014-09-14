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
@property (strong, nonatomic) NSString *original;
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
                                               object:nil];
    [self.phoneField addTarget:self
                  action:@selector(textFieldDidChange:)
        forControlEvents:UIControlEventEditingChanged];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)logIn:(id)sender {
    self.activityIndicator.hidden = NO;
    self.checkImage.hidden = YES;
    self.phoneField.enabled = FALSE;
    self.continueButtons.enabled = FALSE;
    [self.continueButtons setTitle:@"Checking..." forState:UIControlStateNormal];
    [NSTimer scheduledTimerWithTimeInterval:2.0f
                                     target:self selector:@selector(checkForCallback:) userInfo:nil repeats:YES];
    self.original = [TRAPIClient accessKey];
    [TRAPIClient loginWith:self.phoneField.text block:^(BOOL success, NSString *phone) {
            UIAlertView *alert =[[UIAlertView alloc] initWithTitle:@"Confirmation Message Sent" message:@"We sent a link to your phone number. Open it up to continue." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alert show];
        
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

- (void)checkForCallback:(id)sender {
    if (self.original == [TRAPIClient accessKey]) return;
    else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

-(BOOL)textFieldDidChange:(id)sender {
    UITextField *textField = (UITextField *)sender;
    if ([textField.text stringByReplacingOccurrencesOfString:@"[^0-9]" withString:@"" options:NSRegularExpressionSearch range:NSMakeRange(0, [textField.text length])].length > 10) {
        self.checkImage.image = [UIImage imageNamed:@"Check"];
        self.continueButtons.enabled = TRUE;
    } else {
        self.checkImage.image = [UIImage imageNamed:@"Check Inactive"];
        self.continueButtons.enabled = FALSE;
    }
    
    return YES;
}

-(void)viewDidAppear:(BOOL)animated {
    
}

- (void)keyboardWasShown:(NSNotification *)notification {
    CGRect frame = self.view.frame;
    frame.origin.y -= 100;
    frame.size.height += 100;
    [UIView beginAnimations:@"ResizeForKeyboard" context:nil];
    [UIView setAnimationDuration:0.2];
    self.view.frame = frame;
    [UIView commitAnimations];
    
}

-(void)textFieldDidBeginEditing:(UITextField *)textField {
    if ([textField.text isEqualToString: @""]) {
        textField.text = @"+12402588898";
        [self textFieldDidChange:self.phoneField];
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
