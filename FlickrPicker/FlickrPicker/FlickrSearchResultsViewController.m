//
//  FlickrSearchResults.m
//  FlickrPicker
//
//  Created by MLIB116M65 on 10/30/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FlickrSearchResultsViewController.h"


@implementation FlickrSearchResultsViewController


// Customize the number of sections in the table view.
- (NSInteger)numberOfSectionsInTableView:tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if([[jsonParser getTitleArray] count] ==0){
        return 1;
    }
    else{
        return [[jsonParser getTitleArray] count];
    }
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableViewD cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Identifier for retrieving reusable cells.
    static NSString *cellIdentifier = @"MyCellIdentifier";
    
    // Attempt to request the reusable cell.
    UITableViewCell *cell = [tableViewD dequeueReusableCellWithIdentifier:cellIdentifier];
    
    // No cell available - create one.
    if(cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault
                                      reuseIdentifier:cellIdentifier];
        [cell setAccessoryType:UITableViewCellAccessoryDetailDisclosureButton];
    }
    
    // Set the text of the cell to the row index.
    cell.textLabel.text = @"Loading...";

    
    if ([[jsonParser getTitleArray] count] > indexPath.row){
        cell.textLabel.text = [[jsonParser getTitleArray] objectAtIndex:indexPath.row];
        cell.imageView.image = [UIImage imageWithData:[NSData dataWithContentsOfURL:[jsonParser getTinyImageURL:indexPath.row]]];
        cell.accessibilityLabel = @"hi";
    }
    
    return cell;
}

// Called by message when the JSON query is done
-(void) reloadTableViewData{
    [tableView reloadData];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [jsonParser setActivePhotoArrayPos:indexPath.row]; 
    [imageDisplayInfo setURL: [jsonParser getActivePhotoURL]];
    [imageDisplayInfo setImageTag:[jsonParser getActiveTag]];
    
    ImageDisplayViewController *imageDisplayViewController = [ImageDisplayViewController alloc];
    // Pass the selected object to the new view controller.
    [self.navigationController pushViewController:imageDisplayViewController animated:YES];
    [imageDisplayViewController release];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)dealloc
{
    [jsonParser release];
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
    jsonParser = [[JsonParser alloc] init];
    jsonParserSingleton = [JsonParser sharedSingleton];
    searchTerms = [SearchTerms sharedSearchTerms];
    imageDisplayInfo = [ImageDisplayInfo sharedSingleton];
    self.title = [searchTerms getSeachTerm];

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadTableViewData) name:@"ReloadRootViewControllerTable" object:nil];
    
    [jsonParser searchFlickr:[searchTerms getSeachTerm]];


    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
