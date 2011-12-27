//
//  calculatorViewController.m
//  calculator
//
//  Created by Steven Rygaard on 9/19/11.
//  Copyright 2011 Steven Rygaard. All rights reserved.
//

#import "calculatorViewController.h"
#import "calculator.h"

@implementation calculatorViewController

@synthesize calc;
/** 
	calc creates a new instance of the calculator class
*/
- (calculator*)calc  
{
    if(!calc)
    {
        calc = [[calculator alloc] init];
    }
    return calc;
}

/**
	numberPressed is the handler for user number input and supports appended numbers
*/
- (IBAction)numberPressed:(id)sender
{
    numberID = (int)[sender tag];  // Get the button id; #n = id n
    if(numberInProgress)
    {
		// Create a string when a number button is pressed
		NSString *numberIDString = [NSString stringWithFormat:@"%i", numberID];
		
		// Append the number button to an ongoing string
		NSString *value = [calcDisplay.text stringByAppendingString:numberIDString];
		
		// Output the newly appended string to the disply
		calcDisplay.text = value;
		
		// Set the number entered in the calculator class instance
		[calc setNumber:[value doubleValue]];

    }

    else
    {   
        calcDisplay.text = [NSString stringWithFormat:@"%i", numberID];
        [calc setNumber:numberID];
        numberInProgress = TRUE; 
    }
}

/**
	operatorPressed is the handler for button events
*/
- (IBAction)operatorPressed:(id)sender
{
	// Once an operation is pressed, the number entered is no longer appended
    numberInProgress = FALSE;

    operationID = (int)[sender tag];
    
    if (operationID == 5) // Invert the number on the display
    {
        [calc setScreenNumber:[calcDisplay.text doubleValue]];
        [calc setOperation:operationID]; 
        [calc performMath];
        calcDisplay.text = [NSString stringWithFormat:@"%g", [calc returnAnswer]];
    }
    if (operationID == 6) // Clear the variables and display to zero
    {
        [calc setOperation:operationID]; 
        [calc performMath];
        calcDisplay.text = [NSString stringWithFormat:@"%i", [calc returnAnswer]];
    }
    if (operationID == 7) // Clear Memory to 0.0
    {
        [calc setOperation:operationID];
    }
    if (operationID == 10) // Memory Recall
    {
        calcDisplay.text = [NSString stringWithFormat:@"%g", [calc returnMem]];
    }
    if (operationID == 11) // Insert Decimal
    {
        if (decimalPlaced == FALSE) 
        {
            calcDisplay.text = [calcDisplay.text stringByAppendingString:@"."];
            numberInProgress = TRUE;
            decimalPlaced = TRUE;
        }

    }
    if (operationID == 14 ||  // Pi
        operationID == 15 ||  // Sin
        operationID == 16 ||  // Cos
        operationID == 17 ||  // Tan
        operationID == 18     // Sqrt
        )
    {
        [calc setScreenNumber:[calcDisplay.text doubleValue]];
        [calc setOperation:operationID]; 
        [calc performMath];
        calcDisplay.text = [NSString stringWithFormat:@"%g", [calc returnAnswer]];
    }
	
    else  // this else is for standard math (+,-,/,*)
    {
        decimalPlaced = FALSE;
        [calc setScreenNumber:[calcDisplay.text doubleValue]];
        [calc setOperation:operationID]; 
        [calc performMath];
    }
}

/**
	findResult is called when the = button is pressed
*/
- (IBAction)findResult:(id)sender
{
    numberInProgress = FALSE;
    [calc setNumber:[calcDisplay.text doubleValue]];
    [calc performMath];
    calcDisplay.text = [NSString stringWithFormat:@"%g", [calc returnAnswer]];
}

- (void)dealloc
{
    [calc release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    [super viewDidLoad];
    calcDisplay.font = [UIFont fontWithName:@"DBLCDTempBlack" size:48];
    calc = [[calculator alloc] init];
}


- (void)viewDidUnload
{
    [self setCalc: nil];
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
