    //
//  ExampleViewController.m
//  Leaves
//
//  Created by Tom Brow on 4/18/10.
//  Copyright 2010 Tom Brow. All rights reserved.
//

#import "ImageExampleViewController.h"
#import "Utilities.h"

@interface ImageExampleViewController ()

@property (readonly) NSArray *images;

@end

@implementation ImageExampleViewController

- (id)init {
    if (self = [super init]) {
		_images = [[NSArray alloc] initWithObjects:
                   [UIImage imageNamed:@"kitten.jpg"],
                   [UIImage imageNamed:@"kitten2.jpg"],
                   [UIImage imageNamed:@"kitten3.jpg"],
                   nil];
    }
    return self;
}

- (void)dealloc {
	[_images release];
    [super dealloc];
}

#pragma mark LeavesViewDataSource

- (NSUInteger)numberOfPagesInLeavesView:(LeavesView*)leavesView {
	return _images.count;
}

- (void)renderPageAtIndex:(NSUInteger)index inContext:(CGContextRef)ctx {
	UIImage *image = [_images objectAtIndex:index];
	CGRect imageRect = CGRectMake(0, 0, image.size.width, image.size.height);
	CGAffineTransform transform = aspectFit(imageRect,
											CGContextGetClipBoundingBox(ctx));
	CGContextConcatCTM(ctx, transform);
	CGContextDrawImage(ctx, imageRect, [image CGImage]);
}

@end
