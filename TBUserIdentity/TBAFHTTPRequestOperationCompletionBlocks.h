//
//  TBAFHTTPRequestOperationCompletionBlocks.h
//  TBUserIdentity
//
//  Created by Markos Charatzas on 08/12/2012.
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
#import "AFHTTPRequestOperation.h"

@class TBAFHTTPRequestOperationFailureBlockOnErrorCode;

typedef void(^TBAFHTTPRequestOperationCompletionBlock)(AFHTTPRequestOperation *operation);
typedef BOOL(^TBAFHTTPRequestOperationErrorBlock)(NSError *error);

NS_INLINE
TBAFHTTPRequestOperationErrorBlock tbAFHTTPRequestOperationError(NSInteger NSURLErrorCode)
{
    TBAFHTTPRequestOperationErrorBlock requestOperationError = ^BOOL(NSError *error){
        return error.code == NSURLErrorCode;
    };
    
return requestOperationError;
}

/**
 
 **/
NS_INLINE
TBAFHTTPRequestOperationErrorBlock tbErrorBlockCannotConnectToHost(){
return tbAFHTTPRequestOperationError(NSURLErrorCannotConnectToHost);
}

NS_INLINE
TBAFHTTPRequestOperationCompletionBlock tbAFHTTPRequestOperationErrorNoOp() {
return ^(AFHTTPRequestOperation *operation){};
}

/**
  Implementations should handle failures blocks in AFHTTPRequestOperation(s)
*/
@protocol TBAFHTTPRequestOperationFailureBlock <NSObject>

/**
 Handles the failure block.
 
 @param operation the operation in failure under AFHTTPRequestOperation:setCompletionBlockWithSuccess:failure:
 @param error the error in failure under AFHTTPRequestOperation:setCompletionBlockWithSuccess:failure:
 @return YES if the error is handled
*/
-(BOOL)failure:(AFHTTPRequestOperation*) operation error:(NSError*)error;
@end

/**
 Handles a failure block relating to an error code.
*/
@interface TBAFHTTPRequestOperationFailureBlockOnErrorCode : NSObject <TBAFHTTPRequestOperationFailureBlock>

/**
 Creates a new TBAFHTTPRequestOperationFailureBlock to handle a cannot connect to host error.
 
 @param block the block to execute for the error
 @return a new TBAFHTTPRequestOperationFailureBlock that handles an error with code NSURLErrorCannotConnectToHost
*/
+(TBAFHTTPRequestOperationFailureBlockOnErrorCode*)cannotConnectToHost:(TBAFHTTPRequestOperationCompletionBlock)block;

/**
 
 @param operation the operation as passed in failure under AFHTTPRequestOperation:setCompletionBlockWithSuccess:failure:
 @param error the error as passed in failure under AFHTTPRequestOperation:setCompletionBlockWithSuccess:failure:
 @return YES if the error is handled by self
*/
-(BOOL)failure:(AFHTTPRequestOperation*) operation error:(NSError*)error;
@end

/**
 Provides access to all avaible AFHTTPRequestOperation completion blocks that can be used in
 AFHTTPRequestOperation:setCompletionBlockWithSuccess:failure:
 
*/
@interface TBAFHTTPRequestOperationCompletionBlocks : NSObject


@end
