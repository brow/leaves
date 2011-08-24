//
//  LeavesViewController.m
//  Leaves
//
//  Created by Tom Brow on 4/18/10.
//  Copyright Tom Brow 2010. All rights reserved.
//
#define ZOOM_AMOUNT 0.25f
#define NO_ZOOM_SCALE 1.0f
#define MINIMUM_ZOOM_SCALE 1.0f
#define MAXIMUM_ZOOM_SCALE 5.0f

#import "LeavesViewController.h"

@implementation LeavesViewController

- (void) initialize {
    leavesView = [[LeavesView alloc] initWithFrame:CGRectZero];
    leavesScrollView = [[UIScrollView alloc] initWithFrame:CGRectZero];
}

- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)nibBundle
{
   if ((self = [super initWithNibName:nibName bundle:nibBundle]) ) {
      [self initialize];
   }
   return self;
}

- (id)init {
   return [self initWithNibName:nil bundle:nil];
}

- (void) awakeFromNib {
	[super awakeFromNib];
	[self initialize];
}

- (void)dealloc {
	[leavesView release];
    [super dealloc];
}

#pragma mark LeavesViewDataSource methods

- (NSUInteger) numberOfPagesInLeavesView:(LeavesView*)leavesView {
	return 0;
}

- (void) renderPageAtIndex:(NSUInteger)index inContext:(CGContextRef)ctx {
	
}

#pragma mark  UIViewController methods

- (void)loadView {
	[super loadView];
    leavesScrollView.frame = self.view.bounds;
    leavesScrollView.scrollsToTop = NO;
    leavesScrollView.directionalLockEnabled = YES;
    leavesScrollView.showsVerticalScrollIndicator = NO;
    leavesScrollView.showsHorizontalScrollIndicator = NO;
    leavesScrollView.contentMode = UIViewContentModeRedraw;
    leavesScrollView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    leavesScrollView.minimumZoomScale = MINIMUM_ZOOM_SCALE; 
    leavesScrollView.maximumZoomScale = MAXIMUM_ZOOM_SCALE;
    leavesScrollView.contentSize = leavesScrollView.bounds.size;
    leavesScrollView.backgroundColor = [UIColor clearColor];
    leavesScrollView.delegate = self;    
    leavesScrollView.scrollEnabled = YES;     
    
	leavesView.frame = leavesScrollView.bounds;
	leavesView.autoresizingMask = UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight;
	
    [leavesScrollView addSubview:leavesView];
    
    [self.view addSubview:leavesScrollView];
}

- (void) viewDidLoad {
	[super viewDidLoad];
	leavesView.dataSource = self;
	leavesView.delegate = self;
	[leavesView reloadData];
}

#pragma mark - Scrollview delegate methods
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return leavesView;
}

- (void)scrollViewDidZoom:(UIScrollView *)aScrollView 
{
    NSLog(@"view zoom %f", aScrollView.zoomScale);
    if(aScrollView.zoomScale == 1)
    {
        leavesView.zoomActive = NO;
    }
}

- (void)scrollViewWillBeginZooming:(UIScrollView *)aScrollView withView:(UIView *)view
{
    NSLog(@"view will zoom");
    if(aScrollView.zoomScale == 1) 
    {
        leavesView.zoomActive = YES;
    }
}

@end
