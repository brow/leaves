//
//  ExamplesViewController.m
//  Leaves
//
//  Created by Tom Brow on 4/20/10.
//  Copyright 2010 Tom Brow. All rights reserved.
//

#import "ExamplesViewController.h"
#import "PDFExampleViewController.h"
#import "ImageExampleViewController.h"

@implementation ExamplesViewController



- (id)init {
    if ((self = [super initWithStyle:UITableViewStyleGrouped])) {
		exampleViewControllers = [[NSArray alloc] initWithObjects:
								  [[[PDFExampleViewController alloc] init] autorelease],
								  [[[ImageExampleViewController alloc] init] autorelease],
								  nil];
    }
    return self;
}

- (void)dealloc {
	[exampleViewControllers release];
    [super dealloc];
}


#pragma mark -
#pragma mark View lifecycle

/*
- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to preserve selection between presentations.
    self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
*/

#pragma mark UITableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [exampleViewControllers count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	switch (indexPath.row) {
		case 0: cell.textLabel.text = @"PDF example"; break;
		case 1: cell.textLabel.text = @"Image example"; break;
		default: cell.textLabel.text = @"";
	}    
    return cell;
}

#pragma mark UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UIViewController *viewController = [exampleViewControllers objectAtIndex:indexPath.row];
	[self.navigationController pushViewController:viewController animated:YES];
}


@end

