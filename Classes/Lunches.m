//
//  Lunches.m
//  Lunch Menu
//
//  Created by Patrick Insinger on 8/18/10.
//  Copyright (c) 2010 Insinger Tech. All rights reserved.
//

#import "Lunches.h"

@implementation Lunches

NSArray *lunchesArray;
NSDictionary *temporaryLunchDictionary;

@synthesize lunchesArray, temporaryLunchDictionary;

-(NSString *)getFilePath{
	NSArray *pathArray =
	NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	return [pathArray objectAtIndex:0];
}

-(void)fillArrayWithFile {
	temporaryLunchDictionary = [[NSDictionary dictionary] retain];
	NSString *plistPath = [[self getFilePath] stringByAppendingPathComponent:@"Lunches"];
	if([[NSFileManager defaultManager] fileExistsAtPath:plistPath] == YES){
		lunchesArray = [[NSArray arrayWithContentsOfFile:plistPath] retain];
	} else {
		lunchesArray = [[NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"Lunches" ofType:@"plist"]]retain];
	}
}

-(int)getRecentLunchIndex {
	NSDate *today  = [[NSDate alloc] initWithTimeIntervalSinceNow:0]; //get todays date
	NSDate *tempDate = [[NSDate alloc] initWithTimeIntervalSinceNow:0]; // prepares date for use
	
	[today autorelease];
	[tempDate autorelease];
	
	int i;
	for (i = 0; i < [self getNumberOfLunches]; i++) {
		temporaryLunchDictionary = [lunchesArray objectAtIndex:i]; // puts lunch from array into dictionary
		tempDate = [temporaryLunchDictionary objectForKey:@"date"]; // extracts the date from the dictionary
		if([tempDate compare:today] == NSOrderedDescending){ // compares the temp date to today and sees if today before tempdate
			return i; // if it is then return the value
		}
	}
	
	return [self getNumberOfLunches]; // if you couldn't find anything just return a 0
}

-(int)getNumberOfLunches {
	return [lunchesArray count]; // number of items in the array
}

-(Lunch *)getLunchWithIndex:(int)index {
	
	Lunch *tempLunch = [Lunch new]; // create a new lunch object, this is what we will return
	
	if(YES){
		temporaryLunchDictionary = [lunchesArray objectAtIndex:index];
		
		[tempLunch setLunchDate:[temporaryLunchDictionary objectForKey:@"date"]]; // get date from dictionary and put it into templunch
		[tempLunch setLunchName:[temporaryLunchDictionary objectForKey:@"name"]]; // get name from dictionary and put it into templunch
	}
	
	[tempLunch autorelease];
	
	return tempLunch;
	
}

-(void)dealloc{
	[super dealloc];
	[lunchesArray release];
}

@end
