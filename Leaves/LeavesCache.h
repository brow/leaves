//
//  LeavesCache.h
//  Reader
//
//  Created by Tom Brow on 5/12/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol LeavesViewDataSource;

@interface LeavesCache : NSObject {
	NSMutableDictionary *pageCache;
	id<LeavesViewDataSource> dataSource;
	CGSize pageSize;
}

@property (assign) CGSize pageSize;
@property (assign) id<LeavesViewDataSource> dataSource;

- (id) initWithPageSize:(CGSize)aPageSize;
- (CGImageRef) cachedImageForPageIndex:(NSUInteger)pageIndex;
- (void) precacheImageForPageIndex:(NSUInteger)pageIndex;
- (void) minimizeToPageIndex:(NSUInteger)pageIndex;
- (void) flush;

@end
