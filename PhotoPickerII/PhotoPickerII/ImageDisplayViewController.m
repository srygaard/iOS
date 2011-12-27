//
//  ImageDisplayViewController.m
//  PhotoPickerII
//
//  Created by MLIB116M66 on 10/15/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ImageDisplayViewController.h"


@implementation ImageDisplayViewController


- (id)init 
{
    self = [super init];
    
    if (self) {
		// Grab a pointer to the singleton of PhotoPhactory
        photoPhactory = [PhotoPhactory sharedSingleton];
    }
    
    return self;
}

// Required by the delegate for zooming in on images
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
	return imageDisplay;
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
    }
    return self;
}

- (void)dealloc
{
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
    [imageScroll initWithFrame:[[UIScreen mainScreen]applicationFrame]];
    imageScroll.contentSize = imageDisplay.frame.size;
	
	// Load the active photo from photophactory
    [imageDisplay setImage:[UIImage imageNamed:[photoPhactory activePhotoFileName]]];
    self.navigationItem.title = [photoPhactory activePhotoFileName];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidUnload
{
    
    [imageScroll release];
    [imageDisplay release];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
}

@end
