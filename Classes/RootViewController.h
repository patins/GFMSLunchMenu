//
//  RootViewController.h
//  Lunch Menu
//
//  Created by Patrick Insinger on 8/18/10.
//  Copyright (c) 2010 Insinger Tech. All rights reserved.
//

#import "Lunches.h"

@interface RootViewController : UITableViewController {
	Lunches *mainLunches; // for getting lunch info
	int recentLunchIndex; // keep track of old lunches
}



@end

