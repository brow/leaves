//
//  LeavesAppDelegate.m
//  Leaves
//
//  Created by Tom Brow on 4/18/10.
//  Copyright Tom Brow 2010. All rights reserved.
//

#import "LeavesAppDelegate.h"
#import "ExamplesViewController.h"

@implementation LeavesAppDelegate

@synthesize window;

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
	UIViewController *rootViewController = [[[ExamplesViewController alloc] init] autorelease];
	viewController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    
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
