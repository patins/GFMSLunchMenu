//
//  Lunches.h
//  Lunch Menu
//
//  Created by Patrick Insinger on 8/18/10.
//  Copyright (c) 2010 Insinger Tech. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Lunch.h"


@interface Lunches : NSObject {
	NSArray *lunchesArray; // to hold all of the lunch dictionaries
	NSDictionary *temporaryLunchDictionary; // a temporary dictionary to hold lunch information
}

@property (nonatomic, retain) NSArray *lunchesArray;
@property (nonatomic, retain) NSDictionary *temporaryLunchDictionary;

-(void)fillArrayWithFile;
-(int)getRecentLunchIndex; // get todays most recent lunch
-(int)getNumberOfLunches; // counts number of objects in lunchesArray
-(Lunch *)getLunchWithIndex:(int)index; // to find a lunch with an index
-(NSString *)getFilePath;

-(void)dealloc;


@end
