//
//  LeavesView.h
//  Leaves
//
//  Created by Tom Brow on 4/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface LeavesView : UIView {
	CALayer *topPageLayer;
	CALayer *topPageImageLayer;
	CAGradientLayer *topPageShadowLayer;
	
	CALayer *reverseLayer;
	CALayer *reverseImageLayer;
	CALayer *reverseOverlayLayer;
	
	CALayer *bottomPageLayer;
	CAGradientLayer *bottomPageShadowLayer;
	
	CGFloat leafEdge;
}

@end
