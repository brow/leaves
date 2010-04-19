//
//  LeavesViewController.m
//  Leaves
//
//  Created by Tom Brow on 4/18/10.
//  Copyright __MyCompanyName__ 2010. All rights reserved.
//

#import "LeavesViewController.h"

@implementation LeavesViewController

- (id)init {
    if (self = [super init]) {
		leavesView = [[LeavesView alloc] initWithFrame:CGRectZero];
    }
    return self;
}

- (void)dealloc {
	[leavesView release];
    [super dealloc];
}

- (void)loadView {
	[super loadView];
	leavesView.frame = self.view.bounds;
	[self.view addSubview:leavesView];
}

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

@end
