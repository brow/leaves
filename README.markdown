#Leaves

Leaves is a simple way to present a page-turning interface similar to Apple's iBooks.  It comprises two classes, `LeavesView` and `LeavesViewController`, and occupies less than 100 kB compiled.  It uses only public APIs, sacrificing a portion of iBooks' visual flair to ensure that your application is safe for submission to the App Store.

Leaves supports:

- Text, images, PDFs -- anything that can be rendered in a graphics context
- Drag or tap to turn the page
- iPad- and iPhone-sized display areas 

Leaves does *not* currently support:

- Interactive elements on the page
- Swipe gestures
- Two-page landscape view

Leaves requires iPhone OS 3.0 or later.

#Installation

Add the files in the `Leaves` subdirectory to your Xcode project and ensure that you are linking against `QuartzCore.framework`.

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

For more sophisticated examples, build the Xcode project included with Leaves.

#Notes

The best way to get an answer to your question about programming with Leaves is the [Leaves Developers mailing list](http://groups.google.com/group/leaves-developers), which I keep an eye on.  But if you find a bug, be sure to visit the [tracker](http://github.com/brow/leaves/issues) or message me directly.