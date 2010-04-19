//
//  LeavesView.m
//  Leaves
//
//  Created by Tom Brow on 4/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LeavesView.h"

@implementation LeavesView


- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		leafEdge = 1.0;
		
		topPageLayer = [[CALayer alloc] init];
		
		topPageImageLayer = [[CALayer alloc] init];
		topPageImageLayer.masksToBounds = YES;
		topPageImageLayer.contentsGravity = kCAGravityLeft;
		topPageImageLayer.contents = (id)[[UIImage imageNamed:@"kitten.png"] CGImage];
		
		reverseLayer = [[CALayer alloc] init];
		
		reverseImageLayer = [[CALayer alloc] init];
		reverseImageLayer.masksToBounds = YES;
		reverseImageLayer.contentsGravity = kCAGravityRight;
		reverseImageLayer.contents = (id)[[UIImage imageNamed:@"kitten.png"] CGImage];
		
		reverseOverlayLayer = [[CALayer alloc] init];
		reverseOverlayLayer.backgroundColor = [[[UIColor whiteColor] colorWithAlphaComponent:0.8] CGColor];
		
		bottomPageLayer = [[CALayer alloc] init];
		bottomPageLayer.contents = (id)[[UIImage imageNamed:@"kitten2.png"] CGImage];
		
		bottomPageShadowLayer = [[CAGradientLayer alloc] init];
		bottomPageShadowLayer.colors = [NSArray arrayWithObjects:
										(id)[[UIColor blackColor] CGColor],
										(id)[[UIColor clearColor] CGColor],
										nil];
		bottomPageShadowLayer.startPoint = CGPointMake(0,0.5);
		bottomPageShadowLayer.endPoint = CGPointMake(1,0.5);
		bottomPageShadowLayer.opacity = 0.6;
		
		[topPageLayer addSublayer:topPageImageLayer];
		[reverseLayer addSublayer:reverseImageLayer];
		[reverseLayer addSublayer:reverseOverlayLayer];
		[bottomPageLayer addSublayer:bottomPageShadowLayer];
		[self.layer addSublayer:bottomPageLayer];
		[self.layer addSublayer:topPageLayer];
		[self.layer addSublayer:reverseLayer];
    }
    return self;
}

- (void)dealloc {
	[topPageLayer release];
	[topPageImageLayer release];
	[topPageShadowLayer release];
	[reverseLayer release];
	[reverseImageLayer release];
	[reverseOverlayLayer release];
	[bottomPageLayer release];
	[bottomPageShadowLayer release];
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
	
	topPageLayer.frame = CGRectMake(self.layer.bounds.origin.x, 
									self.layer.bounds.origin.y, 
									leafEdge * self.bounds.size.width, 
									self.layer.bounds.size.height);
	reverseLayer.frame = CGRectMake(self.layer.bounds.origin.x + (2*leafEdge-1) * self.bounds.size.width, 
										   self.layer.bounds.origin.y, 
										   (1-leafEdge) * self.bounds.size.width, 
										   self.layer.bounds.size.height);
	bottomPageLayer.frame = self.layer.bounds;
	
	topPageImageLayer.frame = topPageLayer.bounds;
	reverseImageLayer.frame = reverseLayer.bounds;
	reverseImageLayer.transform = CATransform3DMakeScale(-1, 1, 1);
	reverseOverlayLayer.frame = reverseLayer.bounds;
	bottomPageShadowLayer.frame = CGRectMake(leafEdge * self.bounds.size.width, 
											 0, 
											 40, 
											 bottomPageLayer.bounds.size.height);
}

@end
