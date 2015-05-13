//
//  RootViewController.m
//  Lunch Menu
//
//  Created by Patrick Insinger on 8/18/10.
//  Copyright (c) 2010 Insinger Tech. All rights reserved.
//


#import "RootViewController.h"
#import "LunchInfoViewController.h"
#import "Lunches.h"
#import "Reachability.h"

@implementation RootViewController

int recentLunchIndex;

Lunches *mainLunches; // lunch controller
Lunch *tempLunch;

-(void)backFromMultitasking{
	[NSThread detachNewThreadSelector:@selector(loadStuff) toTarget:self withObject:nil];
	
}

-(void)refreshUI{
	recentLunchIndex = [mainLunches getRecentLunchIndex];
	[self.tableView reloadData];
}


-(void)loadStuff{
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	
	NSString *plistURL = @"REDACTED";
	Reachability *r = [Reachability reachabilityWithHostName:@"REDACTED"];
	NetworkStatus internetStatus = [r currentReachabilityStatus];
	if((internetStatus == ReachableViaWiFi) || (internetStatus == ReachableViaWWAN)){
		NSArray *tempDownloadArray = [[NSArray alloc] initWithContentsOfURL:[NSURL URLWithString:plistURL]];
		if ([tempDownloadArray isEqualToArray:mainLunches.lunchesArray] == YES){
		} else {
			mainLunches.lunchesArray = tempDownloadArray;
			NSString *plistPath = [[mainLunches getFilePath] stringByAppendingPathComponent:@"Lunches"];
			[tempDownloadArray writeToFile:plistPath atomically:YES];
			[self performSelector:@selector(refreshUI)];
		}
		[tempDownloadArray release];
	}
	
	[pool release];
}

- (void)viewDidLoad {
    [super viewDidLoad];
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(backFromMultitasking) name:@"backFromMultitasking" object:nil];
	
	self.title = @"GFMS Lunches"; // set title of the view
	
	UIButton *infoButton = [UIButton buttonWithType:UIButtonTypeInfoLight];
	[infoButton addTarget:self action:@selector(showInfoView) forControlEvents:UIControlEventTouchUpInside];
	self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:infoButton];
	
	
	//UIButton *mainButton = [UIButton buttonWithType:UIButt
	//self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemRedo target:self action:nil];
	
	
	mainLunches = [Lunches new]; // new instance
	tempLunch = [[Lunch new] retain];
	[mainLunches fillArrayWithFile]; // load data from file
	
	recentLunchIndex = [mainLunches getRecentLunchIndex]; // save the rli
	
	[NSThread detachNewThreadSelector:@selector(loadStuff) toTarget:self withObject:nil];
	
	
}
											  
-(void)showInfoView{
	UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"About"
													message:@"GFMS Lunch Menu App v1.0\nWe cannot guarantee reliability and accuracy of the data in this application.\n© 2010 Patrick Insinger"
												   delegate:nil
										  cancelButtonTitle:@"Done"
										  otherButtonTitles:nil];
	[alert show];
	[alert release];
	
}

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	// use the lunches class created in viewDidLoad to count the number of dictionaries
	return [mainLunches getNumberOfLunches]-recentLunchIndex; // give the number of current lunches to show
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
	
	// set up the cell
	
	cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator; // adds style to cell	
	
	tempLunch = [mainLunches getLunchWithIndex:indexPath.row+recentLunchIndex]; // get the lunch info
	
	cell.textLabel.text = tempLunch.lunchName; // get the name
	
	cell.detailTextLabel.text = [tempLunch getShortDate]; // get the date
	
	cell.selectionStyle = UITableViewCellSelectionStyleBlue;
	

    return cell;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source.
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	LunchInfoViewController *lunchInfoViewController = [[LunchInfoViewController alloc] initWithNibName:@"LunchInfoViewController" bundle:nil];
	// creates a new dvc
	
	[lunchInfoViewController setSelectedLunchIndex:indexPath.row+recentLunchIndex];
	
	[self.navigationController pushViewController:lunchInfoViewController animated:YES];
	// show the dvc
	
	[lunchInfoViewController release];
}

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}

- (void)dealloc {
    [super dealloc];
	[mainLunches release];
	[tempLunch release];
}

@end

