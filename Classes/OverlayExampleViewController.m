//
//  OverlayExampleViewController.m
//  Leaves
//
//  Created by Robert Simpson on 8/26/10.
//  Copyright 2010 Tom Brow. All rights reserved.
//

#import "OverlayExampleViewController.h"
#import "OverlayView.h"

@implementation OverlayExampleViewController

@synthesize overlayView, onOffSwitch, label;

- (void) displayPageNumber:(NSUInteger)pageNumber
{
	self.navigationItem.title = [NSString stringWithFormat:
                                @"Page %u of %u", 
                                pageNumber, 
                                [self numberOfPagesInLeavesView:leavesView]];
}

- (void)viewDidLoad
{
   [self displayPageNumber:1];
   [OverlayView addOverlayView:overlayView onView:self.view];
   [super viewDidLoad];
}

- (IBAction)switchValueChanged:(id)sender
{
   if ([onOffSwitch isOn]) {
      [self displayPageNumber:leavesView.currentPageIndex + 1];
   }
   else {
      self.navigationItem.title = nil;
   }
}

#pragma mark  LeavesViewDelegate methods

- (void) leavesView:(LeavesView *)leavesView 
   willTurnToPageAtIndex:(NSUInteger)pageIndex
{
   NSString * str = [[NSString alloc] initWithFormat:@"willTurnToPageAtIndex:%d", pageIndex];
   [label setText:str];
   [str release];
   if ([onOffSwitch isOn]) {
      [self displayPageNumber:pageIndex + 1];
   }
}

#pragma mark LeavesViewDataSource methods

- (NSUInteger) numberOfPagesInLeavesView:(LeavesView*)leavesView
{
	return 10;
}

- (void) renderPageAtIndex:(NSUInteger)index
   inContext:(CGContextRef)ctx
{
	CGRect bounds = CGContextGetClipBoundingBox(ctx);
	CGContextSetFillColorWithColor(ctx, [[UIColor colorWithHue:index/10.0 
                                                   saturation:0.8
                                                   brightness:0.8 
                                                        alpha:1.0] CGColor]);
	CGContextFillRect(ctx, CGRectInset(bounds, 100, 100));
}

@end
