//
//  TBVerifiedViewController.m
//  TBUserIdentity
//
//  Created by Markos Charatzas on 02/03/2013.
//  Copyright (c) 2013 Markos Charatzas (@qnoid). 
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

#import "TBVerifiedViewController.h"

@interface TBVerifiedViewController ()
@property(nonatomic, strong) NSDictionary* residence;
-(id)initWithBundle:(NSBundle *)nibBundleOrNil residence:(NSDictionary*)residence;
@end

@implementation TBVerifiedViewController

+(instancetype)newVerifiedViewController:(NSDictionary*)residence email:(NSString*)email
{
    TBVerifiedViewController* verifiedViewController =
        [[TBVerifiedViewController alloc] initWithBundle:[NSBundle mainBundle] residence:residence];
    
    UILabel* titleLabel = [[UILabel alloc] init];
    titleLabel.text = email;
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.adjustsFontSizeToFitWidth = YES;
    verifiedViewController.navigationItem.titleView = titleLabel;
    [titleLabel sizeToFit];
    
    verifiedViewController.title = email;

    UIBarButtonItem *closeButton = [[UIBarButtonItem alloc]
                                    initWithTitle:@"Close"
                                    style:UIBarButtonItemStylePlain
                                    target:verifiedViewController
                                    action:@selector(close)];
    
    verifiedViewController.navigationItem.leftBarButtonItem = closeButton;

return verifiedViewController;
}

-(id)initWithBundle:(NSBundle *)nibBundleOrNil residence:(NSDictionary*)residence
{
    self = [super initWithNibName:NSStringFromClass([TBVerifiedViewController class]) bundle:nibBundleOrNil];
    
    if (!self) {
        return nil;
    }
    
    self.residence = residence;
return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)close
{
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark UITableViewDatasource
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [self.residence count];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell"];
    
    if(!cell)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"Cell"];
    }
    
    NSString* key = [[self.residence allKeys] objectAtIndex:indexPath.row];

    cell.textLabel.text = key;
    cell.detailTextLabel.text = [[self.residence objectForKey:key] description];
    
return cell;
}


@end
