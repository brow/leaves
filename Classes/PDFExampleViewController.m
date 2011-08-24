    //
//  PDFExampleViewController.m
//  Leaves
//
//  Created by Tom Brow on 4/19/10.
//  Copyright 2010 Tom Brow. All rights reserved.
//

#import "PDFExampleViewController.h"
#import "Utilities.h"

@implementation PDFExampleViewController

- (id)init {
    if ((self = [super init])) {
		CFURLRef pdfURL = CFBundleCopyResourceURL(CFBundleGetMainBundle(), CFSTR("paper.pdf"), NULL, NULL);
		pdf = CGPDFDocumentCreateWithURL((CFURLRef)pdfURL);
		CFRelease(pdfURL);
    }
    return self;
}

- (void)dealloc {
	CGPDFDocumentRelease(pdf);
    [super dealloc];
}

- (void) displayPageNumber:(NSUInteger)pageNumber {
	self.navigationItem.title = [NSString stringWithFormat:
								 @"Page %u of %u", 
								 pageNumber, 
								 CGPDFDocumentGetNumberOfPages(pdf)];
}

#pragma mark  LeavesViewDelegate methods

- (void) leavesView:(LeavesView *)leavesView willTurnToPageAtIndex:(NSUInteger)pageIndex {
	[self displayPageNumber:pageIndex + 1];
}

#pragma mark LeavesViewDataSource methods

- (NSUInteger) numberOfPagesInLeavesView:(LeavesView*)leavesView {
	return CGPDFDocumentGetNumberOfPages(pdf);
}

- (void) renderPageAtIndex:(NSUInteger)index inContext:(CGContextRef)ctx {
	CGPDFPageRef page = CGPDFDocumentGetPage(pdf, index + 1);
	CGAffineTransform transform = aspectFit(CGPDFPageGetBoxRect(page, kCGPDFMediaBox),
											CGContextGetClipBoundingBox(ctx));
	CGContextConcatCTM(ctx, transform);
	CGContextDrawPDFPage(ctx, page);
}

- (void)renderTiledPageAtIndex:(NSUInteger)index forLayer:(LeavesTiledLayer*)layer inContext:(CGContextRef)ctx
{
	CGPDFPageRef drawPDFPageRef = NULL;
    
	@synchronized(self) // Block any other threads
	{
		drawPDFPageRef = CGPDFPageRetain( CGPDFDocumentGetPage(pdf, index + 1) );
	}
    
	if (drawPDFPageRef != NULL) // Render the page into the context
	{
        CGContextSetRGBFillColor(ctx, 1.0f, 1.0f, 1.0f, 1.0f); // White 
        
        CGContextFillRect(ctx, CGContextGetClipBoundingBox(ctx));
        
		CGFloat boundsHeight = layer.frame.size.height;
        
		if (CGPDFPageGetRotationAngle(drawPDFPageRef) == 0)
		{
			CGFloat boundsWidth = layer.frame.size.width; // View width
            
			CGRect cropBoxRect = CGPDFPageGetBoxRect(drawPDFPageRef, kCGPDFCropBox);
			CGRect mediaBoxRect = CGPDFPageGetBoxRect(drawPDFPageRef, kCGPDFMediaBox);
			CGRect effectiveRect = CGRectIntersection(cropBoxRect, mediaBoxRect);
            
			CGFloat effectiveWidth = effectiveRect.size.width;
			CGFloat effectiveHeight = effectiveRect.size.height;
            
			CGFloat widthScale = (boundsWidth / effectiveWidth);
			CGFloat heightScale = (boundsHeight / effectiveHeight);
            
			CGFloat scale = (widthScale < heightScale) ? widthScale : heightScale;
            
			CGFloat x_offset = ((boundsWidth - (effectiveWidth * scale)) / 2.0f);
			CGFloat y_offset = ((boundsHeight - (effectiveHeight * scale)) / 2.0f);
            
			y_offset = (boundsHeight - y_offset); // Co-ordinate system adjust
            
			CGFloat x_translate = (x_offset - (effectiveRect.origin.x * scale));
			CGFloat y_translate = (y_offset + (effectiveRect.origin.y * scale));
            
			CGContextTranslateCTM(ctx, x_translate, y_translate);
            
			CGContextScaleCTM(ctx, scale, -scale); // Mirror Y
		}
		else // Use CGPDFPageGetDrawingTransform for pages with rotation (AKA kludge)
		{
			CGContextTranslateCTM(ctx, 0.0f, boundsHeight); CGContextScaleCTM(ctx, 1.0f, -1.0f);
            
			CGContextConcatCTM(ctx, CGPDFPageGetDrawingTransform(drawPDFPageRef, kCGPDFCropBox, layer.bounds, 0, true));
		}
        
		CGContextDrawPDFPage(ctx, drawPDFPageRef);
	}
    
	CGPDFPageRelease(drawPDFPageRef); // Cleanup
    
}

#pragma mark UIViewController

- (void) viewDidLoad {
	[super viewDidLoad];
	leavesView.backgroundRendering = YES;
	[self displayPageNumber:1];
}

@end
