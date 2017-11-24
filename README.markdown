# Leaves

Leaves is an animated interface for navigating through a sequence of images
using page-turning gestures. As of iOS 5, Leaves is mostly obsoleted by
[UIPageViewController].

Leaves requires iOS 3.0 or later.

## Installation

1. Add the files in the `Leaves` subdirectory to your Xcode project.
2. Ensure that your target links against `QuartzCore.framework`.

## Usage

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

## Forks
* [Two-page view](https://github.com/ole/leaves/tree/twopages) by [ole](https://github.com/ole) ([blog post](http://oleb.net/blog/2010/06/app-store-safe-page-curl-animations/))
* [Zooming](https://github.com/hammerlyrodrigo/leaves) by [hammerlyrodrigo](https://github.com/hammerlyrodrigo)
* [ARC](https://github.com/tjboudreaux/leaves) by [tjboudreaux](https://github.com/tjboudreaux)
* [Retina support](https://github.com/Vortec4800/leaves) by [Vortec4800](https://github.com/Vortec4800)

## Articles
* [App Store-safe Page Curl animations](http://oleb.net/blog/2010/06/app-store-safe-page-curl-animations/)
* [How To Add A Slick iBooks Like Page Turning Effect Into Your Apps](http://maniacdev.com/2010/06/lick-ibooks-like-page-turning-effect)
* [Building an iPad Reader for _War of the Worlds_](http://mobile.tutsplus.com/tutorials/iphone/building-an-ipad-reader-for-war-of-the-worlds/)

[UIPageViewController]: https://developer.apple.com/library/ios/documentation/uikit/reference/UIPageViewControllerClassReferenceClassRef/UIPageViewControllerClassReference.html
[LeavesViewController]: https://github.com/brow/leaves/blob/master/Leaves/LeavesViewController.h
[LeavesView]: https://github.com/brow/leaves/blob/master/Leaves/LeavesView.h
