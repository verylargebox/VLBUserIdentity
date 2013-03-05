//
//  TBIdentifyViewController.m
//  TBUserIdentity
//
//  Created by Markos Charatzas on 18/11/2012.
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

#import "TBIdentifyViewController.h"
#import "SSKeychain.h"
#import "TBQueries.h"
#import "AFHTTPRequestOperation.h"
#import "TBVerifyOperationBlock.h"
#import "TBVerifiedViewController.h"

@interface TBIdentifyViewController ()
@property(nonatomic, strong) NSOperationQueue *operations;
@property(nonatomic, strong) NSMutableArray* accounts;
-(id)initWithBundle:(NSBundle *)nibBundleOrNil accounts:(NSMutableArray*) accounts;
@end

@implementation TBIdentifyViewController

+(TBIdentifyViewController*)newIdentifyViewController
{
    NSArray* accounts = [SSKeychain accountsForService:TB_SERVICE];

    TBIdentifyViewController* identifyViewController = [[TBIdentifyViewController alloc] initWithBundle:[NSBundle mainBundle] accounts:[NSMutableArray arrayWithArray:accounts]];
    
    identifyViewController.title = @"User Identity";
    
return identifyViewController;
}

-(id)initWithBundle:(NSBundle *)nibBundleOrNil accounts:(NSMutableArray*) accounts
{
    self = [super initWithNibName:@"TBIdentifyViewController" bundle:nibBundleOrNil];
    
    if (!self) {
        return nil;
    }
    
    self.operations = [[NSOperationQueue alloc] init];
    self.accounts = accounts;
    
return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

-(void)viewWillAppear:(BOOL)animated
{
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dismissViewControllerAnimated
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark TBVerifyUserOperationDelegate
-(void)didSucceedWithVerificationForEmail:(NSString *)email residence:(NSDictionary *)residence
{
    NSLog(@"%s %@:%@", __PRETTY_FUNCTION__, email, residence);
    TBVerifiedViewController *verifiedViewController = [TBVerifiedViewController newVerifiedViewController:residence email:email];
    
    [self presentViewController:[[UINavigationController alloc] initWithRootViewController:verifiedViewController] animated:YES completion:nil];
}

-(void)didFailOnVerifyWithError:(NSError *)error
{
    UIAlertView* userUnauthorisedAlertView = [[UIAlertView alloc] initWithTitle:@"Unauthorised" message:@"You are not authorised. Please check your email to verify." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    
    [userUnauthorisedAlertView show];
}

#pragma mark TBEmailViewControllerDelegate
-(void)didEnterEmail:(NSString *)email forResidence:(NSString *)residence
{
    NSError *error = nil;
    [SSKeychain setPassword:residence forService:TB_SERVICE account:email error:&error];
    
    if (error) {
        NSLog(@"WARNING: %s %@", __PRETTY_FUNCTION__, error);
    }
    
    self.accounts = [NSMutableArray arrayWithArray:[SSKeychain accountsForService:TB_SERVICE]];
    [self.accountsTableView reloadData];
}

#pragma mark TBRegistrationOperationDelegate
-(void)didSucceedWithRegistrationForEmail:(NSString *)email residence:(NSString *)residence
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
    
    UIAlertView* userUnauthorisedAlertView = [[UIAlertView alloc] initWithTitle:@"New Registration" message:[NSString stringWithFormat:@"Please check your email %@.", email] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    
    [userUnauthorisedAlertView show];    
}

-(void)didFailOnRegistrationWithError:(NSError*)error
{
    NSLog(@"WARNING: %s %@", __PRETTY_FUNCTION__, error);
}

#pragma mark TBNSErrorDelegate
-(void)didFailWithCannonConnectToHost:(NSError *)error
{
    UIAlertView* cannotConnectToHostAlertView = [[UIAlertView alloc] initWithTitle:@"Cannot connect to host" message:@"The was a problem connecting to the host. Please check your internet connection and try again." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
    
    [cannotConnectToHostAlertView show];
}

#pragma mark UITableViewDatasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
return [self.accounts count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *emailCell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(!emailCell)
    {
        emailCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
        emailCell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    
    NSString* email = [[self.accounts objectAtIndex:indexPath.row] objectForKey:@"acct"];
    emailCell.textLabel.text = email;

    tbBmailStatus(TBEmailStatusVerified)(emailCell);
    
return emailCell;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle != UITableViewCellEditingStyleDelete) {
        return;
    }
    
    if(editingStyle == UITableViewCellSelectionStyleNone){
        return;
    }
    
    NSString* email = [[self.accounts objectAtIndex:indexPath.row] objectForKey:@"acct"];
    [SSKeychain deletePasswordForService:TB_SERVICE account:email];
    [self.accounts removeObjectAtIndex:indexPath.row];
    
    [self.accountsTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationLeft];
}


#pragma mark UITableViewDelegate
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell* tableViewCell = [tableView cellForRowAtIndexPath:indexPath];
    tbBmailStatus(TBEmailStatusUnknown)(tableViewCell);

    __weak NSObject<TBVerifyUserOperationDelegate> *wself = self;
    
    TBVerifyOperationBlock *verifyOperationBlock = [TBVerifyOperationBlock new];
    verifyOperationBlock.didSucceedWithVerificationForEmail = ^(NSString* email, NSDictionary* residence)
    {
        tbBmailStatus(TBEmailStatusVerified)(tableViewCell);
        [wself didSucceedWithVerificationForEmail:email residence:residence];
    };
    
    verifyOperationBlock.didFailOnVerifyWithError = ^(NSError* error)
    {
        tbBmailStatus(TBEmailStatusError)(tableViewCell);

        if(NSURLErrorNotConnectedToInternet == error.code){
            UIAlertView* notConnectedToInternetAlertView = [[UIAlertView alloc] initWithTitle:@"Not Connected to Internet" message:@"You are not connected to the internet. Check your connection and try again." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Ok", nil];
            
            [notConnectedToInternetAlertView show];            
        return;
        }

        [wself didFailOnVerifyWithError:error];
    };
    
    NSArray* emails = [SSKeychain accountsForService:TB_SERVICE];
    NSString* email = [[emails objectAtIndex:indexPath.row] objectForKey:@"acct"];
    
    NSError *error = nil;
    NSString *residence = [SSKeychain passwordForService:TB_SERVICE account:email error:&error];
    
    AFHTTPRequestOperation *verifyUser = [TBQueries newVerifyUserQuery:verifyOperationBlock email:email residence:residence];
    
    [self.operations addOperation:verifyUser];
}

-(IBAction)didTouchUpInsideIdentify:(id)sender
{
    TBEmailViewController* emailViewController = [TBEmailViewController newEmailViewController];
    emailViewController.delegate = self;
    emailViewController.createUserOperationDelegate = self;
    
    [self.navigationController pushViewController:emailViewController animated:YES];
}
@end
