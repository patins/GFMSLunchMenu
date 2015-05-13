//
//  Lunch_MenuAppDelegate.h
//  Lunch Menu
//
//  Created by Patrick Insinger on 8/18/10.
//  Copyright (c) 2010 Insinger Tech. All rights reserved.
//


#import <UIKit/UIKit.h>

@interface Lunch_MenuAppDelegate : NSObject <UIApplicationDelegate> {

    UIWindow *window;

    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;


@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;
@end

