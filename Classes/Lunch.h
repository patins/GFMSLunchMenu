//
//  Lunch.h
//  Lunch Menu
//
//  Created by Patrick Insinger on 8/22/10.
//  Copyright 2010 Insinger Tech. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Lunch : NSObject {
	NSString *lunchName;
	NSDate *lunchDate;
}
@property (nonatomic, retain) NSString *lunchName;
@property (nonatomic, retain) NSDate *lunchDate;

-(void)setLunchDate:(NSDate *)d;
-(void)setLunchName:(NSString *)n;
-(NSString *)getShortDate;

@end
