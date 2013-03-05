//
//  TBEmailViewController.m
//  TBUserIdentity
//
//  Created by Markos Charatzas on 19/11/2012.
//  Copyright (c) 2012 Markos Charatzas (@qnoid). 
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy of
//  this software and associated documentation files (the "Software"), to deal in
//  the Software without restriction, including without limitation the rights to
//  use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
//  of the Software, and to permit persons to whom the Software is furnished to do
//  so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in all
//  copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
//  SOFTWARE.
//

#import "TBEmailViewController.h"
#import "TBQueries.h"
#import "AFHTTPRequestOperation.h"
#import "TBSecureHashA1.h"
#import "SSKeychain.h"

@interface TBEmailViewController ()
@property(nonatomic, strong) NSOperationQueue *operations;
-(id)initWithBundle:(NSBundle *)nibBundleOrNil;
@end

@implementation TBEmailViewController

+(TBEmailViewController*)newEmailViewController
{
    TBEmailViewController* emailViewController = [[TBEmailViewController alloc] initWithBundle:[NSBundle mainBundle]];
    emailViewController.title = @"Identify";
    
    return emailViewController;
}

-(id)initWithBundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:@"TBEmailViewController" bundle:nibBundleOrNil];
    
    if (!self) {
        return nil;
    }
    
    self.operations = [[NSOperationQueue alloc] init];

    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

#pragma mark UITextFieldDelegate

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
return YES;
}

#pragma mark TBRegistrationOperationDelegate
-(void)didSucceedWithRegistrationForEmail:(NSString *)email residence:(NSString *)residence
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    NSError *error = nil;
    [SSKeychain setPassword:residence forService:TB_SERVICE account:email error:&error];
    
    if (error) {
        NSLog(@"WARNING: %s %@", __PRETTY_FUNCTION__, error);
    }
    
    UIAlertView* userUnauthorisedAlertView = [[UIAlertView alloc] initWithTitle:@"New Registration" message:[NSString stringWithFormat:@"Please check your email %@.", email] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    
    [userUnauthorisedAlertView show];

}

-(void)didFailOnRegistrationWithError:(NSError*)error
{
    NSLog(@"WARNING: %s %@", __PRETTY_FUNCTION__, error);
}

-(IBAction)didTouchUpInsideRegister:(id)sender
{
    TBSecureHashA1 *sha1 = [TBSecureHashA1 new];
    NSString* residence = [sha1 newKey];
    
    [self.delegate didEnterEmail:self.emailTextField.text forResidence:residence];
    
    AFHTTPRequestOperation *newRegistrationOperation =
    [TBQueries newCreateUserQuery:self.createUserOperationDelegate email:self.emailTextField.text residence:residence];
    
    [self.operations addOperation:newRegistrationOperation];
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end
