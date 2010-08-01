//
//  LeavesViewController.m
//  Leaves
//
//  Created by Tom Brow on 4/18/10.
//  Copyright Tom Brow 2010. All rights reserved.
//

#import "LeavesViewController.h"

@implementation LeavesViewController

- (void) initialize {
   leavesView = [[LeavesView alloc] initWithFrame:CGRectZero];
}

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)nibBundle
{
   if (self = [super initWithNibName:nibName bundle:nibBundle]) {
      [self initialize];
   }
   return self;
}

- (id)init {
   return [self initWithNibName:nil bundle:nil];
}

- (void) awakeFromNib {
	[super awakeFromNib];
	[self initialize];
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
