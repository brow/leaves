//
//  Utilities.m
//  Leaves
//
//  Created by Tom Brow on 4/19/10.
//  Copyright 2010 Tom Brow. All rights reserved.
//

CGAffineTransform aspectFit(CGRect innerRect, CGRect outerRect) {
	CGFloat scaleFactor = MIN(outerRect.size.width/innerRect.size.width, outerRect.size.width/innerRect.size.width);
	CGAffineTransform translation = 
	CGAffineTransformMakeTranslation((outerRect.size.width - innerRect.size.width * scaleFactor) / 2, 
									 (outerRect.size.height - innerRect.size.height * scaleFactor) / 2);
	CGAffineTransform scale = CGAffineTransformMakeScale(scaleFactor, scaleFactor);
	return CGAffineTransformConcat(scale, translation);
}
