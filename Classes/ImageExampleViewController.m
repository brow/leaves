    //
//  ExampleViewController.m
//  Leaves
//
//  Created by Tom Brow on 4/18/10.
//  Copyright 2010 Tom Brow. All rights reserved.
//

#import "ImageExampleViewController.h"


@implementation ImageExampleViewController

- (id)init {
    if (self = [super init]) {
		images = [[NSArray alloc] initWithObjects:
				  [UIImage imageNamed:@"kitten.png"],
				  [UIImage imageNamed:@"kitten2.png"],
				  nil];
    }
    return self;
}

- (void)dealloc {
	[images release];
    [super dealloc];
}

#pragma mark LeavesViewDataSource methods

- (NSUInteger) numberOfPagesInLeavesView:(LeavesView*)leavesView {
	return images.count;
}

- (void) renderPageAtIndex:(NSUInteger)index inContext:(CGContextRef)ctx {
	UIImage *image = [images objectAtIndex:index];
	CGContextDrawImage(ctx,
					   CGContextGetClipBoundingBox(ctx), 
					   [image CGImage]);
}

#pragma mark UIViewController methods

- (void) viewDidLoad {
	[super viewDidLoad];
	leavesView.dataSource = self;
	leavesView.delegate = self;
	[leavesView reloadData];
}

@end
