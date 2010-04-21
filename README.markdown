#Leaves

Leaves is handful of classes that make it easy to present PDFs and images in a page-turning interface similar to Apple's iBooks.  Leaves uses only public APIs, sacrificing a small portion of iBooks' visual flair to ensure that Leaves-based applications are safe for submission to the App Store.

Leaves supports:

- Text, images, PDFs -- anything that can be rendered in graphics context
- Drag to turn the page
- Tap to turn the page

Leaves does *not* currently support:

- Interactive elements on the page
- Swipe to turn the page
- Two-page landscape view

#Installation

Add the files in the `Leaves` directory to your XCode project.

#Getting Started

Creating a page-turning interface is as simple as subclassing `LeavesViewController`:

	@interface ColorSwatchViewController : LeavesViewController
	@end

...and implementing the `LeavesViewDataSource` protocol:

	@implementation ColorSwatchViewController

	- (NSUInteger) numberOfPagesInLeavesView:(LeavesView*)leavesView {
		return 10;
	}

	- (void) renderPageAtIndex:(NSUInteger)index inContext:(CGContextRef)ctx {
		CGContextSetFillColorWithColor(ctx, [[UIColor colorWithHue:index/10.0 
														saturation:0.8
														brightness:0.8 
															 alpha:1.0] CGColor]);
		CGContextFillRect(ctx, CGContextGetClipBoundingBox(ctx));
	}

	@end

A ten-page book of color swatches.  Nice.

@end

#Notes

Leaves is still in early development. Future revisions may break the existing API.  Pull requests are welcome.