//
//  LeavesAppDelegate.m
//  Leaves
//
//  Created by Tom Brow on 4/18/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "LeavesAppDelegate.h"
#import "LeavesViewController.h"

@implementation LeavesAppDelegate

@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {    	
	viewController = [[LeavesViewController alloc] init];
    
	[window addSubview:viewController.view];
    [window makeKeyAndVisible];
	
	return YES;
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
