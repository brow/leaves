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
    if (self = [super init]) {
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

@end
