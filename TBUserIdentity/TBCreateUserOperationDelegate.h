//
//  TBRegisterOperationDelegate.h
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

#import <Foundation/Foundation.h>
#import "TBNSErrorDelegate.h"

@protocol TBCreateUserOperationDelegate <NSObject, TBNSErrorDelegate>

/**
 Callback by TheBoxQueries#newCreateUserQuery:email: when succesfuly created a user.
 
 @param email the email as entered by the user
 @param residence a residence id created for the user
*/
-(void)didSucceedWithRegistrationForEmail:(NSString*)email residence:(NSString*)residence;

/**
 Callback by TheBoxQueries#newCreateUserQuery:email: when failed to create a user.
 
 @param error the error
*/
-(void)didFailOnRegistrationWithError:(NSError*)error;

@end
