//
//  MinimalExampleViewController.m
//  Leaves
//
//  Created by Tom Brow on 4/20/10.
//  Copyright 2010 Tom Brow. All rights reserved.
//

#import "ProceduralExampleViewController.h"


@implementation ProceduralExampleViewController

#pragma mark LeavesViewDataSource methods

- (NSUInteger) numberOfPagesInLeavesView:(LeavesView*)leavesView {
	return 10;
}

- (void) renderPageAtIndex:(NSUInteger)index inContext:(CGContextRef)ctx {
	CGRect bounds = CGContextGetClipBoundingBox(ctx);
	CGContextSetFillColorWithColor(ctx, [[UIColor colorWithHue:index/10.0 
													saturation:0.8
													brightness:0.8 
														 alpha:1.0] CGColor]);
	CGContextFillRect(ctx, CGRectInset(bounds, 100, 100));
}

@end
