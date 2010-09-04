//
//  OverlayView.m
//  oKnow
//
//  Created by Robert Simpson on 8/1/10.
//  Copyright 2010 Accilent Corp. All rights reserved.
//

#import "OverlayView.h"
#import "LeavesViewController.h"

@implementation OverlayView

#pragma mark -
#pragma mark Accessor methods

@synthesize leavesView;


#pragma mark -
#pragma mark Class methods

+ (void)addOverlayView:(OverlayView *)overlayView onView:(UIView *)view
{

   [view addSubview:overlayView];

// Find the LeavesView and save it for forwarding touch events

   NSEnumerator * enumer = [view.subviews objectEnumerator];
   UIView * subview;
   while ((subview = [enumer nextObject])) {
      if ([subview isKindOfClass:[LeavesView class]]) {
         overlayView.leavesView = (LeavesView *)subview;
         break;
      }
   }

}


#pragma mark -
#pragma mark Memory management

/**
 * <p>This is the designated initializer for both this class and UIView.
 * </p>
**/

- (id)initWithFrame:(CGRect)rect
{
   if (self = [super initWithFrame:rect]) {
      self.userInteractionEnabled = YES;
      self.multipleTouchEnabled = YES;
   }
   return self;
}


#pragma mark -
#pragma mark Forward touches outside active overlay area to LeavesView

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
   if (touchesBeganInLeavesView = touches.count == 1 && ! CGRectContainsPoint(CGRectInset(self.frame, leavesView.targetWidth, 0.0f), [event.allTouches.anyObject locationInView:self]))
      [leavesView touchesBegan:touches withEvent:event];
   else
      [self.nextResponder touchesBegan:touches withEvent:event];
}

- (void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
   if (touchesBeganInLeavesView)
      [leavesView touchesMoved:touches withEvent:event];
   else
      [self.nextResponder touchesMoved:touches withEvent:event];
}

- (void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
   if (touchesBeganInLeavesView)
      [super touchesCancelled:touches withEvent:event];
   else
      [self.nextResponder touchesCancelled:touches withEvent:event];
}

- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
   if (touchesBeganInLeavesView)
      [leavesView touchesEnded:touches withEvent:event];
   else
      [self.nextResponder touchesEnded:touches withEvent:event];
}

@end
