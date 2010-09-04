//
//  OverlayExampleViewController.h
//  Leaves
//
//  Created by Robert Simpson on 8/26/10.
//  Copyright 2010 Tom Brow. All rights reserved.
//

#import "LeavesViewController.h"

@class OverlayView;

@interface OverlayExampleViewController : LeavesViewController {

   OverlayView * overlayView;
   
   UISwitch * onOffSwitch;
   
   UILabel * label;

}

@property (nonatomic, retain) IBOutlet OverlayView * overlayView;

@property (nonatomic, retain) IBOutlet UISwitch * onOffSwitch;

@property (nonatomic, retain) IBOutlet UILabel * label;

- (IBAction)switchValueChanged:(id)sender;

@end
