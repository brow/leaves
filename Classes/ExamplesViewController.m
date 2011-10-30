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
#import "ProceduralExampleViewController.h"

enum {PDF, IMAGE, PROCEDURAL, NUM_EXAMPLES};

@implementation ExamplesViewController

- (id)init {
    if ((self = [super initWithStyle:UITableViewStyleGrouped])) {
    }
    return self;
}


#pragma mark UITableViewDataSource methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return NUM_EXAMPLES;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
	switch (indexPath.row) {
		case PDF: cell.textLabel.text = @"PDF example"; break;
		case IMAGE: cell.textLabel.text = @"Image example"; break;
		case PROCEDURAL: cell.textLabel.text = @"Procedural example"; break;
		default: cell.textLabel.text = @"";
	}    
    return cell;
}

#pragma mark UITableViewDelegate methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	UIViewController *viewController;
	switch (indexPath.row) {
		case PDF: 
			viewController = [[PDFExampleViewController alloc] init];
			break;
		case IMAGE: 
			viewController = [[ImageExampleViewController alloc] init]; 
			break;
		case PROCEDURAL:
			viewController = [[ProceduralExampleViewController alloc] init]; 
			break;
		default: 
			viewController = [[UIViewController alloc] init];
	} 
	[self.navigationController pushViewController:viewController animated:YES];
}


@end

