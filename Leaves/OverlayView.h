//
//  OverlayView.h
//  oKnow
//
//  Created by Robert Simpson on 8/1/10.
//  Copyright 2010 Accilent Corp. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LeavesView;

/**
 * <p>Usage:
 * </p>
 *
 * <p>in ...ViewController.h:
 * </p>
 * <xmp>
 *
 *    IBOutlet OverlayView * overlayView;
 *
 * </xmp>
 * <p>If using a NIB, connect the view outlet of the File's Owner to the UIView and connect
 *    the overlayView outlet to a view with Class OverlayView in the Identity Inspector.
 * </p>
 *
 * <p>in ...ViewController.m viewDidLoad:
 * </p>
 * <xmp>
 *
 *    [OverlayView addOverlayView:overlayView onView:self.view];
 *
 * </xmp>
 * </p>
**/

@interface OverlayView : UIView {

/**
 * <p>The LeavesViewController gives us access to the LeavesView,
 *    since the LeavesView itself is not available to Interface Builder.
 * </p>
**/

   LeavesView * leavesView;

   BOOL touchesBeganInLeavesView;

}

@property (nonatomic, retain) LeavesView * leavesView;

+ (void)addOverlayView:(OverlayView *)overlayView onView:(UIView *)view;

@end
