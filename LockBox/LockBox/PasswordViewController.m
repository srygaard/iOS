//
//  PasswordViewController.m
//  LockBox
//
//  Created by MLIB116M65 on 12/10/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PasswordViewController.h"


@implementation PasswordViewController

-(IBAction)changeCombo:(id)sender{
    actionSheet = [[UIActionSheet alloc] initWithTitle:@"Enter a new combo" 
                                                             delegate:nil
                                                    cancelButtonTitle:nil
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:nil];
    
    [actionSheet setActionSheetStyle:UIActionSheetStyleBlackTranslucent];
    
    CGRect pickerFrame = CGRectMake(0, 40, 0, 0);
    
    pickerView = [[UIPickerView alloc] initWithFrame:pickerFrame];

    pickerView.showsSelectionIndicator = YES;
    pickerView.dataSource = self;
    pickerView.delegate = self;
    
    [actionSheet addSubview:pickerView];
    [pickerView selectRow:400+[myComboManager getComboNumber:1] inComponent:0 animated:NO];
    [pickerView selectRow:400+[myComboManager getComboNumber:2] inComponent:1 animated:NO];
    [pickerView selectRow:400+[myComboManager getComboNumber:3] inComponent:2 animated:NO];
    
    UISegmentedControl *closeButton = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObject:@"Save"]];
    closeButton.momentary = YES; 
    closeButton.frame = CGRectMake(260, 7.0f, 50.0f, 30.0f);
    closeButton.segmentedControlStyle = UISegmentedControlStyleBar;
    closeButton.tintColor = [UIColor blackColor];
    [closeButton addTarget:self action:@selector(goAwayActionSheet) forControlEvents:UIControlEventValueChanged];
    [actionSheet addSubview:closeButton];
    [closeButton release];
    
    [actionSheet showInView:[[UIApplication sharedApplication] keyWindow]];
    
    [actionSheet setBounds:CGRectMake(0, 0, 320, 485)];
}

- (IBAction)lockDown:(id)sender{
    
	[UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1.0f];
	
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:self.view.superview cache:YES];
    [self.view removeFromSuperview];

    [UIView commitAnimations];

}


- (void)goAwayActionSheet{
    [actionSheet dismissWithClickedButtonIndex:0 animated:YES];
    [myComboManager savePlist];
    
    secretData.alpha = 0.0;
    [UIView beginAnimations:nil context:nil];
	[UIView setAnimationDuration:1.5f];

    
    secretData.text = [NSString stringWithFormat:@"%i - %i - %i",
                       [myComboManager getComboNumber:1],
                       [myComboManager getComboNumber:2],
                       [myComboManager getComboNumber:3]];
    secretData.alpha = 1;
    [UIView commitAnimations];

}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)thePickerView {
    
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)thePickerView numberOfRowsInComponent:(NSInteger)component {
    return 800;
}

- (NSString *)pickerView:(UIPickerView *)thePickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    return [NSString stringWithFormat:@"%i", row%40];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    [myComboManager setComboNumber:component+1:(row%40)];

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
    [pickerView release];
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
    myComboManager = [ComboManager sharedSingleton];
    secretData.text = [NSString stringWithFormat:@"%i - %i - %i",[myComboManager getComboNumber:1],[myComboManager getComboNumber:2],[myComboManager getComboNumber:3]];
    keychain = [[KeychainItemWrapper alloc] initWithIdentifier:@"TestAppLoginData" accessGroup:nil];
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
