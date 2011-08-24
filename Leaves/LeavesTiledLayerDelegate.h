//
//  LeavesTiledLayerDelegate.h
//  Leaves
//
//  Created by Rodrigo Hammerly on 8/24/11.
//  Copyright 2011 Tom Brow. All rights reserved.
//

#import <Foundation/Foundation.h>
@protocol LeavesViewDataSource;

@interface LeavesTiledLayerDelegate : NSObject {
	id<LeavesViewDataSource> dataSource;
    NSInteger pageIndex;
}

@property (assign) id<LeavesViewDataSource> dataSource;
@property (assign) NSInteger pageIndex;

- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)context;
@end
