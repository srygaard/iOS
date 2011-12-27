//
//  CategoriesViewController.m
//  PhotoPickerII
//
//  Created by MLIB116M66 on 10/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.

#import "CategoriesViewController.h"

@implementation CategoriesViewController


- (NSInteger) tableView:(UITableView *)tableView 
  numberOfRowsInSection:(NSInteger)section
{
    return [photoPhactory photoCategoryCount];
}

- (UITableViewCell *)tableView:(UITableView *)tableView 
         cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    // Identifier for retrieving reusable cells.
    static NSString *cellIdentifier = @"MyCellIdentifier";
    
    // Attempt to request the reusable cell.
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // No cell available - create one.
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellIdentifier];
        [cell setAccessoryType:UITableViewCellAccessoryDisclosureIndicator];

    }
    
    // Set the text of the cell to the row index.
    cell.textLabel.text = [photoPhactory catagoryNameAtIndex:indexPath.row];

   return cell;
}

- (id)initWithNibName:(NSString *)nibNameOrNil 
               bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [photoPhactory setActiveCatagory:indexPath.row];
    ImageSelectorViewController *imageSelectorController = [[ImageSelectorViewController alloc] init];
    
    [self.navigationController pushViewController:imageSelectorController animated:YES];
    
}

- (void)dealloc
{
    [PhotoPhactory release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    self.navigationItem.title = @"Categories";
    photoPhactory = [PhotoPhactory sharedSingleton];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [photoPhactory autorelease];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
