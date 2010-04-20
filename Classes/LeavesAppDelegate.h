//
//  LeavesAppDelegate.h
//  Leaves
//
//  Created by Tom Brow on 4/18/10.
//  Copyright Tom Brow 2010. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LeavesViewController;

@interface LeavesAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    UIViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@end

