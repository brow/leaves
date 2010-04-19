//
//  ExampleViewController.h
//  Leaves
//
//  Created by Tom Brow on 4/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LeavesViewController.h"

@interface ExampleViewController : LeavesViewController <LeavesViewDataSource, LeavesViewDelegate> {
	NSArray *images;
}

@end
