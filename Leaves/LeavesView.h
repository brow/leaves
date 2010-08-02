//
//  LeavesView.h
//  Leaves
//
//  Created by Tom Brow on 4/18/10.
//  Copyright 2010 Tom Brow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "LeavesCache.h"

@protocol LeavesViewDataSource;
@protocol LeavesViewDelegate;

@interface LeavesView : UIView {
	CALayer *topPage;
	CALayer *topPageOverlay;
	CAGradientLayer *topPageShadow;
	
	CALayer *topPageReverse;
	CALayer *topPageReverseImage;
	CALayer *topPageReverseOverlay;
	CAGradientLayer *topPageReverseShading;
	
	CALayer *bottomPage;
	CAGradientLayer *bottomPageShadow;
	
	CGFloat leafEdge;
	NSUInteger currentPageIndex;
	NSUInteger numberOfPages;
	id<LeavesViewDelegate> delegate;
	
	CGSize pageSize;
	LeavesCache *pageCache;
	CGFloat preferredTargetWidth;
	BOOL backgroundRendering;
	
	CGPoint touchBeganPoint;
	BOOL touchIsActive;
	CGRect nextPageRect, prevPageRect;
	BOOL interactionLocked;
}

@property (assign) id<LeavesViewDataSource> dataSource;
@property (assign) id<LeavesViewDelegate> delegate;
@property (readonly) CGFloat targetWidth;
@property (assign) CGFloat preferredTargetWidth;
@property (assign) NSUInteger currentPageIndex;
@property (assign) BOOL backgroundRendering;

- (void) reloadData;

@end


@protocol LeavesViewDataSource <NSObject>

- (NSUInteger) numberOfPagesInLeavesView:(LeavesView*)leavesView;
- (void) renderPageAtIndex:(NSUInteger)index inContext:(CGContextRef)ctx;

@end

@protocol LeavesViewDelegate <NSObject>

@optional

- (void) leavesView:(LeavesView *)leavesView willTurnToPageAtIndex:(NSUInteger)pageIndex;
- (void) leavesView:(LeavesView *)leavesView didTurnToPageAtIndex:(NSUInteger)pageIndex;

@end

