//
//  Lunch.m
//  Lunch Menu
//
//  Created by Patrick Insinger on 8/22/10.
//  Copyright 2010 Insinger Tech. All rights reserved.
//

#import "Lunch.h"

@implementation Lunch

@synthesize lunchDate, lunchName;

-(void)setLunchDate:(NSDate *)d{
	lunchDate = d;
}
-(void)setLunchName:(NSString *)n{
	lunchName = n;
}

-(NSString *)getShortDate{
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	NSString *formattedDate = @"unformatted";
	
	[dateFormatter setDateFormat:@"EEEE d, MMMM y"];
	
	formattedDate = [dateFormatter stringFromDate:lunchDate];
	
	[dateFormatter autorelease];
	
	return formattedDate;
	
}

@end
