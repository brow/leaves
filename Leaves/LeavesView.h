//
//  LeavesView.h
//  Leaves
//
//  Created by Tom Brow on 4/18/10.
//  Copyright 2010 Tom Brow. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>


@class LeavesTiledLayer;
@class LeavesTiledLayerDelegate;
@class LeavesCache;
@protocol LeavesViewDataSource;
@protocol LeavesViewDelegate;

typedef enum LeavesViewMode {
    LeavesViewModeSinglePage,
    LeavesViewModeFacingPages,
} LeavesViewMode;


@interface LeavesView : UIView {
    
    LeavesTiledLayer *topPageZoomLayer;      
    LeavesTiledLayerDelegate *topPageZoomDelegate;
    
    LeavesTiledLayer *topLeftPageZoomLayer;
    LeavesTiledLayerDelegate *topLeftZoomDelegate;
    
    CALayer *leftPage;
	CALayer *leftPageOverlay;
    
	CALayer *topPage;
	CALayer *topPageOverlay;
    CALayer *topLeftPageOverlay;
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
    
    BOOL zoomActive;
    NSInteger               numberOfVisiblePages;
    LeavesViewMode          mode;
}

@property (assign) id<LeavesViewDataSource> dataSource;
@property (assign) id<LeavesViewDelegate> delegate;

// the automatically determined width of the interactive areas on either side of the page
@property (readonly) CGFloat targetWidth;

// set this to a nonzero value to get a targetWidth other than the default
@property (assign) CGFloat preferredTargetWidth;

// the zero-based index of the page currently being displayed.
@property (assign) NSUInteger currentPageIndex;

// If backgroundRendering is YES, some pages not currently being displayed will be pre-rendered in background threads.
// The default value is NO.  Only set this to YES if your implementation of the data source methods is thread-safe.
@property (assign) BOOL backgroundRendering;

// set this value to YES to activate zooming
@property (assign) BOOL zoomActive;

// Retuns the number of visible pages (one page for portrait two for landscape view)
@property (readonly) NSInteger     numberOfVisiblePages;

@property (nonatomic, assign) LeavesViewMode mode;

// refreshes the contents of all pages via the data source methods, much like -[UITableView reloadData]
- (void) reloadData;

@end


@protocol LeavesViewDataSource <NSObject>

- (NSUInteger) numberOfPagesInLeavesView:(LeavesView*)leavesView;
- (void) renderPageAtIndex:(NSUInteger)index inContext:(CGContextRef)ctx;
- (void)renderTiledPageAtIndex:(NSUInteger)index forLayer:(LeavesTiledLayer*)layer inContext:(CGContextRef)ctx;
@end


@protocol LeavesViewDelegate <NSObject>

@optional

// called when the user touches up on the left or right side of the page, or finishes dragging the page
- (void) leavesView:(LeavesView *)leavesView willTurnToPageAtIndex:(NSUInteger)pageIndex;

// called when the page-turn animation (following a touch-up or drag) completes 
- (void) leavesView:(LeavesView *)leavesView didTurnToPageAtIndex:(NSUInteger)pageIndex;

@end

