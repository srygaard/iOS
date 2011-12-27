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
}




#pragma mark - View lifecycle

- (void)viewDidLoad
{
	// Grab the image info singleton that contains the URL and Name
    imageDisplayInfo = [ImageDisplayInfo sharedSingleton];
	
	// Create an UIImage from the URL of the clicked item
    NSData * imageData = [NSData dataWithContentsOfURL:[imageDisplayInfo getURL]];
    image = [UIImage imageWithData:imageData];
    [imageDisplay setImage:image];
    
	// Build the image scroll view with the size of the screen
    [imageScroll initWithFrame:[[UIScreen mainScreen]applicationFrame]];
    imageScroll.contentSize = imageDisplay.frame.size;

    // Set the title of the window
    self.navigationItem.title = [imageDisplayInfo getImageTag];
    
	// Create an email button to the navigation bar
	emailButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(emailButtonClicked:)] autorelease];
    
    // Create a spacer so that the mail button is aligned to the right
    UIBarButtonItem *spacer = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    NSArray *buttons = [NSArray arrayWithObjects:spacer,emailButton,nil];
    
    // Place the emial button
    [toolBar setItems:buttons animated:YES];
    [super viewDidLoad];
}

// On click handler for the email button clicking
- (IBAction) emailButtonClicked:(id)sender{
    UIActionSheet *popupQuery = [[UIActionSheet alloc] 
                                 initWithTitle:@"Share Image" 
                                 delegate:self 
                                 cancelButtonTitle:@"Cancel" 
                                 destructiveButtonTitle:nil 
                                 otherButtonTitles:@"Email", nil];
    
    popupQuery.actionSheetStyle = UIActionSheetStyleBlackOpaque;
    [popupQuery showInView:self.view];
    [popupQuery release];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 0) {
        [self showEmailModalView];
	}
}


-(void) showEmailModalView {
    
    MFMailComposeViewController *picker = [[MFMailComposeViewController alloc] init];
    picker.mailComposeDelegate = self;
    
    [picker setSubject:@"Awesome Flickr Picture!"];

    UIImage *attachment = image;
    
    NSData *imageData = UIImageJPEGRepresentation(attachment, 1);     
    [picker addAttachmentData:imageData mimeType:@"image/jpg" fileName:@"atachment.jpg"];
    
    NSString *emailBody = [NSString stringWithFormat:@"%@\n\n ", @"Sent from The FlickrPicker"];
    
    [picker setMessageBody:emailBody isHTML:YES]; 
    
    picker.navigationBar.barStyle = UIBarStyleBlack;
    
    [self presentModalViewController:picker animated:YES];
    [picker release];
    
}

- (void)mailComposeController:(MFMailComposeViewController*)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{ 
    [self dismissModalViewControllerAnimated:YES];
}

- (void)viewDidUnload
{
    [imageScroll release];
    [imageDisplay release];
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    //return (interfaceOrientation == UIInterfaceOrientationPortrait);
    return YES;
}

@end
