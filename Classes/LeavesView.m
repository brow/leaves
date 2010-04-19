//
//  LeavesView.m
//  Leaves
//
//  Created by Tom Brow on 4/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "LeavesView.h"

@implementation LeavesView

@synthesize leafEdge;

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		topPage = [[CALayer alloc] init];
		
		topPageImage = [[CALayer alloc] init];
		topPageImage.masksToBounds = YES;
		topPageImage.contentsGravity = kCAGravityLeft;
		topPageImage.contents = (id)[[UIImage imageNamed:@"kitten.png"] CGImage];
		
		topPageShadow = [[CAGradientLayer alloc] init];
		topPageShadow.colors = [NSArray arrayWithObjects:
										(id)[[[UIColor blackColor] colorWithAlphaComponent:0.6] CGColor],
										(id)[[UIColor clearColor] CGColor],
										nil];
		topPageShadow.startPoint = CGPointMake(1,0.5);
		topPageShadow.endPoint = CGPointMake(0,0.5);
		
		topPageReverse = [[CALayer alloc] init];
		topPageReverse.masksToBounds = YES;
		
		topPageReverseImage = [[CALayer alloc] init];
		topPageReverseImage.masksToBounds = YES;
		topPageReverseImage.contentsGravity = kCAGravityRight;
		topPageReverseImage.contents = (id)[[UIImage imageNamed:@"kitten.png"] CGImage];
		
		topPageReverseOverlay = [[CALayer alloc] init];
		topPageReverseOverlay.backgroundColor = [[[UIColor whiteColor] colorWithAlphaComponent:0.8] CGColor];
		
		topPageReverseShading = [[CAGradientLayer alloc] init];
		topPageReverseShading.colors = [NSArray arrayWithObjects:
								(id)[[[UIColor blackColor] colorWithAlphaComponent:0.6] CGColor],
								(id)[[UIColor clearColor] CGColor],
								nil];
		topPageReverseShading.startPoint = CGPointMake(1,0.5);
		topPageReverseShading.endPoint = CGPointMake(0,0.5);
		
		bottomPage = [[CALayer alloc] init];
		bottomPage.masksToBounds = YES;
		bottomPage.contents = (id)[[UIImage imageNamed:@"kitten2.png"] CGImage];
		
		bottomPageShadow = [[CAGradientLayer alloc] init];
		bottomPageShadow.colors = [NSArray arrayWithObjects:
										(id)[[[UIColor blackColor] colorWithAlphaComponent:0.6] CGColor],
										(id)[[UIColor clearColor] CGColor],
										nil];
		bottomPageShadow.startPoint = CGPointMake(0,0.5);
		bottomPageShadow.endPoint = CGPointMake(1,0.5);
		
		[topPage addSublayer:topPageImage];
		[topPage addSublayer:topPageShadow];
		[topPageReverse addSublayer:topPageReverseImage];
		[topPageReverse addSublayer:topPageReverseOverlay];
		[topPageReverse addSublayer:topPageReverseShading];
		[bottomPage addSublayer:bottomPageShadow];
		[self.layer addSublayer:bottomPage];
		[self.layer addSublayer:topPage];
		[self.layer addSublayer:topPageReverse];
		
		self.leafEdge = 1.0;
    }
    return self;
}

- (void)dealloc {
	[topPage release];
	[topPageImage release];
	[topPageShadow release];
	[topPageReverse release];
	[topPageReverseImage release];
	[topPageReverseOverlay release];
	[topPageReverseShading release];
	[bottomPage release];
	[bottomPageShadow release];
    [super dealloc];
}

#pragma mark properties

- (void) setLeafEdge:(CGFloat)aLeafEdge {
	leafEdge = aLeafEdge;
	topPageShadow.opacity = MIN(1.0, 4*(1-leafEdge));
	[self setNeedsLayout];
}

#pragma mark UIView methods

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	UITouch *touch = [event.allTouches anyObject];
	CGPoint touchPoint = [touch locationInView:self];
	self.leafEdge = touchPoint.x / self.bounds.size.width;
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	self.leafEdge = 1.0;
}

- (void) layoutSubviews {
	[super layoutSubviews];
	
	topPage.frame = CGRectMake(self.layer.bounds.origin.x, 
									self.layer.bounds.origin.y, 
									leafEdge * self.bounds.size.width, 
									self.layer.bounds.size.height);
	topPageReverse.frame = CGRectMake(self.layer.bounds.origin.x + (2*leafEdge-1) * self.bounds.size.width, 
										   self.layer.bounds.origin.y, 
										   (1-leafEdge) * self.bounds.size.width, 
										   self.layer.bounds.size.height);
	bottomPage.frame = self.layer.bounds;
	
	topPageImage.frame = topPage.bounds;
	topPageShadow.frame = CGRectMake(topPageReverse.frame.origin.x - 40, 
									 0, 
									 40, 
									 bottomPage.bounds.size.height);
	topPageReverseImage.frame = topPageReverse.bounds;
	topPageReverseImage.transform = CATransform3DMakeScale(-1, 1, 1);
	topPageReverseOverlay.frame = topPageReverse.bounds;
	topPageReverseShading.frame = CGRectMake(topPageReverse.bounds.size.width - 50, 
											 0, 
											 50 + 1, 
											 topPageReverse.bounds.size.height);
	bottomPageShadow.frame = CGRectMake(leafEdge * self.bounds.size.width, 
										0, 
										40, 
										bottomPage.bounds.size.height);
}

@end
