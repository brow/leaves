//
//  LeavesView.m
//  Leaves
//
//  Created by Tom Brow on 4/18/10.
//  Copyright 2010 Tom Brow. All rights reserved.
//

#import "LeavesView.h"

@interface LeavesView () 

@property (assign) CGFloat leafEdge;

@end

CGFloat distance(CGPoint a, CGPoint b);

@implementation LeavesView

@synthesize delegate;
@synthesize leafEdge, currentPageIndex, backgroundRendering, preferredTargetWidth;

- (void) setUpLayers {
	self.clipsToBounds = YES;
	
	topPage = [[CALayer alloc] init];
	topPage.masksToBounds = YES;
	topPage.contentsGravity = kCAGravityLeft;
	topPage.backgroundColor = [[UIColor whiteColor] CGColor];
	
	topPageOverlay = [[CALayer alloc] init];
	topPageOverlay.backgroundColor = [[[UIColor blackColor] colorWithAlphaComponent:0.2] CGColor];
	
	topPageShadow = [[CAGradientLayer alloc] init];
	topPageShadow.colors = [NSArray arrayWithObjects:
							(id)[[[UIColor blackColor] colorWithAlphaComponent:0.6] CGColor],
							(id)[[UIColor clearColor] CGColor],
							nil];
	topPageShadow.startPoint = CGPointMake(1,0.5);
	topPageShadow.endPoint = CGPointMake(0,0.5);
	
	topPageReverse = [[CALayer alloc] init];
	topPageReverse.backgroundColor = [[UIColor whiteColor] CGColor];
	topPageReverse.masksToBounds = YES;
	
	topPageReverseImage = [[CALayer alloc] init];
	topPageReverseImage.masksToBounds = YES;
	topPageReverseImage.contentsGravity = kCAGravityRight;
	
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
	bottomPage.backgroundColor = [[UIColor whiteColor] CGColor];
	bottomPage.masksToBounds = YES;
	
	bottomPageShadow = [[CAGradientLayer alloc] init];
	bottomPageShadow.colors = [NSArray arrayWithObjects:
							   (id)[[[UIColor blackColor] colorWithAlphaComponent:0.6] CGColor],
							   (id)[[UIColor clearColor] CGColor],
							   nil];
	bottomPageShadow.startPoint = CGPointMake(0,0.5);
	bottomPageShadow.endPoint = CGPointMake(1,0.5);
	
	[topPage addSublayer:topPageShadow];
	[topPage addSublayer:topPageOverlay];
	[topPageReverse addSublayer:topPageReverseImage];
	[topPageReverse addSublayer:topPageReverseOverlay];
	[topPageReverse addSublayer:topPageReverseShading];
	[bottomPage addSublayer:bottomPageShadow];
	[self.layer addSublayer:bottomPage];
	[self.layer addSublayer:topPage];
	[self.layer addSublayer:topPageReverse];
	
	self.leafEdge = 1.0;
}

- (void) initialize {
	backgroundRendering = NO;
	pageCache = [[LeavesCache alloc] initWithPageSize:self.bounds.size];
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		[self setUpLayers];
		[self initialize];
    }
    return self;
}

- (void) awakeFromNib {
	[super awakeFromNib];
	[self setUpLayers];
	[self initialize];
}

- (void)dealloc {
	[topPage release];
	[topPageShadow release];
	[topPageOverlay release];
	[topPageReverse release];
	[topPageReverseImage release];
	[topPageReverseOverlay release];
	[topPageReverseShading release];
	[bottomPage release];
	[bottomPageShadow release];
	
	[pageCache release];
	
    [super dealloc];
}

- (void) reloadData {
	[pageCache flush];
	numberOfPages = [pageCache.dataSource numberOfPagesInLeavesView:self];
	self.currentPageIndex = 0;
}

- (void) getImages {
	if (currentPageIndex < numberOfPages) {
		if (currentPageIndex > 0 && backgroundRendering)
			[pageCache precacheImageForPageIndex:currentPageIndex-1];
		topPage.contents = (id)[pageCache cachedImageForPageIndex:currentPageIndex];
		topPageReverseImage.contents = (id)[pageCache cachedImageForPageIndex:currentPageIndex];
		if (currentPageIndex < numberOfPages - 1)
			bottomPage.contents = (id)[pageCache cachedImageForPageIndex:currentPageIndex + 1];
		[pageCache minimizeToPageIndex:currentPageIndex];
	} else {
		topPage.contents = nil;
		topPageReverseImage.contents = nil;
		bottomPage.contents = nil;
	}
}

- (void) setLayerFrames {
	topPage.frame = CGRectMake(self.layer.bounds.origin.x, 
							   self.layer.bounds.origin.y, 
							   leafEdge * self.bounds.size.width, 
							   self.layer.bounds.size.height);
	topPageReverse.frame = CGRectMake(self.layer.bounds.origin.x + (2*leafEdge-1) * self.bounds.size.width, 
									  self.layer.bounds.origin.y, 
									  (1-leafEdge) * self.bounds.size.width, 
									  self.layer.bounds.size.height);
	bottomPage.frame = self.layer.bounds;
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
	topPageOverlay.frame = topPage.bounds;
}

- (void) willTurnToPageAtIndex:(NSUInteger)index {
	if ([delegate respondsToSelector:@selector(leavesView:willTurnToPageAtIndex:)])
		[delegate leavesView:self willTurnToPageAtIndex:index];
}

- (void) didTurnToPageAtIndex:(NSUInteger)index {
	if ([delegate respondsToSelector:@selector(leavesView:didTurnToPageAtIndex:)])
		[delegate leavesView:self didTurnToPageAtIndex:index];
}

- (void) didTurnPageBackward {
	interactionLocked = NO;
	[self didTurnToPageAtIndex:currentPageIndex];
}

- (void) didTurnPageForward {
	interactionLocked = NO;
	self.currentPageIndex = self.currentPageIndex + 1;	
	[self didTurnToPageAtIndex:currentPageIndex];
}

- (BOOL) hasPrevPage {
	return self.currentPageIndex > 0;
}

- (BOOL) hasNextPage {
	return self.currentPageIndex < numberOfPages - 1;
}

- (BOOL) touchedNextPage {
	return CGRectContainsPoint(nextPageRect, touchBeganPoint);
}

- (BOOL) touchedPrevPage {
	return CGRectContainsPoint(prevPageRect, touchBeganPoint);
}

- (CGFloat) dragThreshold {
	// Magic empirical number
	return 10;
}

- (CGFloat) targetWidth {
	// Magic empirical formula
	if (preferredTargetWidth > 0 && preferredTargetWidth < self.bounds.size.width / 2)
		return preferredTargetWidth;
	else
		return MAX(28, self.bounds.size.width / 5);
}

- (void) updateTargetRects {
	CGFloat targetWidth = [self targetWidth];
	nextPageRect = CGRectMake(self.bounds.size.width - targetWidth,
							  0,
							  targetWidth,
							  self.bounds.size.height);
	prevPageRect = CGRectMake(0,
							  0,
							  targetWidth,
							  self.bounds.size.height);
}

#pragma mark accessors

- (id<LeavesViewDataSource>) dataSource {
	return pageCache.dataSource;
	
}

- (void) setDataSource:(id<LeavesViewDataSource>)value {
	pageCache.dataSource = value;
}

- (void) setLeafEdge:(CGFloat)aLeafEdge {
	leafEdge = aLeafEdge;
	topPageShadow.opacity = MIN(1.0, 4*(1-leafEdge));
	bottomPageShadow.opacity = MIN(1.0, 4*leafEdge);
	topPageOverlay.opacity = MIN(1.0, 4*(1-leafEdge));
	[self setLayerFrames];
}

- (void) setCurrentPageIndex:(NSUInteger)aCurrentPageIndex {
	currentPageIndex = aCurrentPageIndex;
	
	[CATransaction begin];
	[CATransaction setValue:(id)kCFBooleanTrue
					 forKey:kCATransactionDisableActions];
	
	[self getImages];
	
	self.leafEdge = 1.0;
	
	[CATransaction commit];
}

- (void) setPreferredTargetWidth:(CGFloat)value {
	preferredTargetWidth = value;
	[self updateTargetRects];
}

#pragma mark UIResponder methods

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	if (interactionLocked)
		return;
	
	UITouch *touch = [event.allTouches anyObject];
	touchBeganPoint = [touch locationInView:self];
	
	if ([self touchedPrevPage] && [self hasPrevPage]) {		
		[CATransaction begin];
		[CATransaction setValue:(id)kCFBooleanTrue
						 forKey:kCATransactionDisableActions];
		self.currentPageIndex = self.currentPageIndex - 1;
		self.leafEdge = 0.0;
		[CATransaction commit];
		touchIsActive = YES;		
	} 
	else if ([self touchedNextPage] && [self hasNextPage])
		touchIsActive = YES;
	
	else 
		touchIsActive = NO;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	if (!touchIsActive)
		return;
	UITouch *touch = [event.allTouches anyObject];
	CGPoint touchPoint = [touch locationInView:self];
	
	[CATransaction begin];
	[CATransaction setValue:[NSNumber numberWithFloat:0.07]
					 forKey:kCATransactionAnimationDuration];
	self.leafEdge = touchPoint.x / self.bounds.size.width;
	[CATransaction commit];
}


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
	if (!touchIsActive)
		return;
	touchIsActive = NO;
	
	UITouch *touch = [event.allTouches anyObject];
	CGPoint touchPoint = [touch locationInView:self];
	BOOL dragged = distance(touchPoint, touchBeganPoint) > [self dragThreshold];
	
	[CATransaction begin];
	float duration;
	if ((dragged && self.leafEdge < 0.5) || (!dragged && [self touchedNextPage])) {
		[self willTurnToPageAtIndex:currentPageIndex+1];
		self.leafEdge = 0;
		duration = leafEdge;
		interactionLocked = YES;
		if (currentPageIndex+2 < numberOfPages && backgroundRendering)
			[pageCache precacheImageForPageIndex:currentPageIndex+2];
		[self performSelector:@selector(didTurnPageForward)
				   withObject:nil 
				   afterDelay:duration + 0.25];
	}
	else {
		[self willTurnToPageAtIndex:currentPageIndex];
		self.leafEdge = 1.0;
		duration = 1 - leafEdge;
		interactionLocked = YES;
		[self performSelector:@selector(didTurnPageBackward)
				   withObject:nil 
				   afterDelay:duration + 0.25];
	}
	[CATransaction setValue:[NSNumber numberWithFloat:duration]
					 forKey:kCATransactionAnimationDuration];
	[CATransaction commit];
}

- (void) layoutSubviews {
	[super layoutSubviews];
	
	
	if (!CGSizeEqualToSize(pageSize, self.bounds.size)) {
		pageSize = self.bounds.size;
		
		[CATransaction begin];
		[CATransaction setValue:(id)kCFBooleanTrue
						 forKey:kCATransactionDisableActions];
		[self setLayerFrames];
		[CATransaction commit];
		pageCache.pageSize = self.bounds.size;
		[self getImages];
		[self updateTargetRects];
	}
}

@end

CGFloat distance(CGPoint a, CGPoint b) {
	return sqrtf(powf(a.x-b.x, 2) + powf(a.y-b.y, 2));
}
