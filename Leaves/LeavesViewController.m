//
//  LeavesViewController.m
//  Leaves
//
//  Created by Tom Brow on 4/18/10.
//  Copyright Tom Brow 2010. All rights reserved.
//

#import "LeavesViewController.h"
#import "LeavesView.h"

@interface LeavesViewController () <LeavesViewDataSource, LeavesViewDelegate>

@end

@implementation LeavesViewController

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)nibBundle {
    if (self = [super initWithNibName:nibName bundle:nibBundle]) {
        _leavesView = [[LeavesView alloc] initWithFrame:CGRectZero];
        _leavesView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
        _leavesView.dataSource = self;
        _leavesView.delegate = self;
    }
    return self;
}

- (void)dealloc {
	[_leavesView release];
    [super dealloc];
}

#pragma mark LeavesViewDataSource

- (NSUInteger)numberOfPagesInLeavesView:(LeavesView*)leavesView {
	return 0;
}

- (void)renderPageAtIndex:(NSUInteger)index inContext:(CGContextRef)ctx {
	
}

#pragma mark UIViewController

- (void)viewDidLoad {
	[super viewDidLoad];
    
    _leavesView.frame = self.view.bounds;
	[self.view addSubview:_leavesView];
	[_leavesView reloadData];
}

@end
