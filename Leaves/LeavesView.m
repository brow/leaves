//
//  LeavesView.m
//  Leaves
//
//  Created by Tom Brow on 4/18/10.
//  Copyright 2010 Tom Brow. All rights reserved.
//

#import "LeavesView.h"
#import "LeavesTiledLayer.h"
#import "LeavesTiledLayerDelegate.h"
#import "LeavesCache.h"

@interface LeavesView () 

@property (assign) CGFloat leafEdge;

@end

CGFloat distance(CGPoint a, CGPoint b);

@implementation LeavesView

@synthesize delegate;
@synthesize leafEdge, currentPageIndex, backgroundRendering, preferredTargetWidth, numberOfVisiblePages;


- (void)setZoomActive:(BOOL)aZoomActive {
    zoomActive = aZoomActive;
    
	[CATransaction begin];
	[CATransaction setValue:(id)kCFBooleanTrue
					 forKey:kCATransactionDisableActions];    
    [CATransaction setValue:0 
                     forKey:kCATransactionAnimationDuration];
    
    if(zoomActive) {
        
        if(self.mode == LeavesViewModeSinglePage) {
               
            topPageZoomDelegate.pageIndex = self.currentPageIndex;
            topPageZoomLayer.hidden = NO;
            topLeftPageZoomLayer.hidden = YES;
        } else {
            
            topPageZoomLayer.hidden = NO;            
            topPageZoomDelegate.pageIndex = self.currentPageIndex;
            
            if(self.currentPageIndex > 0) {
                topLeftZoomDelegate.pageIndex = self.currentPageIndex - 1;
                topLeftPageZoomLayer.hidden = NO;
            }
        }
        
    } else {
        topPageZoomDelegate.pageIndex = -1;
        topLeftZoomDelegate.pageIndex = -1;
        topPageZoomLayer.contents = nil;
        topLeftPageZoomLayer.contents = nil;
        topPageZoomLayer.hidden = YES;
        topLeftPageZoomLayer.hidden = YES;
    }
    
    [topPageZoomLayer setNeedsDisplay];   
    [topLeftPageZoomLayer setNeedsDisplay];
    [CATransaction commit];
}

- (BOOL)zoomActive {
    return zoomActive;
}

-(void) setUpLayersForViewingMode
{
    
    if (self.mode == LeavesViewModeSinglePage) {        
        topPageReverseImage.contentsGravity = kCAGravityRight;
        topPageReverseOverlay.backgroundColor = [[[UIColor whiteColor] colorWithAlphaComponent:0.8] CGColor];
        topPageReverseImage.transform = CATransform3DMakeScale(-1, 1, 1);
    } else {
        topPageReverseImage.contentsGravity = kCAGravityLeft;
        topPageReverseOverlay.backgroundColor = [[[UIColor whiteColor] colorWithAlphaComponent:0.0] CGColor];
        topPageReverseImage.transform = CATransform3DMakeScale(1, 1, 1);
    }     
    
}

- (void)setMode:(LeavesViewMode)aMode
{
    mode = aMode;
    
    if (self.mode == LeavesViewModeSinglePage) {
        numberOfVisiblePages = 1;
        if (numberOfPages > 0 && 
            currentPageIndex > numberOfPages - 1) {
            currentPageIndex = numberOfPages - 1;
        }
        
    } else {
        numberOfVisiblePages = 2;
        if (self.currentPageIndex % 2 != 0) {
            self.currentPageIndex++;
        }
    }    
    
    [self setUpLayersForViewingMode];
    
    [topPageZoomLayer setNeedsDisplay];
    [topLeftPageZoomLayer setNeedsDisplay];
    [self setNeedsLayout];    
}

- (LeavesViewMode)mode
{
    return mode;
}


- (void) setUpLayers {
	self.clipsToBounds = YES;
    
	topPage = [[CALayer alloc] init];
	topPage.masksToBounds = YES;
	topPage.contentsGravity = kCAGravityLeft;
	topPage.backgroundColor = [[UIColor whiteColor] CGColor];
    
    topPageZoomDelegate = [[LeavesTiledLayerDelegate alloc] init];
    topPageZoomLayer = [[LeavesTiledLayer alloc] init];
    topPageZoomLayer.delegate = topPageZoomDelegate;
    
    
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
    
	topPageReverseOverlay = [[CALayer alloc] init];
    
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
        
	[topPage addSublayer:topPageOverlay];
	[topPageReverse addSublayer:topPageReverseImage];
	[topPageReverse addSublayer:topPageReverseOverlay];
	[topPageReverse addSublayer:topPageReverseShading];
	[bottomPage addSublayer:bottomPageShadow];
    
    // Setup for the left page in two-page mode
    leftPage = [[CALayer alloc] init];
	leftPage.masksToBounds = YES;
	leftPage.contentsGravity = kCAGravityLeft;
	leftPage.backgroundColor = [[UIColor whiteColor] CGColor];
    
	leftPageOverlay = [[CALayer alloc] init];
	leftPageOverlay.backgroundColor = [[[UIColor blackColor] colorWithAlphaComponent:0.2] CGColor];
    
    topLeftZoomDelegate = [[LeavesTiledLayerDelegate alloc] init];
    topLeftPageZoomLayer = [[LeavesTiledLayer alloc] init];
    topLeftPageZoomLayer.delegate = topLeftZoomDelegate;
    
	[leftPage addSublayer:leftPageOverlay];
    
	[self.layer addSublayer:leftPage];
    [self.layer addSublayer:topLeftPageZoomLayer];
	[self.layer addSublayer:bottomPage];
	[self.layer addSublayer:topPage];
    [self.layer addSublayer:topPageZoomLayer];
	[self.layer addSublayer:topPageReverse];
    [self.layer addSublayer:topPageShadow];
    
    topPageZoomLayer.hidden = YES;
    topLeftPageZoomLayer.hidden = YES;
    
    [self setUpLayersForViewingMode];
    
	self.leafEdge = 1.0;
}

- (void) initialize {
	backgroundRendering = NO;
	pageCache = [[LeavesCache alloc] initWithPageSize:self.bounds.size];
    numberOfVisiblePages = 1;
    mode = LeavesViewModeSinglePage;
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
    [topPageZoomLayer release];
    [topPageZoomDelegate release];
	[topPageShadow release];
	[topPageOverlay release];
	[topPageReverse release];
	[topPageReverseImage release];
	[topPageReverseOverlay release];
	[topPageReverseShading release];
	[bottomPage release];
	[bottomPageShadow release];
    [leftPage release];
	[leftPageOverlay release];
	
	[pageCache release];
	
    [super dealloc];
}

- (void) reloadData {
	[pageCache flush];
	numberOfPages = [pageCache.dataSource numberOfPagesInLeavesView:self];
	self.currentPageIndex = 0;
}

- (void) getImages {
    
    if (self.mode == LeavesViewModeSinglePage) 
    {
        if (currentPageIndex < numberOfPages) {
            if (currentPageIndex > 0 && backgroundRendering) {
                [pageCache precacheImageForPageIndex:currentPageIndex-1];
            }
            topPage.contents = (id)[pageCache cachedImageForPageIndex:currentPageIndex];
            leftPage.contents = (id)[pageCache cachedImageForPageIndex:currentPageIndex];
            if (currentPageIndex < numberOfPages - 1) {
                topPageReverseImage.contents = (id)[pageCache cachedImageForPageIndex:currentPageIndex];
                bottomPage.contents = (id)[pageCache cachedImageForPageIndex:currentPageIndex + 1];
            }
            [pageCache minimizeToPageIndex:currentPageIndex viewMode:self.mode];
        } else {
            topPage.contents = nil;
            topPageReverseImage.contents = nil;
            bottomPage.contents = nil;
            
            leftPage.contents = nil;
        }
    }
    else
    {
        if (currentPageIndex <= numberOfPages) {
            if (currentPageIndex > 1 && backgroundRendering) {
                [pageCache precacheImageForPageIndex:currentPageIndex-2];
            }
            if (currentPageIndex > 2 && backgroundRendering) {
                [pageCache precacheImageForPageIndex:currentPageIndex-2];
            }
            
            topPage.contents = (id)[pageCache cachedImageForPageIndex:currentPageIndex];
            if (currentPageIndex > 0) {
                leftPage.contents = (id)[pageCache cachedImageForPageIndex:currentPageIndex-1];
            } else {
                leftPage.contents = nil;
            }
            
            if (currentPageIndex < numberOfPages - 1) {
                topPageReverseImage.contents = (id)[pageCache cachedImageForPageIndex:currentPageIndex + 1];
                bottomPage.contents = (id)[pageCache cachedImageForPageIndex:currentPageIndex + 2];
            }
            [pageCache minimizeToPageIndex:currentPageIndex viewMode:self.mode];
        } else {
            topPage.contents = nil;
            topPageReverseImage.contents = nil;
            bottomPage.contents = nil;
            
            leftPage.contents = nil;
        }
    }
}

- (void) setLayerFrames {
    CGRect rightPageBoundsRect = self.layer.bounds;
    CGRect leftHalf, rightHalf;
    CGRectDivide(rightPageBoundsRect, &leftHalf, &rightHalf, CGRectGetWidth(rightPageBoundsRect) / 2.0f, CGRectMinXEdge);
    if (self.mode == LeavesViewModeFacingPages) {
        rightPageBoundsRect = rightHalf;
    }
    
	topPage.frame = CGRectMake(rightPageBoundsRect.origin.x, 
							   rightPageBoundsRect.origin.y, 
							   leafEdge * rightPageBoundsRect.size.width, 
							   rightPageBoundsRect.size.height);
    
    topPageZoomLayer.frame = topPage.frame;
    
	topPageReverse.frame = CGRectMake(rightPageBoundsRect.origin.x + (2*leafEdge-1) * rightPageBoundsRect.size.width, 
									  rightPageBoundsRect.origin.y, 
									  (1-leafEdge) * rightPageBoundsRect.size.width, 
									  rightPageBoundsRect.size.height);
	bottomPage.frame = rightPageBoundsRect;
	topPageShadow.frame = CGRectMake(topPageReverse.frame.origin.x - 40, 
									 0, 
									 40, 
									 bottomPage.bounds.size.height);
	topPageReverseImage.frame = topPageReverse.bounds;
	topPageReverseOverlay.frame = topPageReverse.bounds;
	topPageReverseShading.frame = CGRectMake(topPageReverse.bounds.size.width - 50, 
											 0, 
											 50 + 1, 
											 topPageReverse.bounds.size.height);
	bottomPageShadow.frame = CGRectMake(leafEdge * rightPageBoundsRect.size.width, 
										0, 
										40, 
										bottomPage.bounds.size.height);
	topPageOverlay.frame = topPage.bounds;
    
    
    
    if (self.mode == LeavesViewModeSinglePage) {
        leftPage.hidden = YES;
        leftPageOverlay.hidden = leftPage.hidden;
    } else {
        leftPage.hidden = NO;
        leftPageOverlay.hidden = leftPage.hidden;
        leftPage.frame = CGRectMake(leftHalf.origin.x, 
                                    leftHalf.origin.y, 
                                    leftHalf.size.width, 
                                    leftHalf.size.height);
        leftPageOverlay.frame = leftPage.bounds;
        topLeftPageZoomLayer.frame = leftPage.frame;
        
    }
  
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
    
	if (self.mode == LeavesViewModeSinglePage) {
        return currentPageIndex < numberOfPages - 1;
    } else {
        return  ((currentPageIndex % 2 == 0) && (currentPageIndex < numberOfPages - 1)) ||
        ((currentPageIndex % 2 != 0) && (currentPageIndex < numberOfPages - 2));
    }    
}

- (BOOL) touchedNextPage {
    if(self.zoomActive) return NO;
	return CGRectContainsPoint(nextPageRect, touchBeganPoint);
}

- (BOOL) touchedPrevPage {
    if(self.zoomActive) return NO;
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
    topPageZoomDelegate.dataSource = value;
    topLeftZoomDelegate.dataSource = value;
}

- (void) setLeafEdge:(CGFloat)aLeafEdge {
	leafEdge = aLeafEdge;
    
    CGFloat pageOpacity = MIN(1.0, 4*(1-leafEdge));
    
    topPageShadow.opacity        = pageOpacity;
	bottomPageShadow.opacity     = pageOpacity;
	topPageOverlay.opacity       = pageOpacity;
	leftPageOverlay.opacity   = pageOpacity;
    
    [self setLayerFrames];
}

- (void) setCurrentPageIndex:(NSUInteger)aCurrentPageIndex {
	currentPageIndex = aCurrentPageIndex;
	
 	if (self.mode == LeavesViewModeFacingPages && currentPageIndex % 2 != 0) {
        currentPageIndex = currentPageIndex + 1;
    }   
    
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
		self.currentPageIndex = self.currentPageIndex - numberOfVisiblePages;
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
		[self willTurnToPageAtIndex:currentPageIndex + numberOfVisiblePages];
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
	
 	CGSize desiredPageSize = self.bounds.size;
    
    if (self.mode == LeavesViewModeFacingPages) {
        desiredPageSize = CGSizeMake(self.bounds.size.width/2.0f, self.bounds.size.height);
    }   
    
	
	if (!CGSizeEqualToSize(pageSize, desiredPageSize)) {
		pageSize = self.bounds.size;
		
		[CATransaction begin];
		[CATransaction setValue:(id)kCFBooleanTrue
						 forKey:kCATransactionDisableActions];
		
        [self setLayerFrames];
        
		[CATransaction commit];
		
        pageCache.pageSize = desiredPageSize;
		
        [self getImages];
		
        [self updateTargetRects];
	}
}


@end

CGFloat distance(CGPoint a, CGPoint b) {
	return sqrtf(powf(a.x-b.x, 2) + powf(a.y-b.y, 2));
}
