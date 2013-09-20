#Leaves

Leaves is an animated interface for navigating through a sequence of images
using page-turning gestures. As of iOS 5, Leaves is mostly obsoleted by
[UIPageViewController].

Leaves requires iOS 3.0 or later.

##Installation

1. Add the files in the `Leaves` subdirectory to your Xcode project.
2. Ensure that your target links against `QuartzCore.framework`.

##Usage

Creating a page-turning view controller is as simple as subclassing
[LeavesViewController][]:

    #import "LeavesViewController.h"

    @interface ColorSwatchViewController : LeavesViewController 
    @end

...and implementing the [LeavesViewDataSource][LeavesView] protocol:

    @implementation ColorSwatchViewController

    - (NSUInteger)numberOfPagesInLeavesView:(LeavesView*)leavesView { 
        return 10;
    }

    - (void)renderPageAtIndex:(NSUInteger)index inContext:(CGContextRef)context { 
        CGContextSetFillColorWithColor(
            context, 
            [[UIColor colorWithHue:index/10.0 
                        saturation:0.8 
                        brightness:0.8 
                             alpha:1.0] CGColor]);
        CGContextFillRect(ctx, CGContextGetClipBoundingBox(ctx));
    }

    @end

You may also use [LeavesView] directly. For more examples, see the included
`LeavesExamples` project.

[UIPageViewController]: https://developer.apple.com/library/ios/documentation/uikit/reference/UIPageViewControllerClassReferenceClassRef/UIPageViewControllerClassReference.html
[LeavesViewController]: https://github.com/brow/leaves/blob/master/Leaves/LeavesViewController.h
[LeavesView]: https://github.com/brow/leaves/blob/master/Leaves/LeavesView.h
