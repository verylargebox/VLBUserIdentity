//
//  Copyright 2010 TheBox
//  
//
//  This file is part of TheBox
//
//  Created by Markos Charatzas (@qnoid) on 20/03/2011.
//  Contributor(s): .-
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

#import "TBQueries.h"
#import "AFHTTPClient.h"
#import "AFHTTPRequestOperation.h"
#import "JSONKit.h"
#import "NSMutableDictionary+TBMutableDictionary.h"
#import "TBCreateUserOperationDelegate.h"
#import "TBVerifyUserOperationDelegate.h"
#import "TBSecureHashA1.h"
#import "TBAFHTTPRequestOperationCompletionBlocks.h"
#import "TBNSErrorDelegate.h"
#import "AFNetworkActivityIndicatorManager.h"


@implementation TBQueries

NSString* const TB_SERVICE = @"user-identity-nsconf";

NSString* const BASE_URL_STRING = @"http://user-identity-nsconf.herokuapp.com";
 
NSUInteger const TIMEOUT = 60;

+(void)initialize
{
    [AFNetworkActivityIndicatorManager sharedManager].enabled = YES;
}

+(AFHTTPRequestOperation*)newCreateUserQuery:(NSObject<TBCreateUserOperationDelegate>*)delegate email:(NSString*)email residence:(NSString*)residence
{
    AFHTTPClient *client = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:BASE_URL_STRING]];
    
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    [parameters tbSetObjectIfNotNil:email forKey:@"email"];
    [parameters tbSetObjectIfNotNil:residence forKey:@"residence"];

    NSMutableURLRequest *registrationRequest = [client requestWithMethod:@"POST" path:@"/users" parameters:parameters];
    [registrationRequest addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [registrationRequest setTimeoutInterval:TIMEOUT];

    AFHTTPRequestOperation* request = [client HTTPRequestOperationWithRequest:registrationRequest success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        [delegate didSucceedWithRegistrationForEmail:email residence:residence];
    } 
    failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
        TBAFHTTPRequestOperationFailureBlockOnErrorCode *cannotConnectToHost =
            [TBAFHTTPRequestOperationFailureBlockOnErrorCode cannotConnectToHost:^(AFHTTPRequestOperation *operation){
                [delegate didFailWithCannonConnectToHost:error];
            }];
        
        if([cannotConnectToHost failure:operation error:error]){
            return;
        }

        [delegate didFailOnRegistrationWithError:error];
    }];
    
return request;
}

+(AFHTTPRequestOperation*)newVerifyUserQuery:(NSObject<TBVerifyUserOperationDelegate>*)delegate email:(NSString*)email residence:(NSString*)residence;
{
    AFHTTPClient *client = [AFHTTPClient clientWithBaseURL:[NSURL URLWithString:BASE_URL_STRING]];
    
    NSMutableDictionary* parameters = [NSMutableDictionary dictionary];
    [parameters tbSetObjectIfNotNil:residence forKey:@"residence"];
    [parameters tbSetObjectIfNotNil:email forKey:@"email"];
    
    NSMutableURLRequest *registrationRequest = [client requestWithMethod:@"GET" path:@"/users" parameters:parameters];
    [registrationRequest addValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [registrationRequest setTimeoutInterval:TIMEOUT];
    
    AFHTTPRequestOperation* request = [client HTTPRequestOperationWithRequest:registrationRequest success:^(AFHTTPRequestOperation *operation, id responseObject)
   {
       [delegate didSucceedWithVerificationForEmail:email residence:[[operation.responseString objectFromJSONString] objectForKey:@"residence"]];
   }
   failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
       TBAFHTTPRequestOperationFailureBlockOnErrorCode *cannotConnectToHost =
            [TBAFHTTPRequestOperationFailureBlockOnErrorCode cannotConnectToHost:^(AFHTTPRequestOperation *operation){
                [delegate didFailWithCannonConnectToHost:error];
            }];
       
       if([cannotConnectToHost failure:operation error:error]){
           return;
       }

       [delegate didFailOnVerifyWithError:error];
   }];
    
return request;
}

@end
