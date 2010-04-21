    //
//  ExampleViewController.m
//  Leaves
//
//  Created by Tom Brow on 4/18/10.
//  Copyright 2010 Tom Brow. All rights reserved.
//

#import "ImageExampleViewController.h"
#import "Utilities.h"

@implementation ImageExampleViewController

- (id)init {
    if (self = [super init]) {
		images = [[NSArray alloc] initWithObjects:
				  [UIImage imageNamed:@"kitten.jpg"],
				  [UIImage imageNamed:@"kitten2.jpg"],
				  [UIImage imageNamed:@"kitten3.jpg"],
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
	CGRect imageRect = CGRectMake(0, 0, image.size.width, image.size.height);
	CGAffineTransform transform = aspectFit(imageRect,
											CGContextGetClipBoundingBox(ctx));
	CGContextConcatCTM(ctx, transform);
	CGContextDrawImage(ctx, imageRect, [image CGImage]);
}

@end
