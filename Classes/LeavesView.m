//
//  LeavesView.m
//  Leaves
//
//  Created by Tom Brow on 4/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LeavesView.h"
#import "LeafLayer.h"

@implementation LeavesView


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		leafEdge = 1.0;
		
		UIImage *image = [UIImage imageNamed:@"kitten.png"];
		UIImage *image2 = [UIImage imageNamed:@"kitten2.png"];
		
		topPageLayer = [[CALayer alloc] init];
		topPageLayer.contentsGravity = kCAGravityLeft;
		topPageLayer.masksToBounds = YES;
		topPageLayer.contents = (id)[image CGImage];
		
		topPageReverseLayer = [[CALayer alloc] init];
		topPageReverseLayer.contentsGravity = kCAGravityLeft;
		topPageReverseLayer.masksToBounds = YES;	
		topPageReverseLayer.contents = (id)[image CGImage];
		
		bottomPageLayer = [[CALayer alloc] init];
		bottomPageLayer.contents = (id)[image2 CGImage];
		
		[self.layer addSublayer:bottomPageLayer];
		[self.layer addSublayer:topPageLayer];
		[self.layer addSublayer:topPageReverseLayer];
    }
    return self;
}

- (void)dealloc {
	[topPageLayer release];
	[bottomPageLayer release];
    [super dealloc];
}

#pragma mark UIView methods

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [event.allTouches anyObject];
	CGPoint touchPoint = [touch locationInView:self];
	leafEdge = touchPoint.x / self.bounds.size.width;
	[self setNeedsLayout];
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	leafEdge = 1.0;
	[self setNeedsLayout];
}

- (void) layoutSubviews {
	[super layoutSubviews];
	
//	NSLog(@"edge: %f", leafEdge);
	topPageLayer.frame = CGRectMake(self.layer.bounds.origin.x, 
									self.layer.bounds.origin.y, 
									leafEdge * self.bounds.size.width, 
									self.layer.bounds.size.height);
	topPageReverseLayer.frame = CGRectMake(self.layer.bounds.origin.x + (2*leafEdge-1) * self.bounds.size.width, 
										   self.layer.bounds.origin.y, 
										   (1-leafEdge) * self.bounds.size.width, 
										   self.layer.bounds.size.height);
	bottomPageLayer.frame = self.layer.bounds;
}

@end
