//
//  LunchInfoViewController.h
//  Lunch Menu
//
//  Created by Patrick Insinger on 8/22/10.
//  Copyright 2010 Insinger Tech. All rights reserved.
//
#import <UIKit/UIKit.h>
#import "Lunches.h"


@interface LunchInfoViewController : UITableViewController {
	int selectedLunchIndex; // gets this from the rvc
	NSString *lunchName; // instead of lunch class to make things easier
	NSDate *lunchDate;
}
@property (nonatomic, retain) NSString *lunchName;
@property (nonatomic, retain) NSDate *lunchDate;

-(void)setSelectedLunchIndex:(int)li; // for use by the rvc

@end
