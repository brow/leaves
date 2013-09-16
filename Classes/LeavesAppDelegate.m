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
    window.rootViewController = [[UINavigationController alloc] initWithRootViewController:rootViewController];
    [window makeKeyAndVisible];
	
	return YES;
}


- (void)dealloc {
    [window release];
    [super dealloc];
}

@end
