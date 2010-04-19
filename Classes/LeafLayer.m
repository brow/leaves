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

- (id)init {
    if (self = [super init]) {
		self.masksToBounds = YES;
//		self.needsDisplayOnBoundsChange = YES;
		self.contentsGravity = kCAGravityLeft;
    }
    return self;
}

- (void) setImage:(UIImage *)aImage {
	[image autorelease];
	image = [aImage retain];
	self.contents = (id)[image CGImage];
//	[self setNeedsDisplay];
}

//- (void)drawInContext:(CGContextRef)ctx{
//	if (image) {
//		CGRect imageRect = CGRectMake(0, 0, image.size.width, image.size.height);
//		CGContextConcatCTM(ctx, CGAffineTransformMakeScale(1, -1));
//		CGContextConcatCTM(ctx, CGAffineTransformMakeTranslation(0, -self.bounds.size.height));
//		CGContextDrawImage(ctx, imageRect, [image CGImage]);
//	}
//}

@end
