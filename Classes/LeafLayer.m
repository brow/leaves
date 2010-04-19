//
//  LeavesLayer.m
//  Leaves
//
//  Created by Tom Brow on 4/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LeafLayer.h"


@implementation LeafLayer

@synthesize reverse, image;

- (void)drawInContext:(CGContextRef)ctx {
	if (image)
		CGContextDrawImage(ctx, self.bounds, [image CGImage]);
}

@end
