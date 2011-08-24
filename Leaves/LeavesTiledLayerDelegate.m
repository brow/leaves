//
//  LeavesTiledLayerDelegate.m
//  Leaves
//
//  Created by Rodrigo Hammerly on 8/24/11.
//  Copyright 2011 Tom Brow. All rights reserved.
//

#import "LeavesTiledLayerDelegate.h"
#import "LeavesView.h"

@implementation LeavesTiledLayerDelegate

@synthesize dataSource;
@synthesize pageIndex;

- (id)init {
    
    if ((self = [super init])) {
        self.pageIndex = 0;
    }
    
    return self;
}

#pragma mark LeavesViewTiledLayer delegated methods
- (void)drawLayer:(CALayer *)layer inContext:(CGContextRef)context {
    
    [self.dataSource renderTiledPageAtIndex:self.pageIndex forLayer:layer inContext:context];       

}

@end
