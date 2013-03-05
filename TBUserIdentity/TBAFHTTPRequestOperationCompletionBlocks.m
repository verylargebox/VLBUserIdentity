//
//  TBAFHTTPRequestOperationCompletionBlocks.m
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

#import "TBAFHTTPRequestOperationCompletionBlocks.h"

@interface TBAFHTTPRequestOperationFailureBlockOnErrorCode()
@property(nonatomic, copy)TBAFHTTPRequestOperationErrorBlock errorBlock;
@property(nonatomic, copy)TBAFHTTPRequestOperationCompletionBlock block;
-(id)initWithCompletionBlock:(TBAFHTTPRequestOperationCompletionBlock)block forError:(TBAFHTTPRequestOperationErrorBlock)errorBlock;
@end

@implementation TBAFHTTPRequestOperationFailureBlockOnErrorCode

+(TBAFHTTPRequestOperationFailureBlockOnErrorCode*)cannotConnectToHost:(TBAFHTTPRequestOperationCompletionBlock)block {
return [[TBAFHTTPRequestOperationFailureBlockOnErrorCode alloc] initWithCompletionBlock:block forError:tbErrorBlockCannotConnectToHost()];
}

-(id)initWithCompletionBlock:(TBAFHTTPRequestOperationCompletionBlock)block forError:(TBAFHTTPRequestOperationErrorBlock)errorBlock
{
    self = [super init];
    
    if(!self){
        return nil;
    }
    
    self.block = block;
    self.errorBlock = errorBlock;
    
return self;
}

-(BOOL)failure:(AFHTTPRequestOperation*) operation error:(NSError*)error
{
    NSLog(@"WARNING: %s %@", __PRETTY_FUNCTION__, error);

    if(!self.errorBlock(error)){
        return NO;
    }
    
    self.block(operation);
    
return YES;
}
@end

@implementation TBAFHTTPRequestOperationCompletionBlocks

@end
