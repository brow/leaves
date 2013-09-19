//
//  LeavesView.h
//  Leaves
//
//  Created by Tom Brow on 4/18/10.
//  Copyright 2010 Tom Brow. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol LeavesViewDataSource;
@protocol LeavesViewDelegate;

// This view displays a sequence of pages, one at a time. The user navigates
// forward and backward through the sequence using a page-turn gesture or by
// tapping invisible targets on the left and right margins of the current page.
//
// Pages are non-interactive raster images supplied by a data source that
// conforms to the LeavesViewDataSource protocol.
//
// An optional delegate, conforming to the LeavesViewDelegate protocol, is
// notified when the page is turned.
@interface LeavesView : UIView

@property (assign) id<LeavesViewDataSource> dataSource;
@property (assign) id<LeavesViewDelegate> delegate;

// The width of the invisible targets in the left and right margins, which may
// be tapped to turn to the previous and next page respectively.
//
// This value is chosen automatically based on the view's frame unless the
// preferredTargetWidth property is set to a nonzero value.
@property (readonly) CGFloat targetWidth;

// If this is set to a nonzero value, it will override the value chosen
// automatically for targetWidth.
//
// The default value of this property is 0.
@property (nonatomic, assign) CGFloat preferredTargetWidth;

// The zero-based index of the page currently displayed. The value of this
// property changes when the user turns the page. You may also set this value
// programmatically to jump to a certain page.
@property (nonatomic, assign) NSUInteger currentPageIndex;

// If this property is set to YES, pages likely to be displayed soon will be
// pre-rendered in a background thread to avoid blocking the main thread when
// the page is turned. Only set this to YES if your implementation of the data
// source methods is thread-safe.
//
// The defaut value of this property is NO.
@property (assign) BOOL backgroundRendering;

// Reload content from the data source. This also resets the currentPageIndex
// property to 0 and jumps to the first page.
- (void)reloadData;

@end

@protocol LeavesViewDataSource <NSObject>

// Returns the total number of pages to be displayed.
- (NSUInteger)numberOfPagesInLeavesView:(LeavesView*)leavesView;

// Draws the content of the given page in the given Core Graphics context. Your
// implementation should draw within the bounding box returned by
// CGContextGetClipBoundingBox(context).
- (void)renderPageAtIndex:(NSUInteger)index inContext:(CGContextRef)context;

@end

@protocol LeavesViewDelegate <NSObject>
@optional

// Called when the user triggers a page turn by touching up in the left or right
// margin, or by completing a page-turn gesture.
- (void)leavesView:(LeavesView *)leavesView willTurnToPageAtIndex:(NSUInteger)pageIndex;

// Called when the animation accompanying a page turn completes. 
- (void)leavesView:(LeavesView *)leavesView didTurnToPageAtIndex:(NSUInteger)pageIndex;

@end

