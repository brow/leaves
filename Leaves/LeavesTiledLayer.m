//
//  LeavesTiledLayer.m
//  Leaves
//
//  Created by Rodrigo Hammerly on 8/24/11.
//  Copyright 2011 Tom Brow. All rights reserved.
//

#import "LeavesTiledLayer.h"

#define ZOOM_LEVELS 5

@implementation LeavesTiledLayer

+ (CFTimeInterval)fadeDuration
{
	return 0.0; // No fading wanted
}

+ (id<CAAction>)defaultActionForKey:(NSString *)event
{
    return nil;
}
#pragma mark LeavesTiledLayer instance methods

- (id)init
{
	if ((self = [super init]))
	{
		self.levelsOfDetail = ZOOM_LEVELS;
        
		self.levelsOfDetailBias = (ZOOM_LEVELS - 1);
        
		CGFloat screenScale; // Points to pixels
        
		UIScreen *mainScreen = [UIScreen mainScreen];
        
		if ([mainScreen respondsToSelector:@selector(scale)])
			screenScale = [mainScreen scale];
		else
			screenScale = 1.0f;
        
		CGRect screenBounds = [mainScreen bounds]; // Is in points
        
		CGFloat w_pixels = (screenBounds.size.width * screenScale);
		CGFloat h_pixels = (screenBounds.size.height * screenScale);
        
		CGFloat max = (w_pixels < h_pixels) ? h_pixels : w_pixels;
        
		CGFloat sizeOfTiles = (max < 512.0f) ? 512.0f : 1024.0f;
        
		self.tileSize = CGSizeMake(sizeOfTiles, sizeOfTiles);
        self.backgroundColor = [UIColor clearColor].CGColor;
	}
    
	return self;
}

@end