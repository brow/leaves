//
//  LeavesLayer.h
//  Leaves
//
//  Created by Tom Brow on 4/18/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>


@interface LeafLayer : CALayer {
	UIImage *image;
	BOOL reverse;
}

@property (retain) UIImage *image;
@property (assign) BOOL reverse;

@end
