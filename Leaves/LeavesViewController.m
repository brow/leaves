//
//  LeavesViewController.m
//  Leaves
//
//  Created by Tom Brow on 4/18/10.
//  Copyright Tom Brow 2010. All rights reserved.
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

#pragma mark LeavesViewDataSource methods

- (NSUInteger) numberOfPagesInLeavesView:(LeavesView*)leavesView {
	return 0;
}

- (void) renderPageAtIndex:(NSUInteger)index inContext:(CGContextRef)ctx {
	
}

#pragma mark  UIViewController methods

- (void)loadView {
	[super loadView];
	leavesView.frame = self.view.bounds;
	leavesView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
	[self.view addSubview:leavesView];
}

- (void) viewDidLoad {
	[super viewDidLoad];
	leavesView.dataSource = self;
	leavesView.delegate = self;
	[leavesView reloadData];
}

@end
