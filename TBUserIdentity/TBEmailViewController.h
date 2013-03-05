//
//  TBEmailViewController.h
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

#import <UIKit/UIKit.h>
#import "TBCreateUserOperationDelegate.h"

@class TBButton;

/**

*/
@protocol TBEmailViewControllerDelegate <NSObject>

/**
 Callback
 
 @param email the email as entered by the user
 @param residence
*/
-(void)didEnterEmail:(NSString*)email forResidence:(NSString*)residence;

@end
/**
  Asks the user for her email and makes a new registration with server.
 
*/
@interface TBEmailViewController : UIViewController <UITextFieldDelegate>

@property (nonatomic, weak) IBOutlet UITextField *emailTextField;
@property (nonatomic, weak) IBOutlet UIButton *registerButton;
@property (nonatomic, weak) id<TBCreateUserOperationDelegate> createUserOperationDelegate;
@property (nonatomic, weak) id<TBEmailViewControllerDelegate> delegate;

+(TBEmailViewController*)newEmailViewController;
-(IBAction)didTouchUpInsideRegister:(id)sender;
@end
