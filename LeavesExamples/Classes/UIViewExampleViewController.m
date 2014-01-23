//
//  UIViewExampleViewController.m
//  LeavesExamples
//
//  Created by Aemotion on 23-01-14.
//  Copyright (c) 2014 Tom Brow. All rights reserved.
//

#import "UIViewExampleViewController.h"

@implementation UIViewExampleViewController

#pragma mark LeavesViewDataSource

- (NSUInteger)numberOfPagesInLeavesView:(LeavesView*)leavesView {
	return 10;
}

- (void) renderPageAtIndex:(NSUInteger)index inContext:(CGContextRef)ctx {
    
    CGRect bounds = CGContextGetClipBoundingBox(ctx);
    
    UIView* renderView = [[[UIView alloc] initWithFrame:bounds] autorelease];
    renderView.backgroundColor = [UIColor colorWithHue:index/10.0
                                        saturation:0.8
                                        brightness:0.8
                                             alpha:1.0];
    
    
    UILabel* label = [[[UILabel alloc] initWithFrame:bounds] autorelease];
    label.text = [NSString stringWithFormat:@"Page number %d", index];
    label.textAlignment = UITextAlignmentCenter;
    [renderView addSubview:label];
    
    // View will render upside down if we omit this:
    CGAffineTransform verticalFlip = CGAffineTransformMake(1, 0, 0, -1, 0, bounds.size.height);
    CGContextConcatCTM(ctx, verticalFlip);
    
    
    // We call renderInContext on the layer to draw the view onto the context
    [renderView.layer renderInContext:ctx];
}


@end
