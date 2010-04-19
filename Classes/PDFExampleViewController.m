    //
//  PDFExampleViewController.m
//  Leaves
//
//  Created by Tom Brow on 4/19/10.
//  Copyright 2010 Tom Brow. All rights reserved.
//

#import "PDFExampleViewController.h"


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

- (CGAffineTransform) aspectFitRect:(CGRect)pageRect inRect:(CGRect)contextRect {
	CGFloat scaleFactor = MIN(contextRect.size.width/pageRect.size.width, contextRect.size.width/pageRect.size.width);
	CGAffineTransform translation = 
		CGAffineTransformMakeTranslation((contextRect.size.width - pageRect.size.width * scaleFactor) / 2, 
										 (contextRect.size.height - pageRect.size.height * scaleFactor) / 2);
	CGAffineTransform scale = CGAffineTransformMakeScale(scaleFactor, scaleFactor);
	return CGAffineTransformConcat(scale, translation);
}

#pragma mark LeavesViewDataSource methods

- (NSUInteger) numberOfPagesInLeavesView:(LeavesView*)leavesView {
	return CGPDFDocumentGetNumberOfPages(pdf);
}

- (void) renderPageAtIndex:(NSUInteger)index inContext:(CGContextRef)ctx {
	CGPDFPageRef page = CGPDFDocumentGetPage(pdf, index + 1);
	CGAffineTransform transform = [self aspectFitRect:CGPDFPageGetBoxRect(page, kCGPDFMediaBox) 
											   inRect:CGContextGetClipBoundingBox(ctx)
								   ];
	CGContextConcatCTM(ctx, transform);
	CGContextDrawPDFPage(ctx, page);
}

#pragma mark UIViewController methods

- (void) viewDidLoad {
	[super viewDidLoad];
	leavesView.dataSource = self;
	leavesView.delegate = self;
	[leavesView reloadData];
}
@end
