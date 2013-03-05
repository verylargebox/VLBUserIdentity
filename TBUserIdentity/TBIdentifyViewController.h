//
//  TBIdentifyViewController.h
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

#import <UIKit/UIKit.h>
#import "TBVerifyUserOperationDelegate.h"
#import "TBCreateUserOperationDelegate.h"
#import "TBEmailViewController.h"

typedef NS_ENUM(NSInteger, TBEmailStatus){
    TBEmailStatusError,
    TBEmailStatusUnknown,
    TBEmailStatusUnauthorised,
    TBEmailStatusVerified
};

typedef void(^TBEmailStatusBlock)(UITableViewCell* tableViewCell);

NS_INLINE
TBEmailStatusBlock tbBmailStatus(TBEmailStatus emailStatus)
{
    switch (emailStatus) {
        case TBEmailStatusError:
            return ^(UITableViewCell *tableViewCell){
                tableViewCell.textLabel.enabled = NO;
                tableViewCell.userInteractionEnabled = YES;
                tableViewCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                tableViewCell.accessoryView = nil;
            };
        case TBEmailStatusUnknown:
            return ^(UITableViewCell *tableViewCell){
                UIActivityIndicatorView* accessoryView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
                [accessoryView startAnimating];
                
                tableViewCell.selected = NO;
                tableViewCell.userInteractionEnabled = NO;
                tableViewCell.textLabel.enabled = NO;
                tableViewCell.accessoryView = accessoryView;
            };
        case TBEmailStatusUnauthorised:
            return ^(UITableViewCell *tableViewCell){
                
                tableViewCell.textLabel.enabled = NO;
                tableViewCell.userInteractionEnabled = YES;
                tableViewCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                tableViewCell.accessoryView = nil;
            };
        case TBEmailStatusVerified:
            return ^(UITableViewCell *tableViewCell){
                tableViewCell.textLabel.enabled = YES;
                tableViewCell.userInteractionEnabled = YES;
                tableViewCell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
                tableViewCell.accessoryView = nil;
            };
    }
}

@interface TBIdentifyViewController : UIViewController <TBVerifyUserOperationDelegate, TBCreateUserOperationDelegate, TBEmailViewControllerDelegate, UITableViewDelegate>

@property (nonatomic, unsafe_unretained) IBOutlet UIButton *identifyButton;
@property (nonatomic, unsafe_unretained) IBOutlet UITableView *accountsTableView;

+(TBIdentifyViewController*)newIdentifyViewController;

-(IBAction)didTouchUpInsideIdentify:(id)sender;
@end
