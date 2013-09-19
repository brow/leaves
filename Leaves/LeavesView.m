//
//  LeavesView.m
//  Leaves
//
//  Created by Tom Brow on 4/18/10.
//  Copyright 2010 Tom Brow. All rights reserved.
//

#import "LeavesView.h"
#import "LeavesCache.h"

@interface LeavesView () 

@property (readonly) CALayer *topPage, *topPageOverlay, *topPageReverse,
*topPageReverseImage, *topPageReverseOverlay, *bottomPage;
@property (readonly) CAGradientLayer *topPageShadow, *topPageReverseShading,
*bottomPageShadow;
@property (nonatomic, assign) NSUInteger numberOfPages;
@property (nonatomic, assign) CGFloat leafEdge;
@property (nonatomic, assign) CGSize pageSize;
@property (nonatomic, assign) CGPoint touchBeganPoint;
@property (nonatomic, assign) CGRect nextPageRect, prevPageRect;
@property (nonatomic, assign) BOOL touchIsActive, interactionLocked;
@property (readonly) LeavesCache *pageCache;

@end

CGFloat distance(CGPoint a, CGPoint b);

@implementation LeavesView

- (void)initCommon {
	self.clipsToBounds = YES;
	
	_topPage = [[CALayer alloc] init];
	_topPage.masksToBounds = YES;
	_topPage.contentsGravity = kCAGravityLeft;
	_topPage.backgroundColor = [[UIColor whiteColor] CGColor];
	
	_topPageOverlay = [[CALayer alloc] init];
	_topPageOverlay.backgroundColor = [[[UIColor blackColor] colorWithAlphaComponent:0.2] CGColor];
	
	_topPageShadow = [[CAGradientLayer alloc] init];
	_topPageShadow.colors = [NSArray arrayWithObjects:
							(id)[[[UIColor blackColor] colorWithAlphaComponent:0.6] CGColor],
							(id)[[UIColor clearColor] CGColor],
							nil];
	_topPageShadow.startPoint = CGPointMake(1,0.5);
	_topPageShadow.endPoint = CGPointMake(0,0.5);
	
	_topPageReverse = [[CALayer alloc] init];
	_topPageReverse.backgroundColor = [[UIColor whiteColor] CGColor];
	_topPageReverse.masksToBounds = YES;
	
	_topPageReverseImage = [[CALayer alloc] init];
	_topPageReverseImage.masksToBounds = YES;
	_topPageReverseImage.contentsGravity = kCAGravityRight;
	
	_topPageReverseOverlay = [[CALayer alloc] init];
	_topPageReverseOverlay.backgroundColor = [[[UIColor whiteColor] colorWithAlphaComponent:0.8] CGColor];
	
	_topPageReverseShading = [[CAGradientLayer alloc] init];
	_topPageReverseShading.colors = [NSArray arrayWithObjects:
									(id)[[[UIColor blackColor] colorWithAlphaComponent:0.6] CGColor],
									(id)[[UIColor clearColor] CGColor],
									nil];
	_topPageReverseShading.startPoint = CGPointMake(1,0.5);
	_topPageReverseShading.endPoint = CGPointMake(0,0.5);
	
	_bottomPage = [[CALayer alloc] init];
	_bottomPage.backgroundColor = [[UIColor whiteColor] CGColor];
	_bottomPage.masksToBounds = YES;
	
	_bottomPageShadow = [[CAGradientLayer alloc] init];
	_bottomPageShadow.colors = [NSArray arrayWithObjects:
							   (id)[[[UIColor blackColor] colorWithAlphaComponent:0.6] CGColor],
							   (id)[[UIColor clearColor] CGColor],
							   nil];
	_bottomPageShadow.startPoint = CGPointMake(0,0.5);
	_bottomPageShadow.endPoint = CGPointMake(1,0.5);
	
	[_topPage addSublayer:_topPageShadow];
	[_topPage addSublayer:_topPageOverlay];
	[_topPageReverse addSublayer:_topPageReverseImage];
	[_topPageReverse addSublayer:_topPageReverseOverlay];
	[_topPageReverse addSublayer:_topPageReverseShading];
	[_bottomPage addSublayer:_bottomPageShadow];
	[self.layer addSublayer:_bottomPage];
	[self.layer addSublayer:_topPage];
	[self.layer addSublayer:_topPageReverse];
	
	_leafEdge = 1.0;
    _backgroundRendering = NO;
	_pageCache = [[LeavesCache alloc] initWithPageSize:self.bounds.size];
}

- (id)initWithFrame:(CGRect)frame {
    if ((self = [super initWithFrame:frame])) {
		[self initCommon];
    }
    return self;
}

- (id)initWithCoder:(NSCoder *)aDecoder {
    if (self = [super initWithCoder:aDecoder]) {
        [self initCommon];
    }
    return self;
}

- (void)dealloc {
	[_topPage release];
	[_topPageShadow release];
	[_topPageOverlay release];
	[_topPageReverse release];
	[_topPageReverseImage release];
	[_topPageReverseOverlay release];
	[_topPageReverseShading release];
	[_bottomPage release];
	[_bottomPageShadow release];
	[_pageCache release];
	
    [super dealloc];
}

- (void)reloadData {
	[self.pageCache flush];
	self.numberOfPages = [self.pageCache.dataSource numberOfPagesInLeavesView:self];
	self.currentPageIndex = 0;
}

- (void)getImages {
	if (self.currentPageIndex < self.numberOfPages) {
		if (self.currentPageIndex > 0 && self.backgroundRendering)
			[self.pageCache precacheImageForPageIndex:self.currentPageIndex-1];
		self.topPage.contents = (id)[self.pageCache cachedImageForPageIndex:self.currentPageIndex];
		self.topPageReverseImage.contents = (id)[self.pageCache cachedImageForPageIndex:self.currentPageIndex];
		if (self.currentPageIndex < self.numberOfPages - 1)
			self.bottomPage.contents = (id)[self.pageCache cachedImageForPageIndex:self.currentPageIndex + 1];
		[self.pageCache minimizeToPageIndex:self.currentPageIndex];
	} else {
		self.topPage.contents = nil;
		self.topPageReverseImage.contents = nil;
		self.bottomPage.contents = nil;
	}
}

- (void)setLayerFrames {
	self.topPage.frame = CGRectMake(self.layer.bounds.origin.x,
							   self.layer.bounds.origin.y, 
							   self.leafEdge * self.bounds.size.width,
							   self.layer.bounds.size.height);
	self.topPageReverse.frame = CGRectMake(self.layer.bounds.origin.x + (2*self.leafEdge-1) * self.bounds.size.width,
									  self.layer.bounds.origin.y, 
									  (1-self.leafEdge) * self.bounds.size.width,
									  self.layer.bounds.size.height);
	self.bottomPage.frame = self.layer.bounds;
	self.topPageShadow.frame = CGRectMake(self.topPageReverse.frame.origin.x - 40,
									 0, 
									 40, 
									 self.bottomPage.bounds.size.height);
	self.topPageReverseImage.frame = self.topPageReverse.bounds;
	self.topPageReverseImage.transform = CATransform3DMakeScale(-1, 1, 1);
	self.topPageReverseOverlay.frame = self.topPageReverse.bounds;
	self.topPageReverseShading.frame = CGRectMake(self.topPageReverse.bounds.size.width - 50,
											 0, 
											 50 + 1, 
											 self.topPageReverse.bounds.size.height);
	self.bottomPageShadow.frame = CGRectMake(self.leafEdge * self.bounds.size.width,
										0, 
										40, 
										self.bottomPage.bounds.size.height);
	self.topPageOverlay.frame = self.topPage.bounds;
}

- (void)willTurnToPageAtIndex:(NSUInteger)index {
	if ([self.delegate respondsToSelector:@selector(leavesView:willTurnToPageAtIndex:)])
		[self.delegate leavesView:self willTurnToPageAtIndex:index];
}

- (void)didTurnToPageAtIndex:(NSUInteger)index {
	if ([self.delegate respondsToSelector:@selector(leavesView:didTurnToPageAtIndex:)])
		[self.delegate leavesView:self didTurnToPageAtIndex:index];
}

- (void)didTurnPageBackward {
	self.interactionLocked = NO;
	[self didTurnToPageAtIndex:self.currentPageIndex];
}

- (void)didTurnPageForward {
	self.interactionLocked = NO;
	self.currentPageIndex = self.currentPageIndex + 1;	
	[self didTurnToPageAtIndex:self.currentPageIndex];
}

- (BOOL)hasPrevPage {
	return self.currentPageIndex > 0;
}

- (BOOL)hasNextPage {
	return self.currentPageIndex < self.numberOfPages - 1;
}

- (BOOL)touchedNextPage {
	return CGRectContainsPoint(self.nextPageRect, self.touchBeganPoint);
}

- (BOOL)touchedPrevPage {
	return CGRectContainsPoint(self.prevPageRect, self.touchBeganPoint);
}

- (CGFloat)dragThreshold {
	// Magic empirical number
	return 10;
}

- (CGFloat)targetWidth {
	// Magic empirical formula
	if (self.preferredTargetWidth > 0 && self.preferredTargetWidth < self.bounds.size.width / 2)
		return self.preferredTargetWidth;
	else
		return MAX(28, self.bounds.size.width / 5);
}

- (void)updateTargetRects {
	CGFloat targetWidth = [self targetWidth];
	self.nextPageRect = CGRectMake(self.bounds.size.width - targetWidth,
							  0,
							  targetWidth,
							  self.bounds.size.height);
	self.prevPageRect = CGRectMake(0,
							  0,
							  targetWidth,
							  self.bounds.size.height);
}

#pragma mark accessors

- (id<LeavesViewDataSource>)dataSource {
	return self.pageCache.dataSource;
	
}

- (void)setDataSource:(id<LeavesViewDataSource>)value {
	self.pageCache.dataSource = value;
}

- (void)setLeafEdge:(CGFloat)aLeafEdge {
	_leafEdge = aLeafEdge;
	self.topPageShadow.opacity = MIN(1.0, 4*(1-self.leafEdge));
	self.bottomPageShadow.opacity = MIN(1.0, 4*self.leafEdge);
	self.topPageOverlay.opacity = MIN(1.0, 4*(1-self.leafEdge));
	[self setLayerFrames];
}

- (void)setCurrentPageIndex:(NSUInteger)aCurrentPageIndex {
	_currentPageIndex = aCurrentPageIndex;
	
	[CATransaction begin];
	[CATransaction setValue:(id)kCFBooleanTrue
					 forKey:kCATransactionDisableActions];
	
	[self getImages];
	
	self.leafEdge = 1.0;
	
	[CATransaction commit];
}

- (void)setPreferredTargetWidth:(CGFloat)value {
	_preferredTargetWidth = value;
	[self updateTargetRects];
}

#pragma mark UIResponder

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
	if (self.interactionLocked)
		return;
	
	UITouch *touch = [event.allTouches anyObject];
	self.touchBeganPoint = [touch locationInView:self];
	
	if ([self touchedPrevPage] && [self hasPrevPage]) {		
		[CATransaction begin];
		[CATransaction setValue:(id)kCFBooleanTrue
						 forKey:kCATransactionDisableActions];
		self.currentPageIndex = self.currentPageIndex - 1;
		self.leafEdge = 0.0;
		[CATransaction commit];
		self.touchIsActive = YES;		
	} 
	else if ([self touchedNextPage] && [self hasNextPage])
		self.touchIsActive = YES;
	
	else 
		self.touchIsActive = NO;
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
	if (!self.touchIsActive)
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
	if (!self.touchIsActive)
		return;
	self.touchIsActive = NO;
	
	UITouch *touch = [event.allTouches anyObject];
	CGPoint touchPoint = [touch locationInView:self];
	BOOL dragged = distance(touchPoint, self.touchBeganPoint) > [self dragThreshold];
	
	[CATransaction begin];
	float duration;
	if ((dragged && self.leafEdge < 0.5) || (!dragged && [self touchedNextPage])) {
		[self willTurnToPageAtIndex:self.currentPageIndex+1];
		self.leafEdge = 0;
		duration = self.leafEdge;
		self.interactionLocked = YES;
		if (self.currentPageIndex+2 < self.numberOfPages && self.backgroundRendering)
			[self.pageCache precacheImageForPageIndex:self.currentPageIndex+2];
		[self performSelector:@selector(didTurnPageForward)
				   withObject:nil 
				   afterDelay:duration + 0.25];
	}
	else {
		[self willTurnToPageAtIndex:self.currentPageIndex];
		self.leafEdge = 1.0;
		duration = 1 - self.leafEdge;
		self.interactionLocked = YES;
		[self performSelector:@selector(didTurnPageBackward)
				   withObject:nil 
				   afterDelay:duration + 0.25];
	}
	[CATransaction setValue:[NSNumber numberWithFloat:duration]
					 forKey:kCATransactionAnimationDuration];
	[CATransaction commit];
}

- (void)layoutSubviews {
	[super layoutSubviews];
	
	if (!CGSizeEqualToSize(self.pageSize, self.bounds.size)) {
		self.pageSize = self.bounds.size;
		
		[CATransaction begin];
		[CATransaction setValue:(id)kCFBooleanTrue
						 forKey:kCATransactionDisableActions];
		[self setLayerFrames];
		[CATransaction commit];
        
		self.pageCache.pageSize = self.bounds.size;
		[self getImages];
		[self updateTargetRects];
	}
}

@end

CGFloat distance(CGPoint a, CGPoint b) {
	return sqrtf(powf(a.x-b.x, 2) + powf(a.y-b.y, 2));
}
