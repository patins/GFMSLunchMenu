//
//  Lunch_MenuAppDelegate.m
//  Lunch Menu
//
//  Created by Patrick Insinger on 8/18/10.
//  Copyright (c) 2010 Insinger Tech. All rights reserved.
//


#import "Lunch_MenuAppDelegate.h"

@implementation Lunch_MenuAppDelegate


@synthesize window;

@synthesize navigationController;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	
	// Override point for customization after application launch.
    // Add the navigation controller's view to the window and display.
    [window addSubview:navigationController.view];
    [window makeKeyAndVisible];
    return YES;
}

- (void)applicationWillTerminate:(UIApplication *)application {

    // Save data if appropriate.
}

- (void)applicationWillEnterForeground:(UIApplication *)application{
	[[NSNotificationCenter defaultCenter] postNotificationName:@"backFromMultitasking" object:nil];
}

- (void)dealloc {

    [window release];
    [navigationController release];
    [super dealloc];
}

@end

