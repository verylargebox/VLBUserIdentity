//
//  NSString+TBString.h
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

#import <Foundation/Foundation.h>

/**
 Category on NSString
*/
@interface NSString (TBString)

/**
 Creates a new hex NSString that represents the given data.
 Each character in data is created in the equivelent hex.
 
 @param data the char array to convert to an hex NSString
 @param length the length of the data array
 @return a hex NSString that has double the length of the given data
*/
+(NSString*)stringHexFromData:(uint8_t[])data size:(NSUInteger)length;

@end
