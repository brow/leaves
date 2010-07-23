//
//  LeavesViewController.h
//  Leaves
//
//  Created by Tom Brow on 4/18/10.
//  Copyright Tom Brow 2010. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeavesView.h"

@interface LeavesViewController : UIViewController <LeavesViewDataSource, LeavesViewDelegate> {
	LeavesView *leavesView;
}

// added by Lnkd.com?24 - use designated initializer to avoid continuous loop when loaded from NIB
- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)nibBundle;

- (id)init;

@end

