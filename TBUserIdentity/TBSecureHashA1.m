//
//  TBSecureHashA1.m
//  TBUserIdentity
//
//  Created by Markos Charatzas on 21/11/2012.
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

#import "TBSecureHashA1.h"
#import "NSString+TBString.h"
#include <CommonCrypto/CommonDigest.h>

@interface TBSecureHashA1 ()
-(NSString*)uuid;
@end

@implementation TBSecureHashA1

-(NSString*)uuid
{
    CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
    NSString *uuidStr = (__bridge_transfer NSString *)CFUUIDCreateString(kCFAllocatorDefault, uuid);
    CFRelease(uuid);
    
return uuidStr;
}

-(NSString*)newKey {
return [self newKey:[self uuid]];
}

-(NSString*)newKey:(NSString*)digest
{
    uint8_t sha1hash[CC_SHA1_DIGEST_LENGTH];
    NSData* uuid = [digest dataUsingEncoding:NSUTF8StringEncoding];
    
    if (!CC_SHA1(uuid.bytes, uuid.length, sha1hash) ) {
        return nil;
    }
    
return [NSString stringHexFromData:sha1hash size:CC_SHA1_DIGEST_LENGTH];
}

@end
