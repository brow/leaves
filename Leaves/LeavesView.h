//
//  LeavesView.h
//  Leaves
//
//  Created by Tom Brow on 4/18/10.
//  Copyright 2010 Tom Brow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@protocol LeavesViewDataSource;
@protocol LeavesViewDelegate;

@interface LeavesView : UIView {
	CALayer *topPage;
	CALayer *topPageImage;
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
	id<LeavesViewDataSource> dataSource;
	id<LeavesViewDelegate> delegate;
	
	CGPoint touchBeganPoint;
	BOOL touchIsActive;
	CGRect nextPageRect, prevPageRect;
}

@property (assign) id<LeavesViewDataSource> dataSource;
@property (assign) id<LeavesViewDelegate> delegate;

- (void) reloadData;

@end


@protocol LeavesViewDataSource

- (NSUInteger) numberOfPagesInLeavesView:(LeavesView*)leavesView;
- (void) renderPageAtIndex:(NSUInteger)index inContext:(CGContextRef)ctx;

@end

@protocol LeavesViewDelegate

@optional

- (void) leavesView:(LeavesView *)leavesView didTurnToPageAtIndex:(NSUInteger)pageIndex;

@end

