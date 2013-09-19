//
//  ExamplesViewController.m
//  LeavesExamples
//
//  Created by Tom Brow on 4/20/10.
//  Copyright 2010 Tom Brow. All rights reserved.
//

#import "ExamplesViewController.h"
#import "PDFExampleViewController.h"
#import "ImageExampleViewController.h"
#import "ProceduralExampleViewController.h"

enum {ExamplePDF, ExampleImage, ExampleProcedural, NumExamples};

@implementation ExamplesViewController

- (id)init {
    if (self = [super initWithStyle:UITableViewStyleGrouped]) {
    }
    return self;
}

#pragma mark UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return NumExamples;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
	switch (indexPath.row) {
		case ExamplePDF: cell.textLabel.text = @"PDF example"; break;
		case ExampleImage: cell.textLabel.text = @"Image example"; break;
		case ExampleProcedural: cell.textLabel.text = @"Procedural example"; break;
		default: cell.textLabel.text = @"";
	}    
    return cell;
}

#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	UIViewController *viewController;
	switch (indexPath.row) {
		case ExamplePDF:
			viewController = [[[PDFExampleViewController alloc] init] autorelease];
			break;
		case ExampleImage:
			viewController = [[[ImageExampleViewController alloc] init] autorelease]; 
			break;
		case ExampleProcedural:
			viewController = [[[ProceduralExampleViewController alloc] init] autorelease]; 
			break;
		default: 
			viewController = nil;
	}
    
    if (viewController)
        [self.navigationController pushViewController:viewController animated:YES];
}


@end

